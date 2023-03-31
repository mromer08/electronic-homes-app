package com.mrojas.electronic.service.employee;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.employee.Rol;
import com.mrojas.electronic.repository.employee.RolRepository;

@Service
public class RolService {
    @Autowired
    RolRepository rolRepository;

    public List<Rol> getRoles(){
        return rolRepository.findAll();
    }

    public Optional<Rol> getRolById(Integer id){
        return rolRepository.findById(id);
    }
}
