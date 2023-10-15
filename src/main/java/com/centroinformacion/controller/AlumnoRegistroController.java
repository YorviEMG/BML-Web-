package com.centroinformacion.controller;


import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;

import com.centroinformacion.entity.Alumno;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.AlumnoService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;



@Controller
public class AlumnoRegistroController {

	@Autowired
	private AlumnoService alumnoService;
	
	@PostMapping("/registraAlumno")
	@ResponseBody
	public Map<?, ?> registra(Alumno obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaActualizacion(new Date());
		obj.setFechaRegistro(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Alumno objSalida = alumnoService.insertaActualizaAlumno(obj);
		if (objSalida == null) {
			map.put("MENSAJE", "Error en el registro");
		}else {
			map.put("MENSAJE", "Registro exitoso");
		}
		return map;
	}
	
	//Para verificar si el DNI ya existe
	@GetMapping("/buscaPorDni")
	@ResponseBody
	public String validaDni(String dni) {
		List<Alumno> listaPorDni = alumnoService.listaPorDni(dni);
		if(CollectionUtils.isEmpty(listaPorDni)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	
	//Para verificar si el correo ya existe
	@GetMapping("/buscaPorCorreo")
	@ResponseBody
	public String validaCorreo(String correo) {
		List<Alumno> listaPorCorreo = alumnoService.listaPorCorreo(correo);
		if(CollectionUtils.isEmpty(listaPorCorreo)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}	

	
}
