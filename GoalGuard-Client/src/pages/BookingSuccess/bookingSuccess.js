import React, { useEffect, useState } from 'react';
import { Result, Button, notification, Spin } from 'antd';
import { useHistory, useLocation } from 'react-router-dom';
import bookingApi from '../../apis/bookingApi';

const BookingSuccess = () => {
    const history = useHistory();
    const location = useLocation();
    const [loading, setLoading] = useState(true);
    const [success, setSuccess] = useState(false);

    useEffect(() => {
        const handleVNPayResponse = async () => {
            try {
                // Lấy thông tin đặt sân từ localStorage
                const pendingBooking = localStorage.getItem('pendingBooking');
                if (!pendingBooking) {
                    setSuccess(false);
                    setLoading(false);
                    return;
                }

                const bookingData = JSON.parse(pendingBooking);
                
                // Kiểm tra xem đã quá 15 phút chưa
                const now = new Date().getTime();
                if (now - bookingData.timestamp > 15 * 60 * 1000) { // 15 phút
                    localStorage.removeItem('pendingBooking');
                    setSuccess(false);
                    setLoading(false);
                    return;
                }

                // Lấy các tham số từ URL
                const params = new URLSearchParams(location.search);
                const vnp_ResponseCode = params.get('vnp_ResponseCode');
                const vnp_TransactionStatus = params.get('vnp_TransactionStatus');

                // Kiểm tra trạng thái thanh toán
                if (vnp_ResponseCode === '00' && vnp_TransactionStatus === '00') {
                    // Gọi API đặt sân
                    const response = await bookingApi.bookCourt(bookingData);
                    
                    if (response) {
                        setSuccess(true);
                        notification.success({
                            message: 'Thành công',
                            description: `Đặt sân ${bookingData.courtName} thành công!`,
                        });
                    } else {
                        setSuccess(false);
                        notification.error({
                            message: 'Thất bại',
                            description: 'Có lỗi xảy ra khi đặt sân',
                        });
                    }
                } else {
                    setSuccess(false);
                    notification.error({
                        message: 'Thất bại',
                        description: 'Thanh toán không thành công',
                    });
                }

                // Xóa thông tin đặt sân khỏi localStorage
                localStorage.removeItem('pendingBooking');
                
            } catch (error) {
                console.error('Error handling VNPAY response:', error);
                setSuccess(false);
                notification.error({
                    message: 'Thất bại',
                    description: 'Có lỗi xảy ra khi xử lý thanh toán',
                });
            }
            setLoading(false);
        };

        handleVNPayResponse();
    }, [location]);

    const handleBackHome = () => {
        history.push('/home');
    };

    if (loading) {
        return (
            <div style={{ 
                minHeight: '80vh', 
                display: 'flex', 
                justifyContent: 'center', 
                alignItems: 'center' 
            }}>
                <Spin size="large" tip="Đang xử lý thanh toán..." />
            </div>
        );
    }

    return (
        <div style={{ 
            minHeight: '80vh', 
            display: 'flex', 
            justifyContent: 'center', 
            alignItems: 'center',
            padding: '20px'
        }}>
            <Result
                status={success ? "success" : "error"}
                title={success ? "Đặt sân thành công!" : "Đặt sân thất bại!"}
                subTitle={success 
                    ? "Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi. Chúc bạn có trải nghiệm tốt!"
                    : "Rất tiếc đã xảy ra lỗi trong quá trình đặt sân. Vui lòng thử lại sau."}
                extra={[
                    <Button type="primary" key="home" onClick={handleBackHome}>
                        Về trang chủ
                    </Button>
                ]}
            />
        </div>
    );
};

export default BookingSuccess; 