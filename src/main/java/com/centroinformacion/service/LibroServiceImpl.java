package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Libro;
import com.centroinformacion.repository.LibroRepository;

@Service
public class LibroServiceImpl implements LibroService {

	@Autowired
	private LibroRepository repository;
	
	@Override
	public Libro registraLibro(Libro obj) {
		// TODO Auto-generated method stub
		return repository.save(obj);
	}
	
	public Libro actualizaLibro(Libro obj) {
		// TODO Auto-generated method stub
		return repository.save(obj);
	}
	public List<Libro> listaTitulo(String titulo) {
		return repository.findByTituloIgnoreCase(titulo);
	}

	public List<Libro> listaSerie(String serie) {
		return repository.findBySerieIgnoreCase(serie);
	}
	
	public List<Libro> listarLibro(String titulo){
		return repository.buscarLibro(titulo);
	}
	
	public Optional<Libro> buscarLibroPorId(int id){
		return repository.findById(id);
	}

}
