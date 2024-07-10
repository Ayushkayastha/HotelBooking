import Stripe from 'stripe';
import dotenv from 'dotenv';
import Booking from '../models/Booking.js';
//import Booking from '../models/Booking.js';
dotenv.config();

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY)

export const paymentIntent = async (req, res, next) => {
  try {
    const { products } = req.body;
     console.log(products);

    if (!products) {
      return res.status(400).json({ error: 'Products not provided in request body' });
    }

    const lineItems = products.map((product) => ({
      price_data: {
        currency: "usd",
        product_data: {
          name: product.room_type,
        },
        unit_amount: product.price * 100, // Stripe expects the amount in the smallest currency unit (e.g., paise for INR)
      },
      quantity: product.quantity,
    }));

    const metadata = {
      hotel: products[0].hotel.toString(),
      user: products[0].user.toString(),
      room: products[0].room.toString(),
      check_in: new Date(products[0].check_in).toISOString(),
      check_out: new Date(products[0].check_out).toISOString(),
    }; 

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      line_items: lineItems,
      mode: "payment",
      success_url: `http://localhost:3000/success?session_id={CHECKOUT_SESSION_ID}&booking_id=${products[0].booking_id}`,
      cancel_url: "http://localhost:3000/cancel",
      metadata: metadata,
    });

    res.json({ id: session.id });
    // console.log(session.id);
  } catch (error) {
    next(error);
  }
};

export const retrieveSession = async (req, res, next) => {

  // console.log('retrieveSession endpoint hit');
  const { session_id } = req.query;

  try {
    const session = await stripe.checkout.sessions.retrieve(session_id);
    res.json(session);
  } catch (error) {
    next(error);
  }
};

export const updateBookingStatus = async (req, res) => {
  const { session_id, booking_id } = req.query;

  // console.log('Received session_id:', session_id);
  // console.log('Received booking_id:', booking_id);

  if (!session_id || !booking_id) {
    // console.log('Missing session_id or booking_id');
    return res.status(400).json({ error: 'Missing session_id or booking_id' });
  }

  try {
    const session = await stripe.checkout.sessions.retrieve(session_id);

    if (session.payment_status === 'paid') {
      const booking = await Booking.findById(booking_id);

      if (booking && booking.status === 'pending') {
        booking.status = 'confirmed';
        await booking.save();
        res.json({ message: 'Booking confirmed', booking });
      } else {
        // console.log('Booking already confirmed or not found');
        res.json({ message: 'Booking already confirmed', booking });
        //res.status(400).json({ error: 'Booking already confirmed or not found' });
      }
    } else {
      console.log('Payment not successful');
      res.status(400).json({ error: 'Payment not successful' });
    }
  } catch (error) {
    console.log('Error in updating booking status:', error.message);
    res.status(500).json({ error: error.message });
  }
};


// export const handleStripeWebhook = async (req, res, next) => {
//   const sig = req.headers['stripe-signature'];
//   const endpointSecret = process.env.STRIPE_WEBHOOK_SECRET;

//   let event;

//   try {
//     event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
//   } catch (err) {
//     return res.status(400).send(`Webhook Error: ${err.message}`);
//   }

//   if (event.type === 'checkout.session.completed') {
//     const session = event.data.object;
//     const { hotel, user, room, checkin, checkout } = session.metadata;

//     // Save the booking details to the database
//     // Use your preferred method to save to your database
//     const booking = {
//       hotel,
//       user,
//       room,
//       checkin: new Date(checkin),
//       checkout: new Date(checkout),
//     };

//     // Assuming you have a Booking model
//     // await Booking.create(booking);

//     console.log('Booking saved:', booking);

//     try {
//       // Save the booking to the database here
//       await Booking.create(booking);
//     } catch (err) {
//       console.error('Error saving booking:', err.message);
//     }

//   }

//   res.json({ received: true });
// };