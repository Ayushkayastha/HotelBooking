import User from "../models/User.js";
import bcrypt from "bcryptjs";
import { createError } from "../utils/error.js";
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";
import VerificationCode from "../models/VerificationCode.js";
import Booking from "../models/Booking.js";



// Send verification code
export const sendVerificationCode = async (req, res, next) => {
// Configure nodemailer
const transporter = nodemailer.createTransport({
  //host: process.env.HOST,
            service: process.env.SERVICE,
           // port: Number(process.env.EMAIL_PORT),
           // secure: Boolean(process.env.SECURE),
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

  const { email } = req.body;

  try {
    const code = Math.floor(100000 + Math.random() * 900000).toString();

    // Save verification code to database
    const newCode = new VerificationCode({ email, code });
    await newCode.save();

    //console.log('Email User:', process.env.EMAIL_USER);
//console.log('Email Pass:', process.env.EMAIL_PASS);
//console.log('to:', email);


    // Send email
    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: email,
      subject: 'Your Verification Code',
      text: `Your verification code is ${code}`,
    });

    console.log("Email sent Successfully");

    res.status(200).send("Verification code sent.");
  } catch (err) {
    next(err);
  }
};

// Verify the code
export const verifyCode = async (req, res, next) => {
  //console.log("Verify code")
  const { email, code } = req.body;
  //console.log(email, code)

  try {
    const storedCode = await VerificationCode.findOne({ email, code });
   // console.log(storedCode)
    if (!storedCode) {
      return next(createError(400, "Invalid verification code"));
    }

    res.status(200).send("Verification successful");
  } catch (err) {
    next(err);
  }
};

// Register user
export const register = async (req, res, next) => {
  try {
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(req.body.password, salt);

    const newUser = new User({
      ...req.body,
      password: hash,
    });

    await newUser.save();
    res.status(200).send("User has been created successfully");
  } catch (error) {
    next(error);
  }
};

export const login = async (req, res, next) => {
  try {
    const user = await User.findOne({ username: req.body.username });

    if (!user) return next(createError(404, "User not found"));

    const isPasswordCorrect = await bcrypt.compare(req.body.password, user.password);

    if (!isPasswordCorrect) return next(createError(400, "Wrong password or username"));

    const token = jwt.sign({ id: user._id, isAdmin: user.isAdmin }, process.env.JWT);//, { expiresIn: '1h' });

    const { password, isAdmin, ...otherDetails } = user._doc;

    res
      .cookie("access_token", token, {
        httpOnly: true,
      })
      .status(200)
      .json({ details: { ...otherDetails }, isAdmin });
  } catch (error) {
    next(error);
  }
};

export const verifyBookingOwnership = async (req, res, next) => {
  const booking = await Booking.findById(req.body.bookingId);

   console.log(booking.user.toString());
  // console.log(req.body.user);
  //console.log(req.user.id);
  if (booking.user.toString() !== req.user.id) {
    return res.status(403).json({ message: 'Unauthorized' });
  }

  next();
};
