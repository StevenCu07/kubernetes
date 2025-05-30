package com.kubernetes3.delete.repository;


import com.kubernetes3.delete.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    Optional<com.kubernetes3.delete.entity.Usuario> findById(Integer id);
}
