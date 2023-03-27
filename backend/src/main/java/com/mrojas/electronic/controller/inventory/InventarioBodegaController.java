package com.mrojas.electronic.controller.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.inventory.InventarioBodega;
import com.mrojas.electronic.service.inventory.InventarioBodegaService;

@RestController
@RequestMapping("/api/inventario-bodega")
public class InventarioBodegaController {
    @Autowired
    InventarioBodegaService inventarioBodegaService;

    @GetMapping()
    public List<InventarioBodega> getInventariosBodega(){
        return inventarioBodegaService.getInventarioBodegas();
    }

    @PostMapping()
    public InventarioBodega saveInventarioBodega(@RequestBody InventarioBodega inventarioBodega){
        return inventarioBodegaService.saveInventarioBodega(inventarioBodega);
    }

    @GetMapping(path = "/{id}")
    public Optional<InventarioBodega> getInventarioBodegaById(@PathVariable("id") Integer id){
        return inventarioBodegaService.getInventarioBodegaById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteInventarioBodega(@PathVariable("id") Integer id){
        if (inventarioBodegaService.deleteInventarioBodega(id)) {
            return "Delete succes of register on inventario-bodega with id " + id;
        } else {
            return "Error: Delete failed of register on inventario-bodega with id " + id;
        }
    }

    @PatchMapping(path = "/{id}")
    public String updateInventarioBodega(@PathVariable("id") Integer id, @RequestBody InventarioBodega inventarioBodega){
        if (inventarioBodegaService.updateInventarioBodega(id, inventarioBodega)) {
            return "Inventario-bodega updated";
        } else {
            return "Error: not updated";
        }
    }

    @GetMapping(path = "/producto/{id}")
    public Optional<InventarioBodega> getInventarioBodegaByProducto(@PathVariable("id") Integer id){
        return inventarioBodegaService.getInventarioBodegaByProducto(id);
    }
}
