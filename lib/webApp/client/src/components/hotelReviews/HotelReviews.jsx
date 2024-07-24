// components/HotelReviews.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const HotelReviews = ({ hotelId }) => {
  const [reviews, setReviews] = useState([]);

  useEffect(() => {
    const fetchReviews = async () => {
      const response = await axios.get(`/api/hotels/${hotelId}/reviews`);
      setReviews(response.data);
    };

    fetchReviews();
  }, [hotelId]);

  return (
    <div>
      <h2>Reviews</h2>
      {reviews.map((review) => (
        <div key={review._id}>
          <p>Rating: {review.rating}</p>
          <p>{review.review}</p>
        </div>
      ))}
    </div>
  );
};

export default HotelReviews;
