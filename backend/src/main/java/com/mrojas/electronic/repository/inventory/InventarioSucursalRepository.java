package com.mrojas.electronic.repository.inventory;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.branch.Sucursal;
import com.mrojas.electronic.model.inventory.InventarioSucursal;
import com.mrojas.electronic.model.inventory.Producto;

@Repository
public interface InventarioSucursalRepository extends JpaRepository<InventarioSucursal, Integer> {
    public List<InventarioSucursal> findByProducto(Producto producto);

    public List<InventarioSucursal> findAllBySucursal(Sucursal sucursal);
}
