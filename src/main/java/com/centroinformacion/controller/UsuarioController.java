package com.centroinformacion.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.UsuarioService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsuarioController {
	private final UsuarioService service;
	
	public UsuarioController(UsuarioService service) {
		// TODO Auto-generated constructor stub
		this.service = service;
	}
	
	@PostMapping("/registrarUsuario")
	public String registrarUsuario(Usuario usuario, HttpServletRequest request) {
		usuario.setEstado(AppSettings.ACTIVO);
		usuario.setFechaRegistro(new Date());
		usuario.setFechaActualiza(new Date());
		Rol rol = new Rol();
		rol.setIdRol(AppSettings.ROL_CLIENTE);
		usuario.setRol(rol);
		Usuario objSalida = service.registrarUsuario(usuario);
		if(objSalida == null) request.setAttribute("test", "Error");
		else {
		
			request.setAttribute("test", "Registro exitoso");
		}
		
		return "intranetLogin";
	}
	@PostMapping("/registrarUsuario2")
	public void registrarUsuario2(Usuario usuario, HttpServletRequest request, HttpServletResponse response) throws IOException {
	    usuario.setEstado(AppSettings.ACTIVO);
	    usuario.setFechaRegistro(new Date());
	    usuario.setFechaActualiza(new Date());
	    Rol rol = new Rol();
	    rol.setIdRol(AppSettings.ROL_CLIENTE);
	    usuario.setRol(rol);
	    Usuario objSalida = service.registrarUsuario(usuario);

	    if (objSalida == null) {
	        request.setAttribute("test", "Error");
	    } else {
	        request.setAttribute("test", "Registro exitoso");
	    }

	    response.sendRedirect("/intranetLogin");
	}
	@PostMapping("/registrarUsuario3")
	@ResponseBody
	public Map<?, ?> registrarUsuario3(Usuario usuario, HttpServletRequest request) {
		Map<String, Object> response = new HashMap<>();
		usuario.setEstado(AppSettings.ACTIVO);
		usuario.setFechaRegistro(new Date());
		usuario.setFechaActualiza(new Date());
		Rol rol = new Rol();
		rol.setIdRol(AppSettings.ROL_CLIENTE);
		usuario.setRol(rol);
		Usuario objSalida = service.registrarUsuario(usuario);
		if(objSalida == null) response.put("msg", "ERROR");
		else {
			response.put("msg", "Registro del usuario "+ usuario.getLogin() + " exitoso!");
		}
		
		return response;
	}
	
	@GetMapping("/filtrarUsuario")
	@ResponseBody
	public List<Usuario> filtrarUsuario(String login, String dni, int rol){
		if(dni.trim()=="") dni = "-1";
		return service.filtrarUsuario(login, dni, rol);
	}
	
	@GetMapping("/filtrarUsuarioSimple")
	@ResponseBody
	public List<Usuario> filtrarUsuarioSimple(String filtro){
		return service.filtrarUsuarioSimple(filtro);
	}
	
	@PostMapping("/actualizarUsuario")
	@ResponseBody
	public Map<?, ?> actualizarUsuario(Usuario usuario){
		HashMap<String, Object> map = new HashMap<>();
		Usuario obj = service.buscaPorId(usuario.getIdUsuario()).get();
		usuario.setEstado(obj.getEstado());
		usuario.setFechaRegistro(obj.getFechaRegistro());
		usuario.setFechaActualiza(new Date());
		Usuario objSalida = service.actualizarUsuario(usuario);
		if(objSalida == null) map.put("ERROR", "Error en la actualización");
		else {
			map.put("mensaje", "Actualización exitosa");
			map.put("lista", service.filtrarUsuario("", "-1", -1));
		}
		return map;
	}
	
	@PostMapping("/estadoUsuario")
	@ResponseBody
	public List<Usuario> estadoUsuario(int id){
		Usuario obj = service.buscaPorId(id).get();
		obj.setEstado(obj.getEstado()==1?0:1);
		obj.setFechaRegistro(obj.getFechaRegistro());
		obj.setFechaActualiza(new Date());
		service.actualizarUsuario(obj);
		return service.filtrarUsuario("", "-1", -1);
	}
}
