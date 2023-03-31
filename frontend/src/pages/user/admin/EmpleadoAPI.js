import axios from 'axios'
const url = 'http://localhost:8080/api/empleado'

const newEmpleado = async (empleado) => {
    const response = await axios.post(url, empleado);
    console.log(response.data);
}

const deleteEmpleado = async (id) => {
    const response = await axios.delete(`${url}/${id}`);
    return response.data;
}

export{
    newEmpleado,
    deleteEmpleado,
}