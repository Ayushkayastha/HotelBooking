import React, { useState, useEffect, useContext } from 'react';
import useFetch from '../../hooks/useFetch';
import ReviewForm from './ReviewForm';
import { AUTHContext } from '../../context/AuthContext';

const HotelReviews = ({ hotelId }) => {
  const { data: reviews, loading: reviewsLoading, error: reviewsError } = useFetch(`/hotels/${hotelId}/review`);
  const { user } = useContext(AUTHContext);

  // Use fetch hook for booking status
  const { data: bookingData, loading: bookingLoading, error: bookingError } = useFetch(`/bookings/users/${user._id}/hotels/${hotelId}`);
  const [bookingCompleted, setBookingCompleted] = useState(false);

  useEffect(() => {
    if (bookingData) {
      const { status } = bookingData;
      console.log(bookingData.bookingId)
      if (status === 'completed') {
        console.log(status)
        setBookingCompleted(true);
      }
    }
  }, [bookingData]);

  if (reviewsLoading || bookingLoading) return <p>Loading...</p>;
  if (reviewsError || bookingError) return <p>Error loading data.</p>;

  return (
    <div>
      <h2>Ratings and Reviews</h2>
      {reviews.length === 0 ? (
        <p>No reviews yet.</p>
      ) : (
        reviews.map((review) => (
          <div key={review._id} className="review">
            <p><strong>User:</strong> {review.user.username}</p>
            <p><strong>Rating:</strong> {review.rating} / 5</p>
            <p><strong>Review:</strong> {review.review}</p>
          </div>
        ))
      )}
      {bookingCompleted && <ReviewForm bookingId={bookingData.bookingId}/>}
    </div>
  );
};

export default HotelReviews;
