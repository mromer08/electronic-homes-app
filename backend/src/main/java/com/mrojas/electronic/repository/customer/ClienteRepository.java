package com.mrojas.electronic.repository.customer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.customer.Cliente;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Integer>{
    public boolean existsByNit(String nit);
}
