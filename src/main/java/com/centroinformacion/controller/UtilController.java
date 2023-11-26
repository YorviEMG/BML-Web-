package com.centroinformacion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Categoria;
import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.Prestamo;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.CategoriaService;
import com.centroinformacion.service.DevolucionService;
import com.centroinformacion.service.PrestamoService;
import com.centroinformacion.service.RolService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;
@Controller
public class UtilController {

	private final CategoriaService serviceCategoria;
	private final RolService serviceRol;
	private final DevolucionService serviceDevolucion;
	
	public UtilController(CategoriaService serviceCategoria, RolService serviceRol, DevolucionService serviceDevolucion) {
		// TODO Auto-generated constructor stub
		this.serviceCategoria = serviceCategoria;
		this.serviceRol = serviceRol;
		this.serviceDevolucion = serviceDevolucion;
	}
	
	@GetMapping("/listaCategoria")
	@ResponseBody
	public List<Categoria> listarCategoria(){
		return serviceCategoria.listarTodo();
	}
	
	@GetMapping("/listaPrestamo")
	@ResponseBody
	public List<Devolucion> listarPrestamo(HttpSession session){
		Usuario usuario = (Usuario)session.getAttribute("objUsuario");
		
		if(usuario.getRol().getIdRol()==AppSettings.ROL_CLIENTE)
		return serviceDevolucion.filtrarDevolucion(usuario.getIdUsuario());
		else {
			return serviceDevolucion.filtrarDevolucionTodo();
		}
		
	}
	
	@GetMapping("/listaRol")
	@ResponseBody
	public List<Rol> listarRol(){
		return serviceRol.listarTodo();
	}
	
}
