import axios from 'axios'
const url = 'http://localhost:8080/api/rol'

const getRoles = async () => {
    const response = await axios.get(url);
    console.log(response.data);
}

const getRol = async (id) => {
    const response = await axios.get(`${url}/${id}`);
    return response.data;
}

export{
    getRoles,
    getRol
}