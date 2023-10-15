package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Proveedor;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.ProveedorService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProveedorRegistroController {
	@Autowired
	private ProveedorService proveedorService;
	
	@PostMapping("/registraProveedor")
	@ResponseBody
	public Map<?, ?> registra(Proveedor obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaActualizacion(new Date());
		obj.setFechaRegistro(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Proveedor objSalida = proveedorService.insertaActualizaProveedor(obj);
		if (objSalida == null) {
			map.put("MENSAJE", "Error en el registro");
		}else {
			map.put("MENSAJE", "Registro exitoso");
		}
		return map;
	}
	//invalidando duplicidad de RUC
	@GetMapping("/buscaPorRuc")
	@ResponseBody
	public String validaRuc(String ruc) {
		List<Proveedor> listaPorRuc = proveedorService.listaPorRuc(ruc);
		if(CollectionUtils.isEmpty(listaPorRuc)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
}
