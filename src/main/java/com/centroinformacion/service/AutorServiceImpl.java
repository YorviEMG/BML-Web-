package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Autor;
import com.centroinformacion.repository.AutorRepository;

@Service
public class AutorServiceImpl implements AutorService{

	@Autowired
	private AutorRepository repository;
	

	@Override
	public Autor insertaActualizaAutor(Autor obj) {		
		return repository.save(obj);
	}
	
	
}
