package com.mrojas.electronic.repository.user;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mrojas.electronic.model.user.Usuario;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer>{
    public Optional<Usuario> findByNombre(String nombre);
}
