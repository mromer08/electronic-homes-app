package com.mrojas.electronic.service.user;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mrojas.electronic.model.user.Usuario;
import com.mrojas.electronic.repository.user.UsuarioRepository;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

@Service
public class UsuarioService {
    @Autowired
    UsuarioRepository usuarioRepository;

    public List<Usuario> getUsuarios(){
        return usuarioRepository.findAll();
    }

    public Usuario saveUsuario(Usuario usuario){
        Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id);
        String hash = argon2.hash(1, 1024, 1, usuario.getPassword());
        System.out.println("contra simple: " + usuario.getPassword());
        System.out.println("contra encript: " + hash);
        usuario.setPassword(hash);
        return usuarioRepository.save(usuario);
    }

    public Optional<Usuario> getUsuarioById(Integer id){
        return usuarioRepository.findById(id);
    }

    public boolean deleteUsuario(Integer id) {
        if (usuarioRepository.existsById(id)) {
            usuarioRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Optional<Usuario> getUsuarioByCredentials(Map<String, String> usuario){
        Optional<Usuario> usuarioExistente = usuarioRepository.findByNombre(usuario.get("nombre"));
        if (usuarioExistente.isPresent()) {
            String passwordHashed = usuarioExistente.get().getPassword();

            Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id);
            if (argon2.verify(passwordHashed, usuario.get("password"))) {
                return usuarioExistente;
            }
            return Optional.empty();
        }
        return Optional.empty();
    }
}
