import axios from 'axios';
import React, { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';

const SuccessPage = () => {
  const location = useLocation();
  const sessionId = new URLSearchParams(location.search).get('session_id');
  const bookingId = new URLSearchParams(location.search).get('booking_id');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const handleClick = (e) => {
    e.preventDefault();
    navigate("/");
  }

    const confirmBooking = async () => {
      // console.log("inside confirm booking")
      if (!sessionId || !bookingId) {
        console.log('No session ID or booking ID found in URL');
        setLoading(false);
        // console.log("inside no ids")
        return;
      }

      try {
        // console.log('Confirming booking with session ID:', sessionId, 'and booking ID:', bookingId);
        const response = await axios.get(`http://localhost:8800/api/payment/update-booking-status?session_id=${sessionId}&booking_id=${bookingId}`);
        // console.log("hello",response)
        if (response.data.error) {
          throw new Error(response.data.error);
        }

        // console.log('Booking successfully confirmed');
      } catch (error) {
        console.error('Error confirming booking:', error);
        setError(error.message);
        // console.log("catch")
      } finally {
        setLoading(false);
        // console.log("finally")
      }
    };
    // console.log("before confirm booking")
    confirmBooking();
    // console.log("after confirm booking")
    if (loading) {
        return <div>Loading...</div>;
  }
  
  if (error) {
    return <div>Error: {error}</div>;
  }
  
  return (
    <div>
      <h1>Payment Successful</h1>
      <p>Your booking is confirmed.</p>
      <button onClick={handleClick}>Home</button>
    </div>
  );

};
  
export default SuccessPage;
