package com.mrojas.electronic.controller.branch;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.branch.Sucursal;
import com.mrojas.electronic.service.branch.SucursalService;

@RestController
@RequestMapping("/api/sucursal")
public class SucursalController {
    
    @Autowired
    SucursalService sucursalService;

    @GetMapping()
    public List<Sucursal> getSucursales(){
        return sucursalService.getSucursales();
    }

    @GetMapping(path = "/{id}")
    public Optional<Sucursal> getSucursalById(@PathVariable("id") Integer id){
        return sucursalService.getSucursalById(id);
    }
}
