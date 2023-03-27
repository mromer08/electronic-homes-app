package com.mrojas.electronic.model.employee;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.mrojas.electronic.model.branch.Sucursal;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Empleado", schema = "controlpersonal")
public class Empleado {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String nombre;
    private String apellido;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private Date fecha_contratacion;

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-mm-dd")
    private Date fecha_nacimiento;

    private Double salario;

    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "id_rol", referencedColumnName = "id")
    private Rol rol;

    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "id_sucursal", referencedColumnName = "id")
    private Sucursal sucursal;
}
