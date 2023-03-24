package com.mrojas.electronic.repository.inventory;

import org.springframework.data.jpa.repository.JpaRepository;
import com.mrojas.electronic.model.inventory.Marca;

public interface MarcaRepository extends JpaRepository<Marca, Integer> {
}
