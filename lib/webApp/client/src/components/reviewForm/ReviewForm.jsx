import React, { useState } from 'react';
import axios from 'axios';

const ReviewForm = ({ bookingId }) => {
  const [rating, setRating] = useState(1);
  const [review, setReview] = useState('');

  const submitReview = async (e) => {
    e.preventDefault();
    try {
      const reviewData = { 
        bookingId : bookingId,
    rating : rating,
    review : `${review}`};
      await axios.post('http://localhost:8800/api/reviews/addreview', reviewData);
      alert('Review added successfully');
    } catch (error) {
      console.error('Error adding review:', error);
      alert('Error adding review');
    }
  };

  return (
    <form onSubmit={submitReview}>
      <label>Rating:</label>
      <select value={rating} onChange={(e) => setRating(e.target.value)}>
        {[1, 2, 3, 4, 5].map((num) => (
          <option key={num} value={num}>{num}</option>
        ))}
      </select>
      <label>Review:</label>
      <textarea value={review} onChange={(e) => setReview(e.target.value)} />
      <button type="submit">Submit Review</button>
    </form>
  );
};

export default ReviewForm;
