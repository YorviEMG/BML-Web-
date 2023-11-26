package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;

public interface UsuarioService {
	public abstract Usuario login(Usuario bean);

	public abstract List<Opcion> traerEnlacesDeUsuario(int idUsuario);

	public abstract Usuario registrarUsuario(Usuario bean);
	
	public abstract Usuario actualizarUsuario(Usuario bean);
	
	public abstract Usuario buscaPorLogin(String login);

	public abstract Optional<Usuario> buscaPorId(int id);
	
	public abstract List<Usuario> filtrarUsuario(String login, String dni, int rol);
	
	public abstract List<Usuario> filtrarUsuarioSimple(String filtro);
}
