package com.mrojas.electronic.service.branch;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.branch.Sucursal;
import com.mrojas.electronic.repository.branch.SucursalRepository;

@Service
public class SucursalService {
    @Autowired
    SucursalRepository sucursalRepository;

    public List<Sucursal> getSucursales(){
        return sucursalRepository.findAll();
    }

    public Optional<Sucursal> getSucursalById(Integer id){
        return sucursalRepository.findById(id);
    }
}
