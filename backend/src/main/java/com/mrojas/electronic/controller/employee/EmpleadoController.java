package com.mrojas.electronic.controller.employee;

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

import com.mrojas.electronic.model.employee.Empleado;
import com.mrojas.electronic.service.employee.EmpleadoService;

@RestController
@RequestMapping("/api/empleado")
public class EmpleadoController {
    @Autowired
    EmpleadoService empleadoService;

    @GetMapping()
    public List<Empleado> getEmpleados(){
        return empleadoService.getEmpleados();
    }

    @PostMapping()
    public Optional<Empleado> saveEmpleado(@RequestBody Empleado empleado){
        return Optional.ofNullable(empleadoService.saveEmpleado(empleado));
    }

    @GetMapping(path = "/{id}")
    public Optional<Empleado> getEmpleadoById(@PathVariable("id") Integer id){
        return empleadoService.getEmpleadoById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteCliente(@PathVariable("id") Integer id){
        if (empleadoService.deleteEmpleado(id)) {
            return "Delete succes of empleado with id " + id;
        }
        return "Error: Delete failed of empleado with id " + id;
    }

    @PatchMapping(path = "/{id}")
    public String updateCliente(@PathVariable("id") Integer id, @RequestBody Empleado empleado){
        if (empleadoService.updateEmpleado(id, empleado)) {
            return "Cliente updated";
        }
        return "Error: Not updated";
    }
}
