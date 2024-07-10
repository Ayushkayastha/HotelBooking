import express from 'express'
import dotenv from 'dotenv'
import connectDB from './db/connection.js'
import authRoute from "./routes/auth.js"
import usersRoute from "./routes/users.js"
import roomsRoute from "./routes/rooms.js"
import hotelsRoute from "./routes/hotels.js"
import bookingRoute from "./routes/booking.js"
import reviewsRoute from "./routes/reviews.js"
import paymentRoute from "./routes/payment.js"
import CookieParser from 'cookie-parser'
import cors from 'cors'

dotenv.config({
    path: './.env'
})

const app = express()

//middlewares

app.use(cors());

app.use(CookieParser())

app.use(express.json())

app.use("/api/auth", authRoute);
app.use("/api/users", usersRoute);
app.use("/api/hotels", hotelsRoute);
app.use("/api/rooms", roomsRoute);
app.use("/api/bookings", bookingRoute);
app.use("/api/reviews",reviewsRoute);
app.use("/api/payment", paymentRoute);

app.use((err, req, res, next) => {
const errorStatus = err.status || 500;
const errorMessage = err.message || "Something went wrong";
return res.status(errorStatus).json({
    success: false,
    status: errorStatus,
    message: errorMessage,
    stack: err.stack
});
})

connectDB()
.then(() => {
app.listen (8800, () => {
    console.log('Server is running on port 8800')
})})
.catch((error) => {
    console.log("Couldn't connect to Mongodb !!!",error)
})