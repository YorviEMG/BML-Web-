package com.centroinformacion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Categoria;
import com.centroinformacion.repository.CategoriaRepository;

@Service
public class CategoriaServiceImpl implements CategoriaService{
	
	@Autowired
	private CategoriaRepository repository;
	
	@Override
	public List<Categoria> listarTodo() {
		// TODO Auto-generated method stub
		return repository.findAll();
	}

}
