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

import com.mrojas.electronic.model.inventory.Marca;
import com.mrojas.electronic.model.inventory.Producto;
import com.mrojas.electronic.service.inventory.ProductoService;

@RestController
@RequestMapping("/api/producto")
public class ProductoController {
    
    @Autowired
    ProductoService productoService;

    @GetMapping()
    public List<Producto> getProducts(){
        return productoService.getProducts();
    }

    @PostMapping()
    public Producto saveProduct(@RequestBody Producto producto){
        return productoService.saveProduct(producto);
    }

    @GetMapping(path = "/{id}")
    public Optional<Producto> getProductById(@PathVariable("id") Integer id){
        return productoService.getProductById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteProduct(@PathVariable("id") Integer id){
        if (productoService.deleteProduct(id)) {
            return "Delete succes of product with id " + id;
        }else{
            return "Error: Delete failed of product with id " + id;
        }
    }

    @GetMapping(path = "/count")
    public long countByMarca(@RequestBody Marca marca){
        return productoService.countByMarca(marca);
    }

    @PatchMapping(path = "/{id}")
    public String updateProduct(@PathVariable("id") Integer id, @RequestBody Producto producto){
        if(productoService.updateProduct(id, producto)){
            return "Product updated";
        }
        return "Error: Not updated";
    }

}
