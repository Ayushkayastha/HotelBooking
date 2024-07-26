import React, { useState } from 'react';
import axios from 'axios';
import './reviewform.css'; // Import the CSS file

const ReviewForm = ({ bookingId }) => {
  const [rating, setRating] = useState(1);
  const [review, setReview] = useState('');

  const submitReview = async (e) => {
    e.preventDefault();
    try {
      const reviewData = { 
        bookingId: bookingId,
        rating: rating,
        review: review
      };
      console.log("reviewData: ",reviewData);
      await axios.put('http://localhost:8800/api/reviews/addreview', reviewData, { withCredentials: true }); // withCredentials so that browser can send cookies to server
      alert('Review added successfully');
    } catch (error) {
      console.error('Error adding review:', error);
      alert('Error adding review');
    }
  };

  const renderStars = (rating) => {
    return (
      <div className="rating-stars">
        {[...Array(5)].map((_, index) => (
          <span
            key={index}
            className={`star ${index < rating ? 'selected' : ''}`}
            onClick={() => setRating(index + 1)}
          >
            ★
          </span>
        ))}
      </div>
    );
  };

  return (
    <form onSubmit={submitReview} className="review-form">
      <label>Rating:</label>
      {renderStars(rating)}
      <label>Review:</label>
      <textarea value={review} onChange={(e) => setReview(e.target.value)} />
      <button type="submit">Submit Review</button>
    </form>
  );
};

export default ReviewForm;
