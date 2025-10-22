import {
    Breadcrumb, Button, Card, Carousel, Col, Form,
    Modal, Row,
    Spin,
    notification, TimePicker, DatePicker, Select, Calendar
} from "antd";
import Paragraph from "antd/lib/typography/Paragraph";
import React, { useEffect, useState } from "react";
import { useHistory, useParams } from "react-router-dom";
import courtsManagementApi from "../../../apis/courtsManagementApi";
import triangleTopRight from "../../../assets/icon/Triangle-Top-Right.svg";
import { numberWithCommas } from "../../../utils/common";
import bookingApi from "../../../apis/bookingApi";
import dayjs from 'dayjs';
import moment from "moment";
import userApi from "../../../apis/userApi";
import vnpayApi from "../../../apis/vnpay.service";
import "./productDetail.css";
const { Option } = Select;

const ProductDetail = () => {
    const [productDetail, setProductDetail] = useState([]);
    const [recommend, setRecommend] = useState([]);
    const [loading, setLoading] = useState(true);
    const [form] = Form.useForm();
    let { id } = useParams();
    const history = useHistory();

    const handleReadMore = (id) => {
        console.log(id);
        history.push("/product-detail/" + id);
        window.location.reload();
    };


    const [reviews, setProductReview] = useState([]);
    const [reviewsCount, setProductReviewCount] = useState([]);
    const [avgRating, setAvgRating] = useState(null);
    const [bookingCourt, setBookingCourt] = useState([]);

    const [userData, setUserData] = useState([]);

    const [qr, setQR] = useState();

    const handleCategoryList = async () => {
        try {
            await bookingApi.getBookingByCourt(id).then(item => {
                console.log(item);
                setBookingCourt(item);
            })

            await courtsManagementApi.getCourtById(id).then((item) => {
                setProductDetail(item);
                setProductReview(item.reviews);
                setProductReviewCount(item.reviewStats);
                setAvgRating(item.avgRating);
                console.log(((reviewsCount[4] || 0) / reviews.length) * 100);
            });
            await courtsManagementApi.getAllCourts().then((item) => {
                setRecommend(item);
            });
            setLoading(false);

        } catch (error) {
            console.log('Failed to fetch event list:' + error);
        };
    }

    useEffect(() => {
        (async () => {
            try {

                await bookingApi.getBookingByCourt(id).then(async item => {
                    console.log(item);
                    setBookingCourt(item);


                });

                // Lấy thông tin user và role từ localStorage
                const user = localStorage.getItem('user');
                const parsedUser = user ? JSON.parse(user) : null;
                setUserData(parsedUser);

                await courtsManagementApi.getCourtById(id).then(async item => {
                    const res = await userApi.getProfileByID(item.id_users); // Sử dụng await ở đây
                    console.log(res);
                    setQR(res?.image_qr);
                    setProductDetail(item);
                    setProductReview(item.reviews);
                    setProductReviewCount(item.reviewStats);
                    setAvgRating(item.avgRating);
                    console.log(((reviewsCount[4] || 0) / reviews.length) * 100);
                });
                await courtsManagementApi.getAllCourts().then((item) => {
                    setRecommend(item);
                });

                setLoading(false);
            } catch (error) {
                console.log("Failed to fetch event detail:" + error);
            }
        })();
        window.scrollTo(0, 0);
    }, []);

    const handleCancel = (type) => {
        if (type === "create") {
            setOpenModalCreate(false);
        } else {
        }
        console.log('Clicked cancel button');
    };


    const handleOkUser = async (values) => {
        const user = localStorage.getItem('user');
        if (!user) {
            return history.push("/login")
        }
        setLoading(true);
        try {
            const bookingDateTime = dayjs(values.booking_date); // Chuyển đổi booking_date thành đối tượng dayjs
            const startTime = dayjs(values.start_time);
            const endTime = dayjs(values.end_time);
            // Tính thời gian đặt sân (phút)
            const bookingDuration = endTime.diff(startTime, 'minute');
            console.log("thời gian đặt sân", bookingDuration)
            // Tính total_amount
            const totalAmount = ((bookingDuration / 60) * Number(productDetail.price));

            const categoryList = {
                "booking_date": bookingDateTime.format('YYYY-MM-DD'), // Lấy ngày tháng năm
                "payment_method": values.payment_method,
                "start_time": startTime.format('HH:mm'), // Lấy giờ và phút
                "end_time": endTime.format('HH:mm'),
                "user_id": userData.id,
                "court_id": Number(id),
                "total_amount": totalAmount
            };

            if (values.payment_method === 'VNPAY') {
                // Lưu thông tin đặt sân vào localStorage
                localStorage.setItem('pendingBooking', JSON.stringify({
                    ...categoryList,
                    courtName: productDetail.name,
                    timestamp: new Date().getTime() // Thêm timestamp để kiểm tra thời gian
                }));

                // Xử lý thanh toán VNPAY
                const orderInfo = {
                    price: totalAmount,
                    return_url: `${window.location.origin}/booking-success`, // Điều chỉnh URL callback theo nhu cầu
                    ipAddr: window.location.hostname
                };

                const response = await vnpayApi.createPayment(orderInfo);
                window.location.href = response.paymentUrl;
                return;
            }

            setLoading(false);

            return bookingApi.bookCourt(categoryList).then(response => {
                if (response.message === "Booking time conflicts with existing booking") {
                    notification["error"]({
                        message: `Thông báo`,
                        description:
                            'Đặt sân không được trùng',
                    });
                    return;
                }
                if (response === undefined) {
                    notification["error"]({
                        message: `Thông báo`,
                        description:
                            'Đặt sân thất bại',
                    });
                }
                else {
                    notification["success"]({
                        message: `Thông báo`,
                        description:
                            'Đặt sân thành công',
                    });
                    setOpenModalCreate(false);

                    handleCategoryList();
                }
            })

        } catch (error) {
            setLoading(false);
            notification["error"]({
                message: `Thông báo`,
                description: 'Có lỗi xảy ra khi xử lý thanh toán',
            });
            throw error;
        }
    }

    const [openModalCreate, setOpenModalCreate] = useState(false);

    const showModal = () => {
        setOpenModalCreate(true);
    };

    const isButtonDisabled = productDetail.status !== 'active' ? true : false;
    const buttonText = isButtonDisabled ? 'Sân bóng đang đóng' : 'Đặt nhanh kẻo muộn';

    function disabledDate(current) {
        // Vô hiệu hóa tất cả các ngày quá khứ
        return current && current < moment().startOf('day');
    }

    return (
        <div className="product-details-container">
            <Spin spinning={false}>
                <div className="product-details-main">
                    <div className="product-details-content">
                        <div style={{ marginLeft: 5, marginBottom: 10 }}>
                            <Breadcrumb>
                                <Breadcrumb.Item href="http://localhost:3500/home">
                                    {/* <HomeOutlined /> */}
                                    <span>Trang chủ</span>
                                </Breadcrumb.Item>
                                <Breadcrumb.Item href="http://localhost:3500/product-list/643cd88879b4192efedda4e6">
                                    {/* <AuditOutlined /> */}
                                    <span>Sân bóng</span>
                                </Breadcrumb.Item>
                                <Breadcrumb.Item href="">
                                    <span>{productDetail.name}</span>
                                </Breadcrumb.Item>
                            </Breadcrumb>
                        </div>
                        <hr></hr>
                        <Row gutter={12} style={{ marginTop: 20, marginBottom: 20 }}>
                            <Col span={14}>
                                {productDetail?.slide?.length > 0 ? (
                                    <Carousel autoplay className="product-details-carousel">
                                        {productDetail.slide.map((item) => (
                                            <div className="img" key={item}>
                                                <img
                                                    style={{ width: '100%', objectFit: 'cover', height: '400px', borderRadius: '15px' }}
                                                    src={item}
                                                    alt=""
                                                />
                                            </div>
                                        ))}
                                    </Carousel>
                                ) : (
                                    <div className="product-details-image">
                                        <img src={productDetail.image} alt={productDetail.name} />
                                    </div>
                                )}
                            </Col>
                            <Col span={10}>
                                <div className="product-details-price-section" style={{ paddingBottom: 10 }}>
                                    <h1 className="product-details-name">{productDetail.name}</h1>
                                </div>
                                <Card
                                    className="card_total"
                                    bordered={false}
                                    style={{ width: "100%", borderRadius: '15px', boxShadow: '0 8px 25px rgba(0, 0, 0, 0.1)', padding: '10px'  }}
                                >
                                    <div className="product-details-price" >
                                        {Number(productDetail?.price)?.toLocaleString("vi", {
                                            style: "currency",
                                            currency: "VND",
                                        })}/giờ
                                    </div>

                                    <div className="product-details-promotion">
                                        <div className="product-details-promotion-header">
                                            <p>🎉 Ưu đãi đặc biệt</p>
                                        </div>
                                        <div className="product-details-promotion-content">
                                            <a>
                                                ⚽ Đặt sân ngay - Sân bóng chất lượng cao<br />
                                                💰 Khuyến mãi giảm giá cho đặt sân trước<br />
                                                ✨ Sân mới, sạch sẽ và tiện nghi hiện đại
                                            </a>
                                        </div>
                                    </div>

                                    <div className="product-details-amenities">
                                        <div className="product-details-amenity-item">
                                            <div className="product-details-amenity-icon" style={{background: '#3498db'}}>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 16 16">
                                                    <path d="M15.384 6.115a.485.485 0 0 0-.047-.736A12.444 12.444 0 0 0 8 3C5.259 3 2.723 3.882.663 5.379a.485.485 0 0 0-.047.736.518.518 0 0 0 .668.05A11.448 11.448 0 0 1 8 4c2.507 0 4.827.802 6.716 2.164.205.148.49.13.668-.049z"/>
                                                    <path d="M13.229 8.271a.482.482 0 0 0-.063-.745A9.455 9.455 0 0 0 8 6c-1.905 0-3.68.56-5.166 1.526a.48.48 0 0 0-.063.745.525.525 0 0 0 .652.065A8.46 8.46 0 0 1 8 7a8.46 8.46 0 0 1 4.577 1.336c.205.132.48.108.652-.065z"/>
                                                    <path d="M11.06 10.428a.5.5 0 0 0-.098-.76 6.467 6.467 0 0 0-5.924 0 .5.5 0 1 0 .858.514 5.467 5.467 0 0 1 4.306 0 .5.5 0 0 0 .858-.514zM9.5 12a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
                                                </svg>
                                            </div>
                                            <span>Wifi miễn phí</span>
                                        </div>

                                        <div className="product-details-amenity-item">
                                            <div className="product-details-amenity-icon" style={{background: '#27ae60'}}>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 16 16">
                                                    <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
                                                </svg>
                                            </div>
                                            <span>Bãi đỗ xe</span>
                                        </div>

                                        <div className="product-details-amenity-item">
                                            <div className="product-details-amenity-icon" style={{background: '#f39c12'}}>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 16 16">
                                                    <path d="M14 0H2a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM1 3.857C1 3.384 1.448 3 2 3h12c.552 0 1 .384 1 .857v10.286c0 .473-.448.857-1 .857H2c-.552 0-1-.384-1-.857V3.857z"/>
                                                    <path d="M6.5 7a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
                                                </svg>
                                            </div>
                                            <span>Căng tin</span>
                                        </div>

                                        <div className="product-details-amenity-item">
                                            <div className="product-details-amenity-icon" style={{background: '#e74c3c'}}>
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="white" viewBox="0 0 16 16">
                                                    <path d="M5 12V7a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1zM4 7v5a2 2 0 0 0 2 2h4a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2V4a2 2 0 0 0-2-2 2 2 0 0 0-2 2v1a2 2 0 0 0-2 2z"/>
                                                </svg>
                                            </div>
                                            <span>Nước uống</span>
                                        </div>
                                    </div>



                                    <div className="product-details-actions">
                                        <Button
                                            type="primary"
                                            className="product-details-book-btn"
                                            size="large"
                                            onClick={showModal}
                                            disabled={isButtonDisabled}
                                        >
                                            {buttonText}
                                        </Button>
                                    </div>
                                </Card>
                            </Col>
                        </Row>
                        <hr />
                        <div className="product-details-describe">
                            <div className="product-details-title">
                                Lịch sân đã đặt
                            </div>
                            <Calendar
                                dateCellRender={(date) => {
                                    const dateEvents = bookingCourt.filter((booking) => moment(booking.booking_date).isSame(date, 'day'));
                                    return (
                                        <div>
                                            {dateEvents.map((booking, index) => (
                                                <div key={index} style={{fontSize: '10px', background: '#3498db', color: 'white', padding: '2px', borderRadius: '3px', marginBottom: '2px'}}>
                                                    <p style={{margin: 0}}>#{index + 1}</p>
                                                    <p style={{margin: 0}}>{moment(booking.start_time, 'HH:mm').format('HH:mm')}-{moment(booking.end_time, 'HH:mm').format('HH:mm')}</p>
                                                </div>
                                            ))}
                                        </div>
                                    );
                                }}
                            />
                        </div>





                        <hr />
                        <div className="product-details-describe">
                            <div className="product-details-title">
                                Giới thiệu: "{productDetail.name}"
                            </div>
                            <div
                                className="product-details-description"
                                dangerouslySetInnerHTML={{ __html: productDetail.description }}
                            ></div>
                        </div>
                        <hr />
                        <div className="product-details-describe" style={{ marginTop: 20 }}>
                            <div className="product-details-title">Sân bóng bạn có thể quan tâm</div>
                        </div>
                        <Row
                            style={{ marginTop: 40 }}
                            className="row-product"
                        >
                            {recommend?.map((item) => (
                                <Col
                                    xl={{ span: 6 }}
                                    lg={{ span: 6 }}
                                    md={{ span: 12 }}
                                    sm={{ span: 12 }}
                                    xs={{ span: 24 }}
                                    onClick={() => handleReadMore(item.id)}
                                    key={item.id}
                                >
                                    <div className="show-product" style={{ marginRight: 15 }}>
                                        {item.image ? (
                                            <img className="image-product" src={item.image} />
                                        ) : (
                                            <img
                                                className="image-product"
                                                src={require("../../../assets/image/NoImageAvailable.jpg")}
                                            />
                                        )}
                                        <div className='wrapper-products'>
                                            <Paragraph
                                                className='title-product'
                                                ellipsis={{ rows: 2 }}
                                            >
                                                {item.name}
                                            </Paragraph>

                                            <div>Khu vực: {item.area}</div>
                                            <div>Loại sân: {item.field_type}</div>

                                            <div className="price-amount">
                                                <Paragraph className='price-product'>
                                                    {numberWithCommas(item.price)}đ/giờ
                                                </Paragraph>
                                            </div>
                                        </div>


                                    </div>
                                    <Paragraph
                                        className="badge"
                                        style={{ position: "absolute", top: 10, left: 9 }}
                                    >
                                        <span>Gợi ý</span>
                                        <img src={triangleTopRight} />
                                    </Paragraph>
                                </Col>
                            ))}
                        </Row>
                    </div>

                    <Modal
                        title="Tạo đơn đặt sân mới"
                        visible={openModalCreate}
                        style={{ top: 100 }}
                        onOk={() => {
                            form
                                .validateFields()
                                .then((values) => {
                                    form.resetFields();
                                    handleOkUser(values);
                                })
                                .catch((info) => {
                                    console.log('Validate Failed:', info);
                                });
                        }}
                        onCancel={() => handleCancel("create")}
                        okText="Hoàn thành"
                        cancelText="Hủy"
                        width={600}
                    >
                        <Form
                            form={form}
                            name="courtBookingCreate"
                            layout="vertical"
                            initialValues={{
                                payment_method: 'Thanh toán trực tiếp',
                            }}
                            scrollToFirstError
                        >
                            <Spin spinning={loading}>

                                <Form.Item
                                    name="booking_date"
                                    label="Ngày đặt sân"
                                    rules={[
                                        {
                                            required: true,
                                            message: 'Vui lòng chọn ngày đặt sân!',
                                        },
                                    ]}
                                    style={{ marginBottom: 10 }}
                                >
                                    <DatePicker
                                        style={{ width: '100%' }}
                                        disabledDate={disabledDate}
                                    />
                                </Form.Item>
                                <Form.Item
                                    name="start_time"
                                    label="Giờ bắt đầu"
                                    rules={[
                                        {
                                            required: true,
                                            message: 'Vui lòng chọn giờ bắt đầu!',
                                        },
                                    ]}
                                    style={{ marginBottom: 10 }}
                                >
                                    <TimePicker
                                        style={{ width: '100%' }}
                                        format="HH:mm"
                                        disabledHours={() => {
                                            // Giới hạn giờ từ 7h đến 22h
                                            const disabledHours = [];
                                            for (let i = 0; i < 7; i++) {
                                                disabledHours.push(i);
                                            }
                                            for (let i = 23; i < 24; i++) {
                                                disabledHours.push(i);
                                            }
                                            return disabledHours;
                                        }}
                                        disabledMinutes={(selectedHour) => {
                                            // Lấy thời gian hiện tại
                                            const currentTime = new Date();
                                            const currentHour = currentTime.getHours();
                                            const currentMinute = currentTime.getMinutes();

                                            // Nếu giờ được chọn là giờ hiện tại, chỉ chặn các phút nhỏ hơn phút hiện tại
                                            if (selectedHour === currentHour) {
                                                const disabledMinutes = [];
                                                for (let i = 0; i < currentMinute; i++) {
                                                    disabledMinutes.push(i);
                                                }
                                                return disabledMinutes;
                                            }

                                            // Nếu giờ được chọn lớn hơn giờ hiện tại, không chặn bất kỳ phút nào
                                            return [];
                                        }}
                                        minuteStep={30} // Bước nhảy của phút
                                    />

                                </Form.Item>

                                <Form.Item
                                    name="end_time"
                                    label="Giờ kết thúc"
                                    rules={[
                                        {
                                            required: true,
                                            message: 'Vui lòng chọn giờ kết thúc!',
                                        },
                                    ]}
                                    style={{ marginBottom: 10 }}
                                >
                                    <TimePicker
                                        style={{ width: '100%' }}
                                        format="HH:mm"
                                        disabledHours={() => {
                                            // Giới hạn giờ từ 7h đến 22h
                                            const disabledHours = [];
                                            for (let i = 0; i < 7; i++) {
                                                disabledHours.push(i);
                                            }
                                            for (let i = 23; i < 24; i++) {
                                                disabledHours.push(i);
                                            }
                                            return disabledHours;
                                        }}
                                        disabledMinutes={(selectedHour) => {
                                            // Lấy thời gian hiện tại
                                            const currentTime = new Date();
                                            const currentHour = currentTime.getHours();
                                            const currentMinute = currentTime.getMinutes();

                                            // Nếu giờ được chọn là giờ hiện tại, chỉ chặn các phút nhỏ hơn phút hiện tại
                                            if (selectedHour === currentHour) {
                                                const disabledMinutes = [];
                                                for (let i = 0; i < currentMinute; i++) {
                                                    disabledMinutes.push(i);
                                                }
                                                return disabledMinutes;
                                            }

                                            // Nếu giờ được chọn lớn hơn giờ hiện tại, không chặn bất kỳ phút nào
                                            return [];
                                        }}
                                        minuteStep={30} // Bước nhảy của phút
                                    />

                                </Form.Item>

                                <Form.Item
                                    name="payment_method"
                                    label="Phương thức thanh toán"
                                    style={{ marginBottom: 10 }}
                                >
                                    <Select style={{ width: '100%' }}>
                                        <Select.Option value="Thanh toán trực tiếp">Thanh toán trực tiếp</Select.Option>
                                        <Select.Option value="VNPAY">Thanh toán qua VNPAY</Select.Option>
                                    </Select>
                                </Form.Item>

                            </Spin>
                        </Form>
                    </Modal>
                    
                    {/* Sidebar */}
                    <div className="product-details-sidebar">
                        <div className="product-details-booking-title">
                            📅 Lịch đặt sân gần đây
                        </div>
                        <div className="product-details-booking-history">
                            {bookingCourt.length > 0 ? (
                                bookingCourt.slice(0, 10).map((booking, index) => (
                                    <div key={index} className="product-details-booking-item">
                                        <div className="product-details-booking-date">
                                            📅 {moment(booking.booking_date).format('DD/MM/YYYY')}
                                        </div>
                                        <div className="product-details-booking-time">
                                            ⏰ {moment(booking.start_time, 'HH:mm').format('HH:mm')} - {moment(booking.end_time, 'HH:mm').format('HH:mm')}
                                        </div>
                                        <div className="product-details-booking-status">
                                            ✅ Đã đặt
                                        </div>
                                    </div>
                                ))
                            ) : (
                                <div style={{textAlign: 'center', color: '#7f8c8d', padding: '20px'}}>
                                    <p>🏟️ Chưa có lịch đặt sân nào</p>
                                    <p>Hãy là người đầu tiên đặt sân!</p>
                                </div>
                            )}
                        </div>
                        
                        {qr && (
                            <div style={{marginTop: '30px', textAlign: 'center'}}>
                                <div className="product-details-booking-title" style={{marginBottom: '15px'}}>
                                    💳 QR Code thanh toán
                                </div>
                                <img 
                                    src={qr} 
                                    alt="QR Code" 
                                    style={{
                                        width: '150px', 
                                        height: '150px', 
                                        borderRadius: '10px',
                                        boxShadow: '0 5px 15px rgba(0, 0, 0, 0.1)'
                                    }} 
                                />
                            </div>
                        )}
                    </div>
                </div>
            </Spin>
        </div>
    );
};

export default ProductDetail;
