import React from "react";
import ReactDOM from "react-dom";
import App from "./App";
import { AUTHContextProvider } from "./context/AuthContext";

ReactDOM.render(
  <React.StrictMode>
    <AUTHContextProvider>
      <App />
    </AUTHContextProvider>
  </React.StrictMode>,
  document.getElementById("root")
);
