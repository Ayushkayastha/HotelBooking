export const userColumns = [
  { field: "_id", headerName: "ID", width: 160 },
  {
    field: "user",
    headerName: "User",
    width: 130,
    renderCell: (params) => {
      return (
        <div className="cellWithImg">
          <img className="cellImg" src={params.row.img || "https://i.ibb.co/MBtjqXQ/no-avatar.gif"} alt="avatar" />
          {params.row.username}
        </div>
      );
    },
  },
  {
    field: "email",
    headerName: "Email",
    width: 200,
  },

  {
    field: "country",
    headerName: "Country",
    width: 100,
  },

  {
    field: "city",
    headerName: "City",
    width: 100,
  },

  {
    field: "phone",
    headerName: "Phone",
    width: 150,
  },
  
];

export const hotelColumns = [
  { field: "_id", headerName: "ID", width: 250 },
  {
    field: "name",
    headerName: "Name",
    width: 200,
  },

  {
    field: "type",
    headerName: "Type",
    width: 100,
  },

  {
    field: "title",
    headerName: "Title",
    width: 230,
  },

  {
    field: "city",
    headerName: "City",
    width: 100,
  },  
];

export const roomColumns = [
  { field: "_id", headerName: "ID", width: 250 },
  {
    field: "title",
    headerName: "Title",
    width: 230,
  },

  {
    field: "desc",
    headerName: "Description",
    width: 200,
  },

  {
    field: "price",
    headerName: "Price",
    width: 100,
  }, 
  
  {
    field: "maxPeople",
    headerName: "Max People",
    width: 100,
  },
];

export const bookingColumns = [
  { field: "_id", headerName: "ID", width: 130 },
  {
    field: "hotel",
    headerName: "Hotel",
    width: 130,
  },

  {
    field: "room",
    headerName: "Room",
    width: 130,
  },

  {
    field: "user",
    headerName: "User",
    width: 130,
  }, 
  
  {
    field: "check_in",
    headerName: "Check_in",
    width: 120,
  },

  {
    field: "check_out",
    headerName: "Check_out",
    width: 120,
  },

  {
    field: "status",
    headerName: "Status",
    width: 100,
  },
];

