import express from "express";
import { City, countByType, createHotel, deleteHotel, getHotel, getHotelReviews, getHotelRooms, getallHotel, notverifiedHotels, updateHotel, verifyHotel } from "../controllers/hotel.js";
import { verifyAdmin } from "../utils/verifyToken.js";

const router = express.Router();

//CREATE
//router.post("/", verifyAdmin, createHotel);
router.post("/", createHotel);

//UPDATE

router.put("/:id", verifyAdmin, updateHotel)

//DELETE

router.delete("/:id", verifyAdmin, deleteHotel)

//GET

router.get("/find/:id", getHotel)

//GET ALL

router.get("/", getallHotel)
router.get("/countByType", countByType)
router.get("/room/:id", getHotelRooms)
router.get("/City", City)

router.get("/:id/review", getHotelReviews)

router.put("/:id/verify", verifyAdmin, verifyHotel);

router.get("/not-verified", notverifiedHotels)

export default router