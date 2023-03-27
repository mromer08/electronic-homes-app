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

import com.mrojas.electronic.model.inventory.InventarioSucursal;
import com.mrojas.electronic.service.inventory.InventarioSucursalService;

@RestController
@RequestMapping("/api/inventario-sucursal")
public class InventarioSucursalController {
    @Autowired
    InventarioSucursalService inventarioSucursalService;

    @GetMapping()
    public List<InventarioSucursal> getInventariosSucursales(){
        return inventarioSucursalService.getInventariosSucursales();
    }

    @PostMapping()
    public InventarioSucursal saveInventarioSucursal(@RequestBody InventarioSucursal inventarioSucursal){
        return inventarioSucursalService.saveInventarioSucursal(inventarioSucursal);
    }

    @GetMapping(path = "/{id}")
    public Optional<InventarioSucursal> getInventarioSucursalById(@PathVariable("id") Integer id){
        return inventarioSucursalService.getInventarioSucursalById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteInventarioSucursal(@PathVariable("id") Integer id){
        if (inventarioSucursalService.deleteInventarioSucursal(id)) {
            return "Delete succes of register on inventario-sucursal with id " + id;
        } else {
            return "Error: Delete failed of register on inventario-sucursal with id " + id;
        }
    }
    @PatchMapping(path = "/{id}")
    public String updateInventarioSucursal(@PathVariable("id") Integer id, @RequestBody InventarioSucursal inventarioSucursal){
        if (inventarioSucursalService.updateInventarioBodega(id, inventarioSucursal)) {
            return "Inventario-sucursal updated";
        }
        return "Error: not updated";
    }

    @GetMapping(path = "/producto/{id}")
    public List<InventarioSucursal> getInventarioSucursalByProducto(@PathVariable("id") Integer id){
        return inventarioSucursalService.getInventarioSucursalByProducto(id);
    }

    @GetMapping(path = "/sucursal/{id}")
    public List<InventarioSucursal> getInventariosBySucursal(@PathVariable("id") Integer id){
        return inventarioSucursalService.getInventariosBySucursal(id);
    }
}
