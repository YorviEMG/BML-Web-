package com.centroinformacion.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Libro;

public interface LibroRepository extends JpaRepository<Libro, Integer>{
	public List<Libro> findByTituloIgnoreCase(String titulo);
	public List<Libro> findBySerieIgnoreCase(String serie);
	
	@Query("select l from Libro l where l.titulo like ?1")
	public List<Libro> buscarLibro(String titulo);
	
	
}
