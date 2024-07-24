import Booking from "../models/Booking.js";
import Hotel from "../models/Hotel.js";
import Reviews from "../models/Reviews.js"

export const createReviews = async (req, res, next) => {
    const { hotel, rating } = req.body;
    const newReview = new Reviews(req.body);

    try {
        const savedReview = await newReview.save()
        
        const hotels = await Hotel.findById(hotel);
        hotels.reviews += 1;
        hotels.rating = ((hotels.rating * (hotels.reviews - 1)) + rating) / (hotels.reviews);
        await hotels.save();

        res.status(201).json(savedReview)
    } catch (error) {
       next(error)
    }
}

export const getReviewsByHotel = async (req, res, next) => {
    try {
        const reviews = await Reviews.find({hotel: req.params.id}).populate('user');
        res.json(reviews);
    } catch (error) {
        next(error)
    }
}

export const addReview = async (req, res) => {
    const { bookingId, rating, review } = req.body;
    console.log(bookingId, rating, review);
    const booking = await Booking.findById(bookingId);
  
    if (!booking) {
      return res.status(404).json({ message: 'Booking not found' });
    }
  
    if (booking.status != "completed") {
      return res.status(400).json({ message: 'Cannot review before stay completion' });
    }
  
    booking.rating = rating;
    booking.review = review;
    await booking.save();
  
    res.status(200).json({ message: 'Review added successfully' });
  };