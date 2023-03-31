package com.mrojas.electronic.controller.employee;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.employee.Rol;
import com.mrojas.electronic.service.employee.RolService;

@RestController
@RequestMapping("/api/rol")
public class RolController {
    @Autowired
    RolService rolService;

    @GetMapping()
    public List<Rol> getRoles(){
        return rolService.getRoles();
    }

    @GetMapping(path = "/{id}")
    public Optional<Rol> getRolById(@PathVariable("id") Integer id){
        return rolService.getRolById(id);
    }
}
