package com.kubernetes3.delete.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/usuario")
public class UsuarioController {

    @Autowired
    private com.kubernetes3.delete.service.UsuarioService usuarioService;

    // Borrar una categoría por su ID
    @DeleteMapping("/delete/{id}")
    public void deleteCategoria(@PathVariable Integer id) {
        usuarioService.deleteUser(id);
    }
}