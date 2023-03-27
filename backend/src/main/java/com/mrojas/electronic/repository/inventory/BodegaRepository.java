package com.mrojas.electronic.repository.inventory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.inventory.Bodega;

@Repository
public interface BodegaRepository extends JpaRepository<Bodega, Integer> {
    
}
