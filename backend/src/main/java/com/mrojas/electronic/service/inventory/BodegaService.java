package com.mrojas.electronic.service.inventory;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.inventory.Bodega;
import com.mrojas.electronic.repository.inventory.BodegaRepository;

@Service
public class BodegaService {
    @Autowired
    BodegaRepository bodegaRepository;

    public List<Bodega> getBodegas(){
        return bodegaRepository.findAll();
    }

    public Optional<Bodega> getBodegaById(Integer id){
        return bodegaRepository.findById(id);
    }
}
