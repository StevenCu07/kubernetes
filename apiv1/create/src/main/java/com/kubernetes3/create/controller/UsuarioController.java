package com.kubernetes3.create.controller;

import com.kubernetes3.create.entity.Usuario;
import com.kubernetes3.create.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/usuario")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    // Crear una nueva categoría
    @PostMapping("/create")
    public Usuario createCategoria(@RequestBody Usuario categoriaDTO) {
        return usuarioService.createUser(categoriaDTO);
    }
}
