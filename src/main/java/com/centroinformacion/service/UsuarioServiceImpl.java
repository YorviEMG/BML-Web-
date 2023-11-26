package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.repository.UsuarioRepository;


@Service
public class UsuarioServiceImpl implements UsuarioService{

	@Autowired
	private UsuarioRepository repository;
	
	@Override
	public Usuario login(Usuario bean) {
		return repository.login(bean);
	}

	@Override
	public List<Opcion> traerEnlacesDeUsuario(int idUsuario) {
		return repository.traerEnlacesDeUsuario(idUsuario);
	}

	@Override
	public Usuario buscaPorLogin(String login) {
		return repository.findByLogin(login);
	}

	@Override
	public Usuario registrarUsuario(Usuario bean) {
		// TODO Auto-generated method stub
		return repository.save(bean);
	}
	
	public Usuario actualizarUsuario(Usuario bean) {
		// TODO Auto-generated method stub
		return repository.save(bean);
	}

	@Override
	public List<Usuario> filtrarUsuario(String login, String dni, int rol) {
		return repository.filtrarUsuario(login, dni, rol);
	}

	@Override
	public Optional<Usuario> buscaPorId(int id) {
		return repository.findById(id);
	}

	@Override
	public List<Usuario> filtrarUsuarioSimple(String filtro) {
		// TODO Auto-generated method stub
		return repository.filtrarUsuarioSimple(filtro);
	}
	
	

}
