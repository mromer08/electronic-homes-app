package com.mrojas.electronic.controller.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.inventory.Bodega;
import com.mrojas.electronic.service.inventory.BodegaService;

@RestController
@RequestMapping("/api/bodega")
public class BodegaController {
    @Autowired
    BodegaService bodegaService;

    @GetMapping()
    public List<Bodega> getBodegas(){
        return bodegaService.getBodegas();
    }

    @GetMapping(path = "/{id}")
    public Optional<Bodega> getBodegaById(@PathVariable("id") Integer id){
        return bodegaService.getBodegaById(id);
    }
}
