package com.mrojas.electronic.controller.user;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.user.Usuario;
import com.mrojas.electronic.service.user.UsuarioService;

@RestController
@RequestMapping("/api/usuario")
public class UsuarioController {
    @Autowired
    UsuarioService usuarioService;

    @GetMapping()
    public List<Usuario> getUsuarios() {
        return usuarioService.getUsuarios();
    }

    @PostMapping()
    public Usuario saveUsuario(@RequestBody Usuario usuario) {
        return usuarioService.saveUsuario(usuario);
    }

    @GetMapping(path = "/{id}")
    public Optional<Usuario> getUsuarioById(@PathVariable("id") Integer id) {
        return usuarioService.getUsuarioById(id);
    }

    @DeleteMapping(path = "/{id}")
    public String deleteUsuario(@PathVariable("id") Integer id) {
        if (usuarioService.deleteUsuario(id)) {
            return "Delete succes of usuario with id " + id;
        }
        return "Error: Delete failed of usuario with id " + id;
    }

}
