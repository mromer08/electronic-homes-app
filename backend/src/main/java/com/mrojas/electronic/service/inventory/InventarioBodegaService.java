package com.mrojas.electronic.service.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.inventory.InventarioBodega;
import com.mrojas.electronic.repository.inventory.InventarioBodegaRepository;
import com.mrojas.electronic.repository.inventory.ProductoRepository;

@Service
public class InventarioBodegaService {
    @Autowired
    InventarioBodegaRepository inventarioBodegaRepository;
    @Autowired
    ProductoRepository productoRepository;

    public List<InventarioBodega> getInventarioBodegas(){
        return inventarioBodegaRepository.findAll();
    }

    public InventarioBodega saveInventarioBodega(InventarioBodega inventarioBodega){
        return inventarioBodegaRepository.save(inventarioBodega);
    }

    public Optional<InventarioBodega> getInventarioBodegaById(Integer id){
        return inventarioBodegaRepository.findById(id);
    }

    public boolean deleteInventarioBodega(Integer id){
        if (inventarioBodegaRepository.existsById(id)) {
            inventarioBodegaRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Optional<InventarioBodega> getInventarioBodegaByProducto(Integer idProducto){
        if (productoRepository.existsById(idProducto)) {
            return inventarioBodegaRepository.findByProducto(productoRepository.findById(idProducto).get());   
        }
        return Optional.empty();
    }

    public boolean updateInventarioBodega(Integer id, InventarioBodega inventarioBodega){
        if (inventarioBodegaRepository.existsById(id)) {
            inventarioBodegaRepository.save(inventarioBodega);
            return true;
        }
        return false;
    }
}
