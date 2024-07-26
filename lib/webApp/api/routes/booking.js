import { cancelBooking, createBooking, deleteBooking, getallBooking, getBooking, getBookingByUser, getBookingStatus } from "../controllers/booking.js";
import express from "express";
import { verifyUser } from "../utils/verifyToken.js";

const router = express.Router();

router.post("/",createBooking);

router.get("/", getallBooking)

router.get("/:id",getBooking);

router.delete("/:id",deleteBooking)

router.get("/users/:userId",verifyUser,getBookingByUser);

router.put("/:id/cancel",cancelBooking)

router.get('/users/:userId/hotels/:hotelId', getBookingStatus);

export default router;