package com.mrojas.electronic.model.sale;

import com.mrojas.electronic.model.inventory.Producto;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Detalleventa", schema = "controlventas")
public class DetalleVenta {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "id_venta", referencedColumnName = "id")
    private Venta venta;
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "id_producto", referencedColumnName = "id")
    private Producto producto;
    private Integer cantidad;
}
