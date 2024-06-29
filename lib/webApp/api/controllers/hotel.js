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

export const getHotelRooms = async (req, res, eror) => {
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