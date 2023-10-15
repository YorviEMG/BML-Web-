package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.DataCatalogo;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.LibroService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class LibroCrudController {

	private final LibroService service;
	
	public LibroCrudController(LibroService service) {
		this.service = service;
	}
	
	@GetMapping("/listarLibro")
	@ResponseBody
	public List<Libro> listarLibro(String titulo){
		return service.listarLibro(titulo + "%");
	}
	
	@PostMapping("/registrarLibro")
	@ResponseBody
	public Map<?, ?> registrarLibro(Libro libro, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		libro.setEstado(AppSettings.ACTIVO);
		libro.setFechaRegistro(new Date());
		libro.setFechaActualizacion(new Date());
		libro.setUsuarioRegistro(objUsuario);
		libro.setUsuarioActualiza(objUsuario);
		
		DataCatalogo objData = new DataCatalogo();
		objData.setIdDataCatalogo(27);
		libro.setEstadoPrestamo(objData);
		
		Libro objSalida = service.registraLibro(libro);
		if(objSalida == null) {
			map.put("ERROR", "Error en el registro");
		}else {
			List<Libro> lista = service.listarLibro("%");
			map.put("lista", lista);
			map.put("mensaje", "Registro Exitoso");
		}
		return map;
	}
	@PostMapping("/actualizarLibro")
	@ResponseBody
	public Map<?, ?> actualizarLibro(Libro libro, HttpSession session){
		HashMap<String, Object> map = new HashMap<>();
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		Optional<Libro> obj = service.buscarLibroPorId(libro.getIdLibro());
		libro.setEstado(obj.get().getEstado());
		libro.setFechaRegistro(obj.get().getFechaRegistro());
		libro.setFechaActualizacion(new Date());
		libro.setUsuarioRegistro(obj.get().getUsuarioRegistro());
		libro.setUsuarioActualiza(objUsuario);
		libro.setEstadoPrestamo(obj.get().getEstadoPrestamo());
		Libro objSalida = service.actualizaLibro(libro);
		if(objSalida == null) {
			map.put("Error", "Error en la actualización");
		}else {
			List<Libro> lista = service.listarLibro("%");
			map.put("lista", lista);
			map.put("mensaje", "Actualización exitosa");
		}
		return map;
	}
	
	@PostMapping("/estadoLibro")
	@ResponseBody
	public Map<?, ?> estadoLibro(int id, HttpSession session){
		HashMap<String, Object> map = new HashMap<>();
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		Libro libro = service.buscarLibroPorId(id).get();
		libro.setEstado(libro.getEstado() == 1 ? 0 : 1);
		libro.setFechaActualizacion(new Date());
		libro.setUsuarioActualiza(objUsuario);
		Libro objSalida = service.actualizaLibro(libro);
		if(objSalida == null) {
			map.put("Error", "Error en la actualización");
		}else {
			List<Libro> lista = service.listarLibro("%");
			map.put("lista", lista);
		}
		return map;
	}
	
	@GetMapping("/buscaPorTituloAct")
	@ResponseBody
	public String validaTituloAct(String titulo, String id) {
		List<Libro> listaTitulo = service.listaTitulo(titulo);
		System.out.println(titulo);
		System.out.println(id);
		if(CollectionUtils.isEmpty(listaTitulo)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	@GetMapping("/buscaPorSerieAct")
	@ResponseBody
	public String validaSerieAct(String serie) {
		List<Libro> listaSerie = service.listaSerie(serie);
		if(CollectionUtils.isEmpty(listaSerie)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
}
