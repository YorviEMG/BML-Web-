package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.PrestamoHasLibro;
import com.centroinformacion.repository.DevolucionRepository;
import com.centroinformacion.repository.LibroRepository;
import com.centroinformacion.util.AppSettings;

@Service
public class DevolucionServiceImpl implements DevolucionService{
	@Autowired
	DevolucionRepository repository;
	@Autowired
	LibroRepository repositoryLibro;
	@Override
	@Transactional
	public Devolucion registrarDevolucion(Devolucion devolucion) {
		// TODO Auto-generated method stub
		Devolucion objDevolucion = repository.save(devolucion);
		for (PrestamoHasLibro detalle: devolucion.getPrestamo().getDetallesPrestamo()) {
			repositoryLibro.actualizaEstado(detalle.getPrestamoHasLibroPK().getIdLibro(), AppSettings.ESTADO_LIBRO_DISPONIBLE);
		}
		return objDevolucion;
	}
	@Override
	public List<Devolucion> filtrarDevolucion(int idUsuario) {
		// TODO Auto-generated method stub
		return repository.filtrarPrestamosUsuario(idUsuario);
	}
	
	public List<Devolucion> filtrarDevolucionTodo() {
		// TODO Auto-generated method stub
		return repository.filtrarPrestamos();
	}
	@Override
	public Optional<Devolucion> buscarDevolucionPorId(int idDevolucion) {
		// TODO Auto-generated method stub
		return repository.findById(idDevolucion);
	}
	@Override
	public Optional<Devolucion> buscarDevolucionPorPrestamo(int idPrestamo) {
		// TODO Auto-generated method stub
		return repository.filtrarDevolucionPorPrestamo(idPrestamo);
	}

}
