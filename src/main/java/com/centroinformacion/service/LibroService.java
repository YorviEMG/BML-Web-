package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Libro;

public interface LibroService {
	
	public abstract Libro registraLibro(Libro obj);
	public abstract Libro actualizaLibro(Libro obj);
	public abstract List<Libro> listaTitulo(String titulo);
	public abstract List<Libro> listaSerie(String serie);
	public abstract List<Libro> listarLibro(String titulo);
	public abstract Optional<Libro> buscarLibroPorId(int id);
}
