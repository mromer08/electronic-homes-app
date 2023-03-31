import axios from 'axios'
const url = 'http://localhost:8080/api/producto'

const getProductos = async (state) => {
    const response = await axios.get(url);
    state(response.data.results);

};

export{
    getProductos
}