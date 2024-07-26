import React, { useState, useEffect, useContext } from 'react';
import useFetch from '../../hooks/useFetch';
import ReviewForm from './ReviewForm';
import { AUTHContext } from '../../context/AuthContext';
import './profile.css'; // Import the CSS file

const HotelReviews = ({ hotelId }) => {
  const { data: reviews, loading: reviewsLoading, error: reviewsError } = useFetch(`/hotels/${hotelId}/review`);
  const { user } = useContext(AUTHContext);

  // Use fetch hook for booking status
  const { data: bookingData, loading: bookingLoading, error: bookingError } = useFetch(`/bookings/users/${user._id}/hotels/${hotelId}`);
  const [bookingCompleted, setBookingCompleted] = useState(false);
 // console.log("bookingData",bookingData)

  useEffect(() => {
    if (bookingData) {
      const { status } = bookingData;
      if (status === 'completed') {
        setBookingCompleted(true);
      }
    }
  }, [bookingData]);

   if (reviewsLoading || bookingLoading) return <p>Loading...</p>;

   if (reviewsError) {
    console.log("reviewsError", reviewsError);
    return <p>Error loading reviews. Please try again later.</p>;
  }

  if (bookingError) {
    console.log("bookingError", bookingError);
  }

  return (
    <div className="reviews-container">
      <h2>Ratings and Reviews</h2>
      {reviews.length === 0 ? (
        <p>No reviews yet.</p>
      ) : (
        reviews.map((review) => (
          <div key={review._id} className="review">
            <p><strong>User:</strong> {review.user.username}</p>
            <div className="stars">
              {[...Array(5)].map((_, index) => (
                <span key={index} className={index < review.rating ? 'star filled' : 'star'}>★</span>
              ))}
            </div>
            <p><strong>Review:</strong> {review.review}</p>
          </div>
        ))
      )}

{!bookingError && bookingCompleted && <ReviewForm bookingId={bookingData.bookingId}/>}
    </div>
  );
};

export default HotelReviews;

