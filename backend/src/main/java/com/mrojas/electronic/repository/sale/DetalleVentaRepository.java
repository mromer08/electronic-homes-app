package com.mrojas.electronic.repository.sale;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.inventory.Producto;
import com.mrojas.electronic.model.sale.DetalleVenta;
import com.mrojas.electronic.model.sale.Venta;

@Repository
public interface DetalleVentaRepository extends JpaRepository<DetalleVenta, Integer>{
    public List<DetalleVenta> findAllByVenta(Venta venta);
    public List<DetalleVenta> findAllByProducto(Producto producto);
}
