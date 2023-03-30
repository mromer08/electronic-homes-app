package com.mrojas.electronic.repository.sale;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.customer.Cliente;
import com.mrojas.electronic.model.employee.Empleado;
import com.mrojas.electronic.model.sale.Venta;

@Repository
public interface VentaRepository extends JpaRepository<Venta, Integer>{
    public long countByCliente(Cliente cliente);
    public long countByEmpleado(Empleado empleado);
    // @Query("SELECT v.*, SUM(dv.cantidad * p.precio) * (1 - v.descuento) as total FROM ControlVentas.Venta v INNER JOIN ControlVentas.DetalleVenta dv ON v.id = dv.id_venta INNER JOIN ControlInventario.Producto p ON dv.id_producto = p.id WHERE v.id_cliente = :id_cliente GROUP BY v.id")
    // public List<Venta> findByCliente(@Param("id_cliente") Integer id_cliente, Pageable pageable);

    // @Query("SELECT v.*, SUM(dv.cantidad * p.precio) * (1 - v.descuento) as total FROM ControlVentas.Venta v INNER JOIN ControlVentas.DetalleVenta dv ON v.id = dv.id_venta INNER JOIN ControlInventario.Producto p ON dv.id_producto = p.id WHERE v.id_empleado = :id_empleado GROUP BY v.id")
    // public List<Venta> findByEmpleado(@Param("id_empleado") Integer id_empleado);

    // @Query("SELECT v.*, SUM(dv.cantidad * p.precio) * (1 - v.descuento) as total FROM ControlVentas.Venta v INNER JOIN ControlVentas.DetalleVenta dv ON v.id = dv.id_venta INNER JOIN ControlInventario.Producto p ON dv.id_producto = p.id WHERE v.id = :id GROUP BY v.id")
    // public Optional<Venta> findById(@Param("id") Integer id);

    // @Query(value = "SELECT v.*, SUM(dv.cantidad * p.precio) * (1 - v.descuento) as total FROM controlventas.Venta v INNER JOIN controlventas.DetalleVenta dv ON v.id = dv.id_venta INNER JOIN controlinventario.Producto p ON dv.id_producto = p.id GROUP BY v.id",
    // nativeQuery = true)
    // public List<Venta> findAll();
    
}
