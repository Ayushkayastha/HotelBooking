import { useLocation } from "react-router-dom";
import "./booking.css"
import React, { useContext, useState } from 'react';
import { AUTHContext } from "../../context/AuthContext";

const BookingPage = () => {
  const { user } = useContext(AUTHContext);
  const location = useLocation();
  const {selectedRooms, dates} = location.state || {};
  const [userDetails, setUserDetails] = useState();

  const handleChange = (e) => {
    const { name, value } = e.target;
    setUserDetails({
      ...userDetails,
      [name]: value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle form submission, e.g., send data to backend
    console.log('Submitted User Details:', userDetails);
  };

  return (
    <div className="booking-page">
      <div className="booking-details">
        <h2>Booking Details</h2>
        <p><strong>Check-in Date:</strong> {new Date(dates[0]).toLocaleDateString()}</p>
        <p><strong>Check-out Date:</strong> {new Date(dates[dates.length - 1]).toLocaleDateString()}</p>
        <p><strong>Hotel Name:</strong> Grand Hotel</p>
        <p><strong>Room No:</strong> {selectedRooms }</p>
      </div>
      <div className="user-form">
        <h2>User Information</h2>
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="username">Username:</label>
            <input
              type="text"
              id="username"
              name="username"
              value={user.username}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="email">Email:</label>
            <input
              type="email"
              id="email"
              name="email"
              value={user.email}
              onChange={handleChange}
            />
          </div>
          <button type="submit">Pay now</button>
        </form>
      </div>
    </div>
  );
};

export default BookingPage;

