package com.mrojas.electronic.controller.sale;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.sale.Venta;
import com.mrojas.electronic.service.sale.VentaService;

@RestController
@RequestMapping("/api/venta")
public class VentaController {
    @Autowired
    VentaService ventaService;

    @GetMapping()
    public List<Venta> getVentas(){
        return ventaService.getVentas();
    }

    @PostMapping()
    public Venta saveVenta(@RequestBody Venta venta){
        return ventaService.saveVenta(venta);
    }

    @GetMapping(path = "/{id}")
    public Optional<Venta> getVentaById(@PathVariable("id") Integer id){
        return ventaService.getVentaById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteVenta(@PathVariable("id") Integer id){
        if (ventaService.deleteVenta(id)) {
            return "Delete success of venta with id " + id;
        }
        return "Error: Delete failed of venta with id " + id;
    }
}
