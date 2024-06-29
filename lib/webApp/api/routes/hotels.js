import express from "express";
import { City, countByType, createHotel, deleteHotel, getHotel, getHotelRooms, getallHotel, updateHotel } from "../controllers/hotel.js";
import { verifyAdmin } from "../utils/verifyToken.js";

const router = express.Router();

//CREATE
router.post("/", verifyAdmin, createHotel);

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

export default router