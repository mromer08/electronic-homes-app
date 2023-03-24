package com.mrojas.electronic.controller.customer;

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

import com.mrojas.electronic.model.customer.Cliente;
import com.mrojas.electronic.service.customer.ClienteService;

@RestController
@RequestMapping("/api/cliente")
public class ClienteController {
    @Autowired
    ClienteService clienteService;

    @GetMapping()
    public List<Cliente> getClientes(){
        return clienteService.getClientes();
    }

    @PostMapping()
    public Optional<Cliente> saveCliente(@RequestBody Cliente cliente){
        return Optional.ofNullable(clienteService.saveCliente(cliente));
    }

    @GetMapping(path = "/{id}")
    public Optional<Cliente> getClienteById(@PathVariable("id") Integer id){
        return clienteService.getClienteById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteCliente(@PathVariable("id") Integer id){
        if (clienteService.deleteCliente(id)) {
            return "Delete succes of cliente with id " + id;
        }
        return "Error: Delete failed of cliente with id " + id;
    }

    @PatchMapping(path = "/{id}")
    public String updateCliente(@PathVariable("id") Integer id, @RequestBody Cliente cliente){
        if (clienteService.updateCliente(id, cliente)) {
            return "Cliente updated";
        }
        return "Error: Not updated";
    }
}
