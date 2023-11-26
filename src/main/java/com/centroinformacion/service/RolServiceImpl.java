package com.centroinformacion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Rol;
import com.centroinformacion.repository.RolRepository;

@Service
public class RolServiceImpl implements RolService{

	@Autowired
	RolRepository repository;
	
	@Override
	public List<Rol> listarTodo() {
		// TODO Auto-generated method stub
		return repository.findAll();
	}

}
