package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.centroinformacion.entity.Tesis;
import com.centroinformacion.entity.Usuario;

import com.centroinformacion.service.TesisService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class TesisRegistroController {

	
	@Autowired
	private TesisService tesisService;
	
	@PostMapping("/registraTesis")
	@ResponseBody
	public Map<?, ?> registra(Tesis obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaRegistro(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Tesis objSalida = tesisService.insertaActualizaTesis(obj);
		if (objSalida == null) {
			map.put("MENSAJE", "Error al registrar");
		}else {
			map.put("MENSAJE", "Registro exitoso");
		}
		return map;
	}
	
}
