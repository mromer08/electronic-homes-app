package com.mrojas.electronic.repository.inventory;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.inventory.InventarioBodega;
import com.mrojas.electronic.model.inventory.Producto;

@Repository
public interface InventarioBodegaRepository extends JpaRepository<InventarioBodega, Integer> {
    public Optional<InventarioBodega> findByProducto(Producto producto);
}
