package com.mrojas.electronic.controller.inventory;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.mrojas.electronic.model.inventory.Marca;
import com.mrojas.electronic.service.inventory.MarcaService;

@RestController
@RequestMapping("/api/marca")
public class MarcaController {
    
    @Autowired
    MarcaService marcaService;

    @GetMapping()
    public List<Marca> getBrands(){
        return marcaService.getBrands();
    }
}
