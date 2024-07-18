import express from "express";
import { login, register, sendVerificationCode, verifyCode } from "../controllers/auth.js";

const router = express.Router();


router.post("/register", register)

router.post("/sendVerificationCode",sendVerificationCode)

router.post("/verifyCode",verifyCode)

router.post("/login", login)

export default router