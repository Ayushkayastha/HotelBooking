import mongoose, { Schema } from "mongoose";
import Room from "./Room.js";
import Hotel from "./Hotel.js";
import User from "./User.js";

const BookingSchema = new Schema(
    {
        hotel: {
            type: Schema.Types.ObjectId,
            ref: Hotel,
            required: true,
        },
        room: {
            type: Schema.Types.ObjectId,
            ref: Room,
            required: true,
        },
        user: {
            type: Schema.Types.ObjectId,
            ref: User,
            required: true,
        },
        check_in: {
            type: Date,
            required: true,
        },
        check_out: {
            type: Date,
            required: true,
        },
        rating: { 
            type: Number, 
            min: 1, 
            max: 5 
        },
        review: { 
            type: String 
        },
        status: {
            type: String,
            enum: ["confirmed","cancelled","completed","pending"],
            default: "pending",
        }
    },
    {timestamps: true}
);

export default mongoose.model("Booking",BookingSchema);