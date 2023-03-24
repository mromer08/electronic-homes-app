package com.mrojas.electronic.service.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.inventory.Marca;
import com.mrojas.electronic.model.inventory.Producto;
import com.mrojas.electronic.repository.inventory.ProductoRepository;

@Service
public class ProductoService {
    @Autowired
    ProductoRepository productoRepository;

    public List<Producto> getProducts(){
        return (List<Producto>) productoRepository.findAll();
    }

    public Producto saveProduct(Producto producto){
        return productoRepository.save(producto);
    }

    public Optional<Producto> getProductById(Integer id){
        return productoRepository.findById(id);
    }

    public boolean deleteProduct(Integer id) {
        if (productoRepository.existsById(id)) {
            productoRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public long countByMarca(Marca marca){
        return productoRepository.countByMarca(marca);
    }

    public boolean updateProduct(Integer id, Producto producto){
        if (productoRepository.existsById(id)) {
            producto.setId(id);
            productoRepository.save(producto);
            return true;
        }
        return false;
    }
}
