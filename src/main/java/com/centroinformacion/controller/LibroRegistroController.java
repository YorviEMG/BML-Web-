package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
public class LibroRegistroController {
	
	private final LibroService service;
	
	public LibroRegistroController(LibroService service) {
		this.service = service;
	}
	
	@PostMapping("/registraLibro")
	@ResponseBody
	public Map<?, ?> registraLibro(Libro obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaActualizacion(new Date());
		obj.setFechaRegistro(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioActualiza(objUsuario);
		obj.setUsuarioRegistro(objUsuario);
		
		System.out.println("<<<<<<<<<<<<<<<<<<<<"+obj.getTipoLibro());
		System.out.println("<<<<<<<<<<<<<<<<<<<<"+obj.getTipoLibro().getIdDataCatalogo());
		System.out.println("<<<<<<<<<<<<<<<<<<<<"+obj.getCategoriaLibro());
		System.out.println("<<<<<<<<<<<<<<<<<<<<"+obj.getCategoriaLibro().getIdDataCatalogo());
		
		DataCatalogo objData = new DataCatalogo();
		objData.setIdDataCatalogo(27);
		obj.setEstadoPrestamo(objData);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Libro libro = service.registraLibro(obj);
		
		if(libro == null) {
			map.put("MENSAJE", "Error en el registro");
		} else {
			map.put("MENSAJE", "Registro Exitoso");
		}
		return map;
			
	}
	@GetMapping("/buscaPorTitulo")
	@ResponseBody
	public String validaTitulo(String titulo) {
		List<Libro> listaTitulo = service.listaTitulo(titulo);
		if(CollectionUtils.isEmpty(listaTitulo)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	@GetMapping("/buscaPorSerie")
	@ResponseBody
	public String validaSerie(String serie) {
		System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<"+serie);
		List<Libro> listaSerie = service.listaSerie(serie);
		if(CollectionUtils.isEmpty(listaSerie)) {
			return "{\"valid\":true}";
		}else {
			 return "{\"valid\":false}";
		}
	}
	
}
