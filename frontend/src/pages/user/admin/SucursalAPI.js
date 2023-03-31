import axios from "axios";
const url = "http://localhost:8080/api/sucursal";

const getSucursales = async () => {
  const response = await axios.get(url);
  console.log(response.data);
};

const getSucursal = async (id) => {
  const response = await axios.get(`${url}/${id}`);
  return response.data;
};

export { getSucursales, getSucursal };
