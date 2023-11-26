package com.centroinformacion.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.centroinformacion.entity.Prestamo;
import com.centroinformacion.entity.PrestamoHasLibro;
import com.centroinformacion.repository.LibroRepository;
import com.centroinformacion.repository.PrestamoHasLibroRepository;
import com.centroinformacion.repository.PrestamoRepository;
import com.centroinformacion.util.AppSettings;


@Service
public class PrestamoServiceImpl implements PrestamoService{

	AppSettings app;
	@Autowired
	PrestamoRepository repository;
	@Autowired
	PrestamoHasLibroRepository repositoryDetalle;
	@Autowired
	LibroRepository repositoryLibro;
	@Override
	@Transactional
	public Prestamo registraPrestamo(Prestamo obj) {
		// TODO Auto-generated method stub
		Prestamo objCabecera = repository.save(obj);
		for (PrestamoHasLibro detalle: obj.getDetallesPrestamo()) {
			detalle.getPrestamoHasLibroPK().setIdPrestamo(objCabecera.getIdPrestamo());
			repositoryDetalle.save(detalle);
			repositoryLibro.actualizaEstado(detalle.getPrestamoHasLibroPK().getIdLibro(), AppSettings.PRESTADO);
		}
		return objCabecera;
	}
	@Override
	public Optional<Prestamo> buscarPrestamoPorId(int idPrestamo) {
		// TODO Auto-generated method stub
		return repository.findById(idPrestamo);
	}

}
