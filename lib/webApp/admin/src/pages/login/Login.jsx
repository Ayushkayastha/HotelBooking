import { useContext, useState } from "react"
import "./login.css"

import axios from "axios";
import { useNavigate } from "react-router-dom";
import { AUTHContext } from "../../context/AuthContext";

const Login = () => {
    const [credentials, setCredentials] = useState({
        username: undefined,
        password: undefined,
    });

    const { loading, error, dispatch} = useContext( AUTHContext );

    const navigate = useNavigate()

    const handleChange = (e) => {
      setCredentials(prev => ({...prev, [e.target.id]: e.target.value }));
    };

    const handleClick =async (e) => {
      e.preventDefault()    // it prevents the default form submission behavior, which would cause a page reload.
      dispatch({type:"LOGIN_START"})
      try {
        const res = await axios.post("/auth/login", credentials, { withCredentials: true });
        if(res.data.isAdmin){
          
          dispatch({ type: "LOGIN_SUCCESS", payload: res.data.details });
          navigate("/");
        }else{
          dispatch({type:"LOGIN_FAILURE", payload: {message:"You are not allowed"}})
        }
      } catch (error) {
        dispatch({type:"LOGIN_FAILURE", payload: error.response.data})
      }
    }

  return (
    <div className="login">
      <div className="lContainer">
        <input type="text" placeholder="username" id="username" onChange={handleChange} className="lInput" />
        <input type="password" placeholder="password" id="password" onChange={handleChange} className="lInput" />
        <button disabled={loading} onClick={handleClick} className="lButton">Login</button>
        {error && <span>{error.message}</span>}
      </div>
    </div>
  )
}

export default Login
