import express from "express";
import { deleteUser, getUser, getallUser, updateUser } from "../controllers/user.js";
import { verifyAdmin, verifyToken, verifyUser } from "../utils/verifyToken.js";

const router = express.Router();

// router.get("/checkauthentication", verifyToken, (req, res, next) => {
//     res.send("Hello user, you are logged in")
// })

// router.get("/checkuser/:id", verifyUser, (req, res, next) => {
//     res.send("Hello user, you are logged in and you can delete your account")
// })

// router.get("/checkadmin/:id", verifyAdmin, (req, res, next) => {
//     res.send("Hello admin, you are logged in and you can delete all account")
// })

//UPDATE

router.put("/:id", updateUser)

//DELETE

router.delete("/:id", verifyUser, deleteUser)

//GET

router.get("/:id", getUser)

//GET ALL

router.get("/", verifyAdmin, getallUser)

export default router