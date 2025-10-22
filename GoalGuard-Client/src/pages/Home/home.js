import QueueAnim from 'rc-queue-anim';
import { OverPack } from 'rc-scroll-anim';
import Texty from 'rc-texty';
import TweenOne from 'rc-tween-one';
import React, { useEffect, useState } from "react";
import courtsManagementApi from "../../apis/courtsManagementApi";
import areaManagementApi from "../../apis/areaManagementApi";

import triangleTopRight from "../../assets/icon/Triangle-Top-Right.svg";
import service10 from "../../assets/image/service/service10.png";
import service6 from "../../assets/image/service/service6.png";
import service7 from "../../assets/image/service/service7.png";
import service8 from "../../assets/image/service/service8.png";
import service9 from "../../assets/image/service/service9.png";
import "./home.css";

import { RightOutlined, StarFilled, ClockCircleOutlined, PhoneOutlined, EnvironmentOutlined, TrophyOutlined, TeamOutlined } from '@ant-design/icons';
import { BackTop, Card, Carousel, Col, Row, Spin, Button, Statistic, Avatar, Timeline } from "antd";
import Paragraph from "antd/lib/typography/Paragraph";
import { useHistory } from 'react-router-dom';
import { numberWithCommas } from "../../utils/common";


const Home = () => {

    const [productList, setProductList] = useState([]);
    const [loading, setLoading] = useState(true);
    const [categories, setCategories] = useState([]);


    const history = useHistory();


    const handleReadMore = (id) => {
        console.log(id);
        history.push("product-detail/" + id)
    }

    const handleCategoryDetails = (id) => {
        console.log(id);
        history.push("product-list/" + id)
    }

    useEffect(() => {
        (async () => {
            try {
                const response = await courtsManagementApi.getAllCourts({ page: 1, limit: 10 });
                // Lọc dữ liệu có approval_status khác "pending"
                const filteredResponse = response.filter(item => item.approval_status !== "pending");
                setProductList(filteredResponse);
                setLoading(false);
            } catch (error) {
                console.log('Failed to fetch event list:' + error);
            }

            try {
                const response = await areaManagementApi.getAllAreas();
                console.log(response);
                setCategories(response);
            } catch (error) {
                console.log(error);
            }
        })();
    }, [])


    return (
        <Spin spinning={false}>
            <div style={{ background: "#FFFFFF", overflowX: "hidden", overflowY: "hidden" }} className="home">
                {/* Modern Hero Section */}
                <div className="hero-section" style={{
                    background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                    minHeight: '100vh',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    position: 'relative',
                    overflow: 'hidden'
                }}>
                    {/* Geometric Background Pattern */}
                    <div style={{
                        position: 'absolute',
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        backgroundImage: `
                            radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                            radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.05) 0%, transparent 50%),
                            linear-gradient(45deg, transparent 40%, rgba(255, 255, 255, 0.03) 50%, transparent 60%)
                        `,
                        animation: 'float 8s ease-in-out infinite'
                    }}></div>
                    
                    <div className="container" style={{ position: 'relative', zIndex: 2 }}>
                        <Row justify="center" align="middle" style={{ minHeight: '80vh' }}>
                            <Col xs={24} lg={12} style={{ textAlign: 'center', color: 'white' }}>
                                <div style={{
                                    background: 'rgba(255, 255, 255, 0.08)',
                                    backdropFilter: 'blur(20px)',
                                    borderRadius: '24px',
                                    padding: '60px 40px',
                                    border: '1px solid rgba(255, 255, 255, 0.15)',
                                    boxShadow: '0 20px 60px rgba(0, 0, 0, 0.1)'
                                }}>
                                    <h1 style={{
                                        fontSize: 'clamp(2.5rem, 6vw, 4rem)',
                                        fontWeight: '800',
                                        marginBottom: '24px',
                                        lineHeight: '1.2',
                                        color: 'white'
                                    }}>
                                        <span style={{
                                            background: 'linear-gradient(135deg, #ffffff, #f0f8ff)',
                                            WebkitBackgroundClip: 'text',
                                            WebkitTextFillColor: 'transparent',
                                            backgroundClip: 'text'
                                        }}>Đặt Sân Bóng</span>
                                        <br />
                                        <span style={{
                                            fontSize: 'clamp(1.5rem, 4vw, 2.5rem)',
                                            fontWeight: '600',
                                            background: 'linear-gradient(135deg, #ffd700, #ffb347)',
                                            WebkitBackgroundClip: 'text',
                                            WebkitTextFillColor: 'transparent',
                                            backgroundClip: 'text'
                                        }}>Thông Minh & Hiện Đại</span>
                                    </h1>
                                    
                                    <p style={{
                                        fontSize: 'clamp(1.1rem, 2.5vw, 1.3rem)',
                                        marginBottom: '40px',
                                        opacity: '0.9',
                                        lineHeight: '1.6',
                                        color: 'rgba(255, 255, 255, 0.9)'
                                    }}>
                                        Nền tảng đặt sân bóng hàng đầu Việt Nam với <strong>1000+ sân bóng</strong> chất lượng cao
                                        <br />Đặt lịch nhanh chóng - Thanh toán an toàn - Dịch vụ 5 sao
                                    </p>
                                    
                                    <div style={{ 
                                        display: 'flex', 
                                        gap: '20px', 
                                        justifyContent: 'center', 
                                        flexWrap: 'wrap',
                                        marginBottom: '40px'
                                    }}>
                                        <Button 
                                            type="primary" 
                                            size="large"
                                            onClick={() => window.location.href = 'http://localhost:3500/product-list/1'}
                                            style={{
                                                background: 'linear-gradient(135deg, #ff6b6b, #ee5a24)',
                                                border: 'none',
                                                borderRadius: '50px',
                                                padding: '16px 40px',
                                                fontSize: '1.1rem',
                                                fontWeight: '600',
                                                height: 'auto',
                                                boxShadow: '0 8px 25px rgba(255, 107, 107, 0.3)',
                                                transition: 'all 0.3s ease'
                                            }}
                                        >
                                            <PhoneOutlined /> Đặt Sân Ngay
                                        </Button>
                                        <Button 
                                            size="large"
                                            onClick={() => window.location.href = 'http://localhost:3500/product-list/1'}
                                            style={{
                                                background: 'transparent',
                                                border: '2px solid rgba(255, 255, 255, 0.6)',
                                                color: 'white',
                                                borderRadius: '50px',
                                                padding: '16px 40px',
                                                fontSize: '1.1rem',
                                                fontWeight: '600',
                                                height: 'auto',
                                                transition: 'all 0.3s ease'
                                            }}
                                        >
                                            <EnvironmentOutlined /> Xem Sân Gần Bạn
                                        </Button>
                                    </div>
                                </div>
                            </Col>
                            
                            <Col xs={24} lg={12} style={{ textAlign: 'center', marginTop: '40px' }}>
                                <div style={{
                                    background: 'rgba(255, 255, 255, 0.95)',
                                    borderRadius: '20px',
                                    padding: '40px 30px',
                                    backdropFilter: 'blur(20px)',
                                    boxShadow: '0 20px 40px rgba(0, 0, 0, 0.1)',
                                    border: '1px solid rgba(255, 255, 255, 0.2)',
                                    marginLeft: '50px'
                                }}>
                                    <h3 style={{
                                        color: '#2c3e50',
                                        fontSize: '1.5rem',
                                        fontWeight: '700',
                                        marginBottom: '30px',
                                        background: 'linear-gradient(135deg, #667eea, #764ba2)',
                                        WebkitBackgroundClip: 'text',
                                        WebkitTextFillColor: 'transparent',
                                        backgroundClip: 'text',
                                    }}>Chọn Khu Vực Sân Bóng</h3>
                                    
                                    <Row gutter={[16, 16]}>
                                        {categories.slice(0, 6).map((category, index) => (
                                            <Col xs={12} sm={8} key={category.id}>
                                                <div 
                                                    onClick={() => handleCategoryDetails(category.id)}
                                                    style={{
                                                        background: 'linear-gradient(135deg, #f8f9fa, #ffffff)',
                                                        borderRadius: '16px',
                                                        padding: '20px 15px',
                                                        textAlign: 'center',
                                                        cursor: 'pointer',
                                                        transition: 'all 0.3s ease',
                                                        border: '1px solid rgba(102, 126, 234, 0.1)',
                                                        boxShadow: '0 4px 15px rgba(0, 0, 0, 0.05)',
                                                        transform: 'translateY(0)'
                                                    }}
                                                    onMouseEnter={(e) => {
                                                        e.currentTarget.style.transform = 'translateY(-5px)';
                                                        e.currentTarget.style.boxShadow = '0 8px 25px rgba(102, 126, 234, 0.15)';
                                                        e.currentTarget.style.borderColor = '#667eea';
                                                    }}
                                                    onMouseLeave={(e) => {
                                                        e.currentTarget.style.transform = 'translateY(0)';
                                                        e.currentTarget.style.boxShadow = '0 4px 15px rgba(0, 0, 0, 0.05)';
                                                        e.currentTarget.style.borderColor = 'rgba(102, 126, 234, 0.1)';
                                                    }}
                                                >
                                                    <EnvironmentOutlined style={{
                                                        fontSize: '1.8rem',
                                                        color: '#667eea',
                                                        marginBottom: '8px'
                                                    }} />
                                                    <div style={{
                                                        color: '#2c3e50',
                                                        fontWeight: '600',
                                                        fontSize: '0.9rem'
                                                    }}>{category.name}</div>
                                                </div>
                                            </Col>
                                        ))}
                                    </Row>
                                </div>
                            </Col>
                        </Row>
                    </div>
                </div>

                {/* Modern Stats Section */}
                <div style={{
                    background: 'linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%)',
                    padding: '100px 0',
                    position: 'relative'
                }}>
                    <div className="container">
                        <div style={{
                            textAlign: 'center',
                            marginBottom: '60px'
                        }}>
                            <h2 style={{
                                fontSize: 'clamp(2rem, 4vw, 3rem)',
                                fontWeight: '800',
                                background: 'linear-gradient(135deg, #667eea, #764ba2)',
                                WebkitBackgroundClip: 'text',
                                WebkitTextFillColor: 'transparent',
                                backgroundClip: 'text',
                                marginBottom: '16px'
                            }}>Thành Tích Ấn Tượng</h2>
                            <p style={{
                                fontSize: '1.2rem',
                                color: '#6c757d',
                                maxWidth: '600px',
                                margin: '0 auto'
                            }}>Những con số chứng minh sự tin tưởng của khách hàng dành cho chúng tôi</p>
                        </div>
                        
                        <Row gutter={[40, 40]} justify="center">
                            <Col xs={12} sm={6}>
                                <div className="stats-card" style={{
                                    background: 'linear-gradient(135deg, #ffffff, #f8f9fa)',
                                    borderRadius: '20px',
                                    padding: '40px 20px',
                                    textAlign: 'center',
                                    boxShadow: '0 10px 30px rgba(0, 0, 0, 0.08)',
                                    border: '1px solid rgba(102, 126, 234, 0.1)',
                                    transition: 'all 0.3s ease',
                                    transform: 'translateY(0)'
                                }}>
                                    <div style={{
                                        background: 'linear-gradient(135deg, #667eea, #764ba2)',
                                        borderRadius: '50%',
                                        width: '80px',
                                        height: '80px',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        margin: '0 auto 20px',
                                        boxShadow: '0 8px 25px rgba(102, 126, 234, 0.3)'
                                    }}>
                                        <TrophyOutlined style={{ fontSize: '2rem', color: 'white' }} />
                                    </div>
                                    <div style={{
                                        fontSize: '3rem',
                                        fontWeight: '800',
                                        background: 'linear-gradient(135deg, #667eea, #764ba2)',
                                        WebkitBackgroundClip: 'text',
                                        WebkitTextFillColor: 'transparent',
                                        backgroundClip: 'text',
                                        marginBottom: '8px'
                                    }}>1,000+</div>
                                    <div style={{
                                        color: '#6c757d',
                                        fontSize: '1.1rem',
                                        fontWeight: '600'
                                    }}>Sân Bóng</div>
                                </div>
                            </Col>
                            <Col xs={12} sm={6}>
                                <div className="stats-card" style={{
                                    background: 'linear-gradient(135deg, #ffffff, #f8f9fa)',
                                    borderRadius: '20px',
                                    padding: '40px 20px',
                                    textAlign: 'center',
                                    boxShadow: '0 10px 30px rgba(0, 0, 0, 0.08)',
                                    border: '1px solid rgba(255, 107, 107, 0.1)',
                                    transition: 'all 0.3s ease',
                                    transform: 'translateY(0)'
                                }}>
                                    <div style={{
                                        background: 'linear-gradient(135deg, #ff6b6b, #ee5a24)',
                                        borderRadius: '50%',
                                        width: '80px',
                                        height: '80px',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        margin: '0 auto 20px',
                                        boxShadow: '0 8px 25px rgba(255, 107, 107, 0.3)'
                                    }}>
                                        <TeamOutlined style={{ fontSize: '2rem', color: 'white' }} />
                                    </div>
                                    <div style={{
                                        fontSize: '3rem',
                                        fontWeight: '800',
                                        background: 'linear-gradient(135deg, #ff6b6b, #ee5a24)',
                                        WebkitBackgroundClip: 'text',
                                        WebkitTextFillColor: 'transparent',
                                        backgroundClip: 'text',
                                        marginBottom: '8px'
                                    }}>50,000+</div>
                                    <div style={{
                                        color: '#6c757d',
                                        fontSize: '1.1rem',
                                        fontWeight: '600'
                                    }}>Khách Hàng</div>
                                </div>
                            </Col>
                            <Col xs={12} sm={6}>
                                <div className="stats-card" style={{
                                    background: 'linear-gradient(135deg, #ffffff, #f8f9fa)',
                                    borderRadius: '20px',
                                    padding: '40px 20px',
                                    textAlign: 'center',
                                    boxShadow: '0 10px 30px rgba(0, 0, 0, 0.08)',
                                    border: '1px solid rgba(52, 211, 153, 0.1)',
                                    transition: 'all 0.3s ease',
                                    transform: 'translateY(0)'
                                }}>
                                    <div style={{
                                        background: 'linear-gradient(135deg, #34d399, #10b981)',
                                        borderRadius: '50%',
                                        width: '80px',
                                        height: '80px',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        margin: '0 auto 20px',
                                        boxShadow: '0 8px 25px rgba(52, 211, 153, 0.3)'
                                    }}>
                                        <EnvironmentOutlined style={{ fontSize: '2rem', color: 'white' }} />
                                    </div>
                                    <div style={{
                                        fontSize: '3rem',
                                        fontWeight: '800',
                                        background: 'linear-gradient(135deg, #34d399, #10b981)',
                                        WebkitBackgroundClip: 'text',
                                        WebkitTextFillColor: 'transparent',
                                        backgroundClip: 'text',
                                        marginBottom: '8px'
                                    }}>+8</div>
                                    <div style={{
                                        color: '#6c757d',
                                        fontSize: '1.1rem',
                                        fontWeight: '600'
                                    }}>Huyện Hưng Yên</div>
                                </div>
                            </Col>
                            <Col xs={12} sm={6}>
                                <div className="stats-card" style={{
                                    background: 'linear-gradient(135deg, #ffffff, #f8f9fa)',
                                    borderRadius: '20px',
                                    padding: '40px 20px',
                                    textAlign: 'center',
                                    boxShadow: '0 10px 30px rgba(0, 0, 0, 0.08)',
                                    border: '1px solid rgba(251, 191, 36, 0.1)',
                                    transition: 'all 0.3s ease',
                                    transform: 'translateY(0)'
                                }}>
                                    <div style={{
                                        background: 'linear-gradient(135deg, #fbbf24, #f59e0b)',
                                        borderRadius: '50%',
                                        width: '80px',
                                        height: '80px',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        margin: '0 auto 20px',
                                        boxShadow: '0 8px 25px rgba(251, 191, 36, 0.3)'
                                    }}>
                                        <StarFilled style={{ fontSize: '2rem', color: 'white' }} />
                                    </div>
                                    <div style={{
                                        fontSize: '3rem',
                                        fontWeight: '800',
                                        background: 'linear-gradient(135deg, #fbbf24, #f59e0b)',
                                        WebkitBackgroundClip: 'text',
                                        WebkitTextFillColor: 'transparent',
                                        backgroundClip: 'text',
                                        marginBottom: '8px'
                                    }}>4.8/5</div>
                                    <div style={{
                                        color: '#6c757d',
                                        fontSize: '1.1rem',
                                        fontWeight: '600'
                                    }}>Đánh Giá</div>
                                </div>
                            </Col>
                        </Row>
                    </div>
                </div>



                <div className="container-home container" style={{ marginTop: 40 }}>
                    <img src="https://img.thegioithethao.vn/media/banner/banner-ban-muon-biet.png" className="promotion1"></img>
                </div>

                <div className="image-one">
                    <div className="texty-demo">
                        <Texty>Sân Mới</Texty>
                    </div>
                    <div className="texty-title">
                        <p>Trải Nghiệm <strong style={{ color: "#3b1d82" }}>Ngay</strong></p>
                    </div>

                    <div className="list-products container" key="1" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(270px, 1fr))', gridGap: '25px' }}>
                        {productList.slice(0, 20).map((item) => (
                            <div
                                className='col-product'
                                onClick={() => handleReadMore(item.id)}
                                key={item.id}
                                style={{ cursor: 'pointer' }}
                            >
                                <div className="show-product">
                                    {item.image ? (
                                        <img
                                            className='image-product'
                                            src={item.image}
                                            alt={item.name}
                                        />
                                    ) : (
                                        <img
                                            className='image-product'
                                            src={require('../../assets/image/NoImageAvailable.jpg')}
                                            alt="No Image Available"
                                        />
                                    )}
                                    <div className='wrapper-products'>
                                        <Paragraph
                                            className='title-product overflow-ellipsis overflow-hidden whitespace-nowrap'
                                        >
                                            {item.name}
                                        </Paragraph>

                                        <div className="truncate">Khu vực: {item.area}</div>
                                        <div className="truncate">Loại sân: {item.field_type}</div>

                                        <div className="price-amount">
                                            <Paragraph className='price-product'>
                                                {numberWithCommas(Number(item.price))}đ/giờ
                                            </Paragraph>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        ))}
                    </div>
                </div>


                {/* Why Choose Us Section */}
                <div className="why-choose-section">
                    <div className="container">
                        <div className="section-header">
                            <h2 className="section-title">
                                <Texty>Tại Sao Chọn Chúng Tôi?</Texty>
                            </h2>
                            <p className="section-subtitle">Những lý do khiến hàng nghìn khách hàng tin tướng</p>
                        </div>
                        <Row gutter={[32, 32]} justify="center">
                            <Col xs={24} sm={12} md={12} lg={8}>
                                <Card bordered={false} className="service-card">
                                    <div className="service-icon-wrapper">
                                        <img src={service6} alt="Sân bóng tiện ích" className="service-icon" />
                                    </div>
                                    <h3 className="service-title">Tiện Ích Đầy Đủ</h3>
                                    <p className="service-description">Phòng thay đồ, căng tin, bãi đỗ xe và nhiều tiện ích hiện đại khác</p>
                                </Card>
                            </Col>
                            <Col xs={24} sm={12} md={12} lg={8}>
                                <Card bordered={false} className="service-card">
                                    <div className="service-icon-wrapper">
                                        <img src={service7} alt="Chất lượng sân bóng" className="service-icon" />
                                    </div>
                                    <h3 className="service-title">Chất Lượng Tốt Nhất</h3>
                                    <p className="service-description">Cỏ nhân tạo FIFA Quality Pro, đảm bảo trải nghiệm tuyệt vời</p>
                                </Card>
                            </Col>
                            <Col xs={24} sm={12} md={12} lg={8}>
                                <Card bordered={false} className="service-card">
                                    <div className="service-icon-wrapper">
                                        <img src={service8} alt="Dịch vụ chuyên nghiệp" className="service-icon" />
                                    </div>
                                    <h3 className="service-title">Dịch Vụ Chuyên Nghiệp</h3>
                                    <p className="service-description">Đội ngũ nhân viên được đào tạo bài bản, phục vụ tận tình</p>
                                </Card>
                            </Col>
                        </Row>
                        <Row gutter={[32, 32]} justify="center" style={{ marginTop: 32 }}>
                            <Col xs={24} sm={12} md={12} lg={8}>
                                <Card bordered={false} className="service-card">
                                    <div className="service-icon-wrapper">
                                        <img src={service9} alt="Đặt lịch linh hoạt" className="service-icon" />
                                    </div>
                                    <h3 className="service-title">Đặt Lịch Linh Hoạt</h3>
                                    <p className="service-description">Hệ thống đặt lịch online 24/7, dễ dàng và nhanh chóng</p>
                                </Card>
                            </Col>
                            <Col xs={24} sm={12} md={12} lg={8}>
                                <Card bordered={false} className="service-card">
                                    <div className="service-icon-wrapper">
                                        <img src={service10} alt="Hỗ trợ 24/7" className="service-icon" />
                                    </div>
                                    <h3 className="service-title">Hỗ Trợ 24/7</h3>
                                    <p className="service-description">Luôn sẵn sàng hỗ trợ khách hàng mọi lúc, mọi nơi</p>
                                </Card>
                            </Col>
                        </Row>
                    </div>
                </div>

                {/* Testimonials Section */}
                <div className="testimonials-section">
                    <div className="container">
                        <div className="section-header">
                            <h2 className="section-title">
                                <Texty>Khách Hàng Nói Gì Về Chúng Tôi</Texty>
                            </h2>
                            <p className="section-subtitle">Những phản hồi tích cực từ cộng đồng yêu bóng đá</p>
                        </div>
                        <Row gutter={[32, 32]}>
                            <Col xs={24} md={8}>
                                <Card className="testimonial-card">
                                    <div className="testimonial-header">
                                        <Avatar size={64} src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150" />
                                        <div className="testimonial-info">
                                            <h4>Nguyễn Tiến Minh</h4>
                                            <p>Đội trưởng FC Hà Nội</p>
                                            <div className="rating">
                                                <StarFilled /><StarFilled /><StarFilled /><StarFilled /><StarFilled />
                                            </div>
                                        </div>
                                    </div>
                                    <p className="testimonial-content">
                                        "Sân bóng chất lượng tuyệt vời, dịch vụ chuyên nghiệp. Đội mình đã đặt sân ở đây hơn 2 năm và rất hài lòng."
                                    </p>
                                </Card>
                            </Col>
                            <Col xs={24} md={8}>
                                <Card className="testimonial-card">
                                    <div className="testimonial-header">
                                        <Avatar size={64} src="https://media.vietnamplus.vn/images/7255a701687d11cb8c6bbc58a6c807852678be9e2b82dbcf04f4c086b8e8a8ac5536542949386121c4eb5d133368f063ddb431567184ef356fe58fd76d4986e4/HLV_tuyen_nu_anh.jpg" />
                                        <div className="testimonial-info">
                                            <h4>Dương Vân Anh</h4>
                                            <p>Quản lý CLB Nữ</p>
                                            <div className="rating">
                                                <StarFilled /><StarFilled /><StarFilled /><StarFilled /><StarFilled />
                                            </div>
                                        </div>
                                    </div>
                                    <p className="testimonial-content">
                                        "Hệ thống đặt lịch rất tiện lợi, nhân viên hỗ trợ nhiệt tình. Sân sạch sẽ, tiện ích đầy đủ."
                                    </p>
                                </Card>
                            </Col>
                            <Col xs={24} md={8}>
                                <Card className="testimonial-card">
                                    <div className="testimonial-header">
                                        <Avatar size={64} src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150" />
                                        <div className="testimonial-info">
                                            <h4>Đào Mạnh Chiến</h4>
                                            <p>Huấn luyện viên</p>
                                            <div className="rating">
                                                <StarFilled /><StarFilled /><StarFilled /><StarFilled /><StarFilled />
                                            </div>
                                        </div>
                                    </div>
                                    <p className="testimonial-content">
                                        "Cỏ nhân tạo chất lượng cao, phù hợp cho cả tập luyện và thi đấu. Giá cả hợp lý, dịch vụ tốt."
                                    </p>
                                </Card>
                            </Col>
                        </Row>
                    </div>
                </div>

                {/* CTA Section */}
                <div className="cta-section">
                    <div className="container">
                        <div className="cta-content">
                            <h2 className="cta-title">
                                <Texty>Sẵn Sàng Trải Nghiệm?</Texty>
                            </h2>
                            <p className="cta-subtitle">Đăng ký ngay để nhận ưu đãi đặc biệt và đặt sân với giá tốt nhất!</p>
                            <div className="cta-buttons">
                                <Button type="primary" size="large" className="cta-btn primary">
                                    <PhoneOutlined /> Đặt Sân Ngay
                                </Button>
                                <Button size="large" className="cta-btn secondary">
                                    Xem Bảng Giá
                                </Button>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <BackTop style={{ textAlign: 'right' }} />
        </Spin >
    );
};

export default Home;
