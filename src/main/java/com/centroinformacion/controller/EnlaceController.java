package com.centroinformacion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class EnlaceController {

	//Login
	@GetMapping("/")
	public String verLogin() {	return "intranetLogin";  }
	
	@GetMapping("/registrarse")
	public String verRegistrarse() {	return "intranetRegistrarse";  }
	
	@GetMapping("/verIntranetHome")
	public String verIntranetHome() {	return "intranetHome";  }
	
	@GetMapping("/verLibro")
	public String verLibro() { return "intranetLibro"; }
	
	@GetMapping("/verPrestamo")
	public String verPrestamo() { return "intranetPrestamo"; }
	
	@GetMapping("/verDevolucion")
	public String verDevolucion() { return "intranetDevolucion"; }
	
	@GetMapping("/verUsuario")
	public String verUsuario() { return "intranetUsuario"; }

}
