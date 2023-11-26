package com.centroinformacion.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Libro;

public interface LibroRepository extends JpaRepository<Libro, Integer>{
	public List<Libro> findByTituloIgnoreCase(String titulo);
	public List<Libro> findBySerieIgnoreCase(String serie);
	
	@Query("select l from Libro l where l.titulo like ?1% and l.estadoV.idEstado = 1")
	public List<Libro> buscarLibro(String titulo);
	
	@Query("select l from Libro l where (l.titulo like ?1% or l.serie = ?1) and (l.categoria.idCategoria = ?2 or ?2 = -1) and (l.tipo = ?3 or ?3 = -1) and (l.anio = ?4 or ?4 = -1)")
	public List<Libro> filtrarLibro(String filtro, int categoria, int tipo, int anio);
	
	@Modifying
	@Query("update Libro x set x.estadoV.idEstado = ?2 where x.idLibro = ?1 ")
	public abstract void actualizaEstado(int idLibro, int estadoV);
}
