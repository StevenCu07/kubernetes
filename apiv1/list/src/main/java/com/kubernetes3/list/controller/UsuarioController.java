package com.kubernetes3.list.controller;

import com.kubernetes3.list.entity.Usuario;
import com.kubernetes3.list.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuario")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;


    // Obtener todas las categorías
    @GetMapping("/list")
    public List<Usuario> getAllCategorias() {
        return usuarioService.getAllUsers();
    }
}