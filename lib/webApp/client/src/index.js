import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { SearchContextProvider } from './context/SearchContext';
import { AUTHContextProvider } from './context/AuthContext';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <AUTHContextProvider>
    <SearchContextProvider>
    <App />
    </SearchContextProvider>
    </AUTHContextProvider>
  </React.StrictMode>
);
