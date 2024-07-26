import Booking from "../models/Booking.js"
import Hotel from "../models/Hotel.js"
import Room from "../models/Room.js"

export const createHotel = async (req, res, next) => {
    const newHotel = new Hotel(req.body)

    try {
        const savedHotel = await newHotel.save()
        res.status(200).json(savedHotel)
    } catch (error) {
       next(error)
    }
}

export const updateHotel = async (req, res, next) => {
    try {
        const updatedHotel = await Hotel.findByIdAndUpdate(
            req.params.id,
            { $set: req.body },
            { new: true }
        )
        res.status(200).json(updatedHotel)
    } catch (error) {
        next(error)
    }
}

export const deleteHotel = async (req, res, next) => {
    try {
        await Hotel.findByIdAndDelete(
            req.params.id
        )
        res.status(200).json("Hotel has been deleted")
    } catch (error) {
       next(error)
    }
}

export const getHotel = async (req, res, next) => {
    try {
        const hotel = await Hotel.findById(
            req.params.id,
        )
        res.status(200).json(hotel)
    } catch (error) {
       next(error)
    }
}

export const getallHotel = async (req, res, next) => {
    try {
        const {min, max, limit, ...others}=req.query;
        const hotels=await Hotel.find({...others,
             cheapestPrice: { $gte: min || 1 , $lte: max || 999 },
            }).limit(limit);
        res.status(200).json(hotels)
    } catch (error) {
       next(error)
    }
}

export const City = async (req, res, next) => {
    //const uniqueCities = [...new Set(data.map(hotel => hotel.city))];
    try {
        const cityCounts = await Hotel.aggregate([
            {
                $group: {
                    _id: "$city",
                    count: { $sum: 1 }
                }
            },
            {
                $project: {
                    _id: 0,
                    city: "$_id",
                    count: 1
                }
            }
        ]);
        res.status(200).json(cityCounts)
    } catch (error) {
       next(error)
    }
}

export const countByType = async (req, res, next) => {
    try {
    const hotelCount = await Hotel.countDocuments({type : "hotel"})
    const apartmentCount = await Hotel.countDocuments({type : "apartment"})
    const resortCount = await Hotel.countDocuments({type : "resort"})
    const villaCount = await Hotel.countDocuments({type : "villa"})
    const cabinCount = await Hotel.countDocuments({type : "cabin"})
        
        res.status(200).json([
            { type: "hotel", count: hotelCount },
            { type: "apartment", count: apartmentCount },
            { type: "resort", count: resortCount },
            { type: "villa", count: villaCount },
            { type: "cabin", count: cabinCount },
        ])
    } catch (error) {
       next(error)
    }
};

export const getHotelRooms = async (req, res, next) => {
    try {
        const hotel = await Hotel.findById(req.params.id)
        const list = await Promise.all(hotel.rooms.map(room => {
            return Room.findById(room);
        }));
        res.status(200).json(list)
    } catch (error) {
        next(error)
    }
}

export const getHotelReviews = async (req, res, next) => {
    try {
        const hotelId = req.params.id;
        const bookings = await Booking.find({ hotel: hotelId, rating: { $ne: null }, review: { $ne: null } })
          .populate('user', 'username'); // 'username' field in the User model
    
        res.status(200).json(bookings);
      } catch (error) {
        res.status(500).json({ message: error.message });
      }
}

export const verifyHotel = async (req, res) => {
    try {
        const { id } = req.params;
        await Hotel.updateOne({ _id: id }, { status: 'verified' });
        res.status(200).send('Hotel verified');
    } catch (error) {
        res.status(500).send('Error verifying hotel');
    }
};

export const notverifiedHotels = async (req, res) => {
    try {
        const hotels = await Hotel.find({ status: 'not-verified' });
        res.json(hotels);
    } catch (error) {
        console.error('Error fetching hotels:', error);
        res.status(500).send('Internal Server Error');
    }
};