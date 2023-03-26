package com.mrojas.electronic.service.customer;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.customer.Cliente;
import com.mrojas.electronic.repository.customer.ClienteRepository;

@Service
public class ClienteService {
    @Autowired
    ClienteRepository clienteRepository;

    public List<Cliente> getClientes(){
        return clienteRepository.findAll();
    }

    public Cliente saveCliente(Cliente cliente){
        if (!clienteRepository.existsByNit(cliente.getNit())) {
            return clienteRepository.save(cliente);   
        }
        return null;
    }

    public Optional<Cliente> getClienteById(Integer id){
        return clienteRepository.findById(id);
    }

    public boolean deleteCliente(Integer id){
        if (clienteRepository.existsById(id)) {
            clienteRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public boolean updateCliente(Integer id, Cliente cliente){
        if (clienteRepository.existsById(id)) {
            cliente.setId(id);
            clienteRepository.save(cliente);
            return true;
        }
        return false;
    }
}
