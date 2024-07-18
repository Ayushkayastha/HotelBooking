import mongoose from "mongoose";

const VerificationCodeSchema = new mongoose.Schema({
  email: { type: String, required: true },
  code: { type: String, required: true },
  createdAt: { type: Date, default: Date.now, expires: 30000 } // Code expires in 5 minutes
});

const VerificationCode = mongoose.model("VerificationCode", VerificationCodeSchema);
export default VerificationCode;
