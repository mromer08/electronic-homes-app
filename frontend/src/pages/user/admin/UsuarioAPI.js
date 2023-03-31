import axios from 'axios'
const url = 'http://localhost:8080/api/usuario'

const getUsuarios = async (state) => {
    const response = await axios.get(url);
    state(response.data);
};

const newUsuario = async (user) => {
    const response = await axios.post(url, user);
    return response.data;
}

const deleteUsuario = async (id) => {
    console.log("estoy haciendo desmadres apui")
    const response = await axios.delete(`${url}/${id}`);
    return response.data;
}

export{
    getUsuarios,
    newUsuario,
    deleteUsuario,
}