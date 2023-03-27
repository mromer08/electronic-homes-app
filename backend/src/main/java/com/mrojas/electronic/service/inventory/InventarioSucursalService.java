package com.mrojas.electronic.service.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.inventory.InventarioSucursal;
import com.mrojas.electronic.repository.branch.SucursalRepository;
import com.mrojas.electronic.repository.inventory.InventarioSucursalRepository;
import com.mrojas.electronic.repository.inventory.ProductoRepository;

@Service
public class InventarioSucursalService {
    @Autowired
    InventarioSucursalRepository inventarioSucursalRepository;
    @Autowired
    ProductoRepository productoRepository;
    @Autowired
    SucursalRepository sucursalRepository;

    public List<InventarioSucursal> getInventariosSucursales(){
        return inventarioSucursalRepository.findAll();
    }

    public InventarioSucursal saveInventarioSucursal(InventarioSucursal inventarioSucursal){
        return inventarioSucursalRepository.save(inventarioSucursal);
    }

    public Optional<InventarioSucursal> getInventarioSucursalById(Integer id){
        return inventarioSucursalRepository.findById(id);
    }

    public boolean deleteInventarioSucursal(Integer id){
        if (inventarioSucursalRepository.existsById(id)) {
            inventarioSucursalRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public List<InventarioSucursal> getInventarioSucursalByProducto(Integer idProducto){
        if (productoRepository.existsById(idProducto)) {
            return inventarioSucursalRepository.findByProducto(productoRepository.findById(idProducto).get());
        }
        return null;
    }

    public boolean updateInventarioBodega(Integer id, InventarioSucursal inventarioSucursal){
        if (inventarioSucursalRepository.existsById(id)) {
            inventarioSucursalRepository.save(inventarioSucursal);
            return true;
        }
        return false;
    }

    public List<InventarioSucursal> getInventariosBySucursal(Integer idSucursal){
        if (sucursalRepository.existsById(idSucursal)) {
            return inventarioSucursalRepository.findAllBySucursal(sucursalRepository.findById(idSucursal).get());
        }
        return null;
    }
}
