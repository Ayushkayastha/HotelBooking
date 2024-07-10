import { useLocation } from "react-router-dom";
import "./booking.css";
import React, { useContext, useState } from 'react';
import { AUTHContext } from "../../context/AuthContext";
import { loadStripe } from '@stripe/stripe-js';
import useFetch from "../../hooks/useFetch";
import axios from "axios";

const BookingPage = () => {
  const { user } = useContext(AUTHContext);
  const location = useLocation();
  const {hotelId, selectedRooms, dates } = location.state || {};
  const [userDetails, setUserDetails] = useState({
    username: user.username,
    email: user.email
  });

  const hotel = useFetch(`/hotels/find/${hotelId}`)

  const room = useFetch(`/rooms/${selectedRooms}`)
  
  const checkin = new Date(dates[0]).toLocaleDateString();
  const checkout = new Date(dates[dates.length - 1]).toLocaleDateString()
  
  const checkinDate = new Date(checkin);
  const checkoutDate = new Date(checkout);
  
  console.log(checkinDate,checkoutDate)
// // Calculate the difference in time (milliseconds)
// const timeDifference = checkoutDate - checkinDate;

// // Convert the time difference from milliseconds to days
// const dayDifference = timeDifference / (1000 * 60 * 60 * 24);

// console.log(`Difference in days: ${dayDifference}`);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setUserDetails({
      ...userDetails,
      [name]: value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Submitted User Details:', userDetails);
  };

  const MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24 ;
  function dayDifference(date1, date2){
    
    const timeDiff =  Math.abs(date2.getTime() - date1.getTime());
    const diffDays = Math.ceil(timeDiff / MILLISECONDS_PER_DAY);
    return diffDays;
  }

  const days = dayDifference(checkinDate, checkoutDate);

 // {days * room.data.price}

 

      const bookings = 
      {
        hotel: hotelId,
        user: user._id,
        room: selectedRooms,
        check_in: checkinDate,
        check_out: checkoutDate,
      }

  const makePayment = async () => {
    const bookingResponse = await axios.post("http://localhost:8800/api/bookings", bookings);
    // console.log(bookingResponse.data._id);
    if (bookingResponse.status !== 200 && bookingResponse.status !== 201) {
      throw new Error('Failed to save booking');
    }

    console.log('Booking successfully saved to database');

    const stripe = await loadStripe('pk_test_51PWhVjFgV1sC8V5tlzJolMHETRssDUrXPMw9c3bMV5JcMGMJl9CExdopgNNJvgi4Tn8cOdhnLDBIZWhDoyVb8Ppt00KxkGVqyi');

    //const carts = [{id: 'room_101', name: 'Deluxe Room', price: 100, quantity: 1},{id: 'room_102', name: 'Suite Room', price: 200, quantity: 1}]
    
    const booking = 
      [{
        hotel: hotelId,
        user: user._id,
        username: user.username,
        room: selectedRooms,
        room_type:room.data.title,
        check_in: checkinDate,
        check_out: checkoutDate,
        price: days * room.data.price,
        booking_id:bookingResponse.data._id,
        quantity: 1
      }]

    const body = {
      products: booking
    };
    const headers = {
      "Content-Type": "application/json"
    };

    try {
      const response = await fetch("http://localhost:8800/api/payment/checkout_session", {
        method: "POST",
        headers: headers,
        body: JSON.stringify(body)
      });

      if (!response.ok) {
        console.error('Fetch response:', response);
        throw new Error('Network response was not ok');
      }

      const session = await response.json();
      const result = await stripe.redirectToCheckout({
        sessionId: session.id
      });

      if (result.error) {
        console.log(result.error);
      }
    } catch (error) {
      console.error('Error during payment:', error);
    }

  };


  return (
    <div className="booking-page">
      <div className="booking-details">
        <h2>Booking Details </h2>
        <p><strong>Check-in Date:</strong> {checkin}</p>
        <p><strong>Check-out Date:</strong> {checkout}</p>
        <p><strong>Hotel Name:</strong>  {hotel.data.name}</p>
        <p><strong>Room:</strong> {room.data.title}</p>
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
              value={userDetails.username}
              onChange={handleChange}
            />
          </div>
          <div className="form-group">
            <label htmlFor="email">Email:</label>
            <input
              type="email"
              id="email"
              name="email"
              value={userDetails.email}
              onChange={handleChange}
            />
          </div>
          <button type="submit" onClick={makePayment}>Pay now</button>
        </form>
      </div>
    </div>
  );
};

export default BookingPage;
