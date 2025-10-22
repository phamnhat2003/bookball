const express = require('express');
const router = express.Router();
const bookingController = require('../controllers/bookingController');

// Đặt sân
router.post('/book', bookingController.bookCourt);

router.get('/revenue-report', bookingController.getRevenueReport);

// Xem lịch sử đặt sân
router.get('/history/:user_id', bookingController.getBookingHistory);

// Lấy thông tin đặt sân theo court_id
router.get('/court/:court_id', bookingController.getBookingByCourtId);

// API cập nhật trạng thái đặt sân (cũ)
router.put('/:id/update-status', bookingController.updateBookingStatus);

// API cập nhật đặt sân (mới - phù hợp với handleUpdateOrder frontend)
router.put('/:id', bookingController.updateOrder);

router.get('/user/:user_id', bookingController.getBookingByUserID);
router.get('/userCourts/:user_id', bookingController.getBookingByUserCourtsID);

router.get('/:id', bookingController.getBookingByID);

// // API xóa cứng đặt sân
// router.delete('/:id', bookingController.deleteBooking);

module.exports = router;
