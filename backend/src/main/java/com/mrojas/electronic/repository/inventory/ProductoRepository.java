package com.mrojas.electronic.repository.inventory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.inventory.Marca;
import com.mrojas.electronic.model.inventory.Producto;

@Repository
public interface ProductoRepository extends JpaRepository<Producto, Integer> {
    public long countByMarca(Marca marca);
}
