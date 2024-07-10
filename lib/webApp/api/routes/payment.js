import express from 'express'
import bodyParser from 'body-parser';
import { paymentIntent, retrieveSession, updateBookingStatus } from '../controllers/payment.js';

const router = express.Router();

router.post('/checkout_session',paymentIntent);

router.get('/retrieve-session', retrieveSession);

router.get('/update-booking-status', updateBookingStatus);

export default router;



//can we use http://localhost:8800/api/payment/webhook url for stripe webhool endpoint

// Add webhook route with raw body parser for Stripe webhook signature verification
//router.post('/webhook', bodyParser.raw({ type: 'application/json' }), handleStripeWebhook);