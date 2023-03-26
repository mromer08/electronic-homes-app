package com.mrojas.electronic.repository.branch;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.branch.Sucursal;

@Repository
public interface SucursalRepository extends JpaRepository<Sucursal, Integer>{
    
}
