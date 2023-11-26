package com.centroinformacion.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer>{

	@Query("Select x from Usuario x where x.login = :#{#usu.login} and x.password = :#{#usu.password}")
	public abstract Usuario login(@Param(value = "usu") Usuario bean);
	
	@Query("SELECT o FROM Usuario u " +
		       "JOIN u.rol r " +
		       "JOIN RolHasOpcion ro ON r.idRol = ro.rol.idRol " +
		       "JOIN ro.opcion o " +
		       "WHERE u.idUsuario = :var_idUsuario")
	public abstract List<Opcion> traerEnlacesDeUsuario(@Param("var_idUsuario") int idUsuario);
	
	public abstract Usuario findByLogin(String login);
	
	@Query("select u from Usuario u where u.login like ?1% and (u.dni =?2 or -1=?2) and (u.rol.idRol =?3 or -1=?3)")
	public abstract List<Usuario> filtrarUsuario(String login, String dni, int rol);
	
	@Query("select u from Usuario u where u.login like ?1% or u.nombres like ?1% or u.nombres like ?1%")
	public abstract List<Usuario> filtrarUsuarioSimple(String filtro);
	
}
