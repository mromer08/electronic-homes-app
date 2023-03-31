package com.mrojas.electronic.repository.employee;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.employee.Rol;

@Repository
public interface RolRepository extends JpaRepository<Rol, Integer>{
    
}
