package com.mrojas.electronic.service.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.inventory.Marca;
import com.mrojas.electronic.repository.inventory.MarcaRepository;

@Service
public class MarcaService {
    @Autowired
    MarcaRepository marcaRepository;

    public List<Marca> getBrands(){
        return (List<Marca>) marcaRepository.findAll();
    }

    public Optional<Marca> getMarcaById(Integer id){
        return marcaRepository.findById(id);
    }
}
