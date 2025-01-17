import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import Home from "./pages/home/Home";
import Hotel from "./pages/hotel/Hotel";
import List from "./pages/list/List";
import Login from "./pages/login/Login";
import Register from "./pages/Register";
import VerifyCode from "./pages/VerifyCode";
import Booking from "./pages/Booking/Booking";
import Success from "./components/redirect/Success";
import Cancel from "./components/redirect/Cancel";
import MyBooking from "./pages/MyBooking/MyBooking"
import HotelForm from "./pages/HotelForm/HotelForm";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/hotels" element={<List />} />
        <Route path="/hotels/:id" element={<Hotel />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/verify" element={<VerifyCode />} />
        <Route path="/booking" element={<Booking />}/>
        <Route path="/success" element={<Success />}/>
        <Route path="/cancel" element={<Cancel />}/>
        <Route path="/MyBooking" element={<MyBooking />}/>
        <Route path="/list-property" element={<HotelForm />}/>
      </Routes>
    </BrowserRouter>
  );
}


export default App;
