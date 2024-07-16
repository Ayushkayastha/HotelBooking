import cron from 'node-cron';
import { updateBookingStatus } from '../controllers/booking.js';

// Schedule the job to run every day at midnight
cron.schedule('0 0 * * *', async () => {
  console.log('Running updateBookingStatus job');
  await updateBookingStatus();
  console.log('Finished updateBookingStatus job');
});