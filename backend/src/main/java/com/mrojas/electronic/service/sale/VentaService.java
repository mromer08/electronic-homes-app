package com.mrojas.electronic.service.sale;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.sale.Venta;
import com.mrojas.electronic.repository.sale.VentaRepository;

@Service
public class VentaService {
    @Autowired
    VentaRepository ventaRepository;

    public List<Venta> getVentas(){
        return ventaRepository.findAll();
    }

    public Venta saveVenta(Venta venta){
        // Pageable lastVentOrderByDate = PageRequest.of(0,1, Sort.by(Sort.Direction.DESC, "fecha"));
        // Optional<Venta> ventaPrev = Optional.ofNullable(ventaRepository
        //         .findByCliente(
        //             venta.getCliente().getId(),
        //             lastVentOrderByDate).get(0));

        // venta.setDescuento(calcDescuento(
        //     ventaPrev.isPresent() ? ventaPrev.get().getTotal() : 0.0 
        // ));
        return ventaRepository.save(venta);
    }

    public Optional<Venta> getVentaById(Integer id){
        return ventaRepository.findById(id);
    }

    public boolean deleteVenta(Integer id){
        if (ventaRepository.existsById(id)) {
            ventaRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private Double calcDescuento(Double prevTotal){
        if (prevTotal >= 10000) return 0.1;
        if (prevTotal >= 5000) return 0.05;
        if (prevTotal >= 1000) return 0.02;
        return 0.0;
    }


}
