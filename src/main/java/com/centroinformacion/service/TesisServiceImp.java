package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Tesis;
import com.centroinformacion.repository.TesisRepository;

@Service
public class TesisServiceImp implements TesisService{

	@Autowired
	private TesisRepository tesisRepository;
	
	@Override
	public Tesis insertaActualizaTesis(Tesis obj) {
		return tesisRepository.save(obj);
	}

}
