package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Devolucion;

public interface DevolucionService {
	public abstract Devolucion registrarDevolucion(Devolucion devolucion);
	public abstract List<Devolucion> filtrarDevolucion(int idUsuario);
	public abstract List<Devolucion> filtrarDevolucionTodo();
	public abstract Optional<Devolucion> buscarDevolucionPorId(int idDevolucion);
	public abstract Optional<Devolucion> buscarDevolucionPorPrestamo(int idPrestamo);
}
