import express from "express";
import { createReviews, getReviewsByHotel } from "../controllers/reviews.js";

const router = express.Router();

router.post("/",createReviews);

router.get("/hotel/:id",getReviewsByHotel);

export default router;