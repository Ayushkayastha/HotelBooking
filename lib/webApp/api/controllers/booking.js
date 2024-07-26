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

export const cancelBooking = async (req, res, next) => {
    try {
        const booking = await Booking.findById(req.params.id);
        if (!booking){
            return res.status(404).send('Booking not found');
        }

        booking.status = "cancelled";
        const cancelleldBooking = await booking.save();

        const room = await Room.findById(booking.room);
        //room.unavailabledates = remove cureent checkin checkout date
        await room.save();

        res.status(200).json(cancelleldBooking);
    } catch (error) {
        next(error);
    }
}

export const updateBookingStatus = async () => {
    //console.log("inside update booking")
    const today = new Date();
    await Booking.updateMany(
      { check_out: { $lt: today }, status: "confirmed" },
      { $set: { status: "completed" } }
    );
  };

// Controller function to get the booking status
export const getBookingStatus = async (req, res) => {
  const { userId, hotelId } = req.params;

  try {
    // Find the booking by userId and hotelId
    const booking = await Booking.findOne({ user: userId, hotel: hotelId });

    if (!booking) {
      return res.status(404).json({ message: 'Booking not found' });
    }

    // Return the booking status
    res.status(200).json({ status: booking.status, bookingId: booking._id });
  } catch (error) {
    console.error('Error fetching booking status:', error);
    res.status(500).json({ message: 'Server error' });
  }
};

export const getallBooking = async (req, res, next) => {
    try {
        const bookings=await Booking.find();
        res.status(200).json(bookings)
    } catch (error) {
       next(error)
    }
}

export const deleteBooking = async (req, res, next) => {
    try {
        await Booking.findByIdAndDelete(
            req.params.id
        )
        res.status(200).json("Booking has been deleted")
    } catch (error) {
       next(error)
    }
}



