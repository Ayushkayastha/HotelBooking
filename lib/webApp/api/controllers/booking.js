import Booking from "../models/Booking.js"
import Room from "../models/Room.js"

export const createBooking = async (req, res, next) => {
    const newBooking = new Booking(req.body)

    try {
        const savedBooking = await newBooking.save()
        // add unavailable dates for room
        res.status(201).json(savedBooking)
    } catch (error) {
       next(error)
    }
}

export const getBooking = async (req, res, next) => {
    try {
        const booking = await Booking.findById(req.params.id).populate('user').populate('room')
        if (!booking){
            return res.status(404).send('Booking not found');
        }
        res.status(200).json(booking);
    } catch (error) {
        next(error);        
    }
}

export const getBookingByUser = async (req, res, next) => {
    try {
        const booking = await Booking.find({ user : req.params.userId}).populate('room')
        res.status(200).json(booking);
    } catch (error) {
        next(error);        
    }
}

export const deleteBooking = async (req, res, next) => {
    try {
        const booking = await Booking.findById(req.params.id);
        if (!booking){
            return res.status(404).send('Booking not found');
        }

        booking.status = "cancelled";
        const canceleldBooking = await booking.save();

        const room = await Room.findById(booking.room);
        //room.unavailabledates = remove cureent checkin checkout date
        await room.save();

        res.status(200).json(canceleldBooking);
    } catch (error) {
        next(error);
    }
}



