package com.mrojas.electronic.service.sale;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.inventory.Producto;
import com.mrojas.electronic.model.sale.DetalleVenta;
import com.mrojas.electronic.model.sale.Venta;
import com.mrojas.electronic.repository.sale.DetalleVentaRepository;

@Service
public class DetalleVentaService {
    @Autowired
    DetalleVentaRepository detalleVentaRepository;

    public List<DetalleVenta> getDetallesVentas(){
        return detalleVentaRepository.findAll();
    }

    public DetalleVenta saveDetalleVenta(DetalleVenta detalleVenta){
        return detalleVentaRepository.save(detalleVenta);
    }

    public List<DetalleVenta> getDetalleByVenta(Venta venta){
        return detalleVentaRepository.findAllByVenta(venta);
    }

    public List<DetalleVenta> getDetalleByProducto(Producto producto){
        return detalleVentaRepository.findAllByProducto(producto);
    }

    public boolean deleteDetalleVenta(Integer id){
        if (detalleVentaRepository.existsById(id)) {
            detalleVentaRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public boolean updateDetalleVenta(Integer id, DetalleVenta detalleVenta){
        if (detalleVentaRepository.existsById(id)) {
            detalleVentaRepository.save(detalleVenta);
            return true;
        }
        return false;
    }
}
