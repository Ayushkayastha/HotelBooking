import express from "express";
import { addReview, createReviews, getReviewsByHotel } from "../controllers/reviews.js";
import { verifyBookingOwnership } from "../controllers/auth.js";
import { verifyToken } from "../utils/verifyToken.js";

const router = express.Router();

router.post("/",createReviews);

router.get("/hotel/:id",getReviewsByHotel);

router.put('/addreview', verifyToken,  verifyBookingOwnership, addReview)

export default router;