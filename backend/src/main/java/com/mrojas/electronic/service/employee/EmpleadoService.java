package com.mrojas.electronic.service.employee;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.employee.Empleado;
import com.mrojas.electronic.repository.employee.EmpleadoRepository;

@Service
public class EmpleadoService {
    @Autowired
    EmpleadoRepository empleadoRepository;

    public List<Empleado> getEmpleados(){
        return empleadoRepository.findAll();
    }

    public Empleado saveEmpleado(Empleado empleado){
        return empleadoRepository.save(empleado);
    }

    public Optional<Empleado> getEmpleadoById(Integer id){
        return empleadoRepository.findById(id);
    }

    public boolean deleteEmpleado(Integer id){
        if (empleadoRepository.existsById(id)) {
            empleadoRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public boolean updateEmpleado(Integer id, Empleado empleado){
        if (empleadoRepository.existsById(id)) {
            empleadoRepository.save(empleado);
            return true;
        }
        return false;
    }
}
