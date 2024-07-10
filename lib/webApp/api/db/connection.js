import mongoose from "mongoose";
import { DB_Name } from "../constant.js";

const connectDB = async () => {
try {
    const connectInstance = await mongoose.connect(`${process.env.MONGO}${DB_Name}`);
    console.log("Connection to mongodb successful || host : ", connectInstance.connection.host)
  } catch (error) {
    console.log("Mongodb connection failed \n", error)
    process.exit(1)
  }
}

export default connectDB;