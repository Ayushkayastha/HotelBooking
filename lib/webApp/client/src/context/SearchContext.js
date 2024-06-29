import { createContext, useEffect, useReducer } from "react";


const INITIAL_STATE = {
    city: undefined,
    dates: JSON.parse(localStorage.getItem("selectedDates")) || { startDate: null, endDate: null },
    options: {
        adult: undefined,
        children: undefined,
        room: JSON.parse(localStorage.getItem("selectedRooms")) || 1, // Default room is a single room with quantity 1,
    },
};


export const SearchContext = createContext(INITIAL_STATE)

const SearchReducer = (state, action) => {
    switch(action.type){
        case "NEW_SEARCH":
            return action.payload
        case "RESET_SEARCH":
            return INITIAL_STATE
        default:
            return state;
    }};

    export const SearchContextProvider = ({children}) => {
        const [state, dispatch] = useReducer(SearchReducer, INITIAL_STATE);

        useEffect(() => {
            localStorage.setItem("selectedDates", JSON.stringify(state.dates));
            localStorage.setItem("selectedRooms", JSON.stringify(state.options.room));
          }, [state.dates, state.options.room]);

        return (
            <SearchContext.Provider
            value={{
                city: state.city,
                dates: state.dates,
                options: state.options,
                dispatch,
            }}
            >
                {children}
            </SearchContext.Provider>
        )
    }