import jwt from "jsonwebtoken";
import { createError } from "./error.js";
import User from "../models/User.js";

export const verifyToken = async (req, res, next) => {
  // Initialize the token variable
  let token;

  // Check if token is present in cookies
  if (req.cookies.access_token) {
    token = req.cookies.access_token;
  }

  // Check if token is present in headers
  const authHeader = req.headers['authorization'];
  if (authHeader) {
    token = authHeader.split(' ')[1]; // Bearer <token>
  }

  // If no token is found, return an authentication error
  if (!token) {
    return next(createError(401, "You are not authenticated"));
  }

  try {
    // Verify the token
    const decoded = jwt.verify(token, process.env.JWT);
    req.user = await User.findById(decoded.id).select('-password');
    next();
  } catch (err) {
    // If token verification fails, return an error
    return next(createError(403, "Token is not valid"));
  }
};

export const verifyUser = (req, res, next) => {
  verifyToken(req, res, async () => {
    if (req.user.id === req.params.userId || req.user.isAdmin) {
      next();
    } else {
      return next(createError(403, "You are not authorized"));
    }
  });
};

export const verifyAdmin = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.isAdmin) {
      next();
    } else {
      return next(createError(403, "You are not authorized"));
    }
  });
};
