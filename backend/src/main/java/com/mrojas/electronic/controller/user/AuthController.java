package com.mrojas.electronic.controller.user;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mrojas.electronic.model.user.Usuario;
import com.mrojas.electronic.service.user.UsuarioService;
import com.mrojas.electronic.util.JWTUtil;

@RestController
@RequestMapping("/api")
public class AuthController {
    @Autowired
    UsuarioService usuarioService;

    @Autowired
    JWTUtil jwtUtil;

    @PostMapping("/login")
    public String login(@RequestBody Map<String, String> usuario){
        Optional<Usuario> usuarioLogueado = usuarioService.getUsuarioByCredentials(usuario);

        if (usuarioLogueado.isPresent()) {
            Map<String, Object> extraClaims = new HashMap<>();
            extraClaims.put("empleado", usuarioLogueado.get().getEmpleado());
            String tokenJwt = jwtUtil.create(String.valueOf(usuarioLogueado.get().getId()), usuarioLogueado.get().getNombre(), extraClaims);
            
            return tokenJwt;
        }
        return "FAIL";
    }
}
