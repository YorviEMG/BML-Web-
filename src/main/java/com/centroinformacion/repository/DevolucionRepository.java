package com.centroinformacion.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.Prestamo;

public interface DevolucionRepository extends JpaRepository<Devolucion, Integer>{
	
	@Query("select d from Devolucion d where d.usuario.idUsuario =?1 and d.estado.idEstado = 3")
	public abstract List<Devolucion> filtrarPrestamosUsuario(int idUsuario);
	
	
	@Query("select d from Devolucion d where d.estado.idEstado = 3")
	public abstract List<Devolucion> filtrarPrestamos();
	
	@Query("select d from Devolucion d where d.prestamo.idPrestamo = ?1")
	public abstract Optional<Devolucion> filtrarDevolucionPorPrestamo(int idPrestamo);
	
}
