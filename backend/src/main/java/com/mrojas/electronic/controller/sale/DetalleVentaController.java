package com.mrojas.electronic.controller.sale;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.sale.DetalleVenta;
import com.mrojas.electronic.model.sale.Venta;
import com.mrojas.electronic.service.sale.DetalleVentaService;

@RestController
@RequestMapping("/api/detalle-venta")
public class DetalleVentaController {
    @Autowired
    DetalleVentaService detalleVentaService;

    @GetMapping()
    public List<DetalleVenta> getDetallesVentas(){
        return detalleVentaService.getDetallesVentas();
    }

    @PostMapping()
    public DetalleVenta saveDetalleVenta(@RequestBody DetalleVenta detalleVenta){
        return detalleVentaService.saveDetalleVenta(detalleVenta);
    }

    @GetMapping(path = "/venta/{id}")
    public List<DetalleVenta> getDetallesVentasByVenta(@PathVariable("id") Integer id, @RequestBody Venta venta){
        return detalleVentaService.getDetalleByVenta(venta);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteDetalleVenta(@PathVariable("id") Integer id){
        if (detalleVentaService.deleteDetalleVenta(id)) {
            return "Delete succes of Detalle-venta with id " + id;
        }else{
            return "Error: Delete failed of Detalle-venta with id " + id;
        }
    }

    @PatchMapping(path = "/{id}")
    public String updateProduct(@PathVariable("id") Integer id, @RequestBody DetalleVenta detalleVenta){
        if(detalleVentaService.updateDetalleVenta(id, detalleVenta)){
            return "Detalle-venta updated";
        }
        return "Error: Not updated";
    }


}
