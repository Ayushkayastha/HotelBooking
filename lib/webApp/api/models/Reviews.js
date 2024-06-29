import mongoose, {Schema} from "mongoose";
import Hotel from "./Hotel.js";
import User from "./User.js";

const ReviewSchema = new Schema(
    {
        hotel: {
            type: Schema.Types.ObjectId,
            ref: Hotel,
            
        },
        user: {
            type: Schema.Types.ObjectId,
            ref: User,
            required: true,
        },
        rating: {
            type: Number,
            min: 1,
            max: 5,
            required: true,
        },
        comment: {
            type: String,
            required: true,
        },
        date: {
            type: Date,
            default: Date.now,
        },
    },
    {timestamps: true}
);

export default mongoose.model("Review",ReviewSchema);