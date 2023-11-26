package com.centroinformacion.service;

import java.util.Optional;

import com.centroinformacion.entity.Prestamo;

public interface PrestamoService {
	public abstract Prestamo registraPrestamo(Prestamo prestamo);
	public abstract Optional<Prestamo> buscarPrestamoPorId(int idPrestamo);
}
