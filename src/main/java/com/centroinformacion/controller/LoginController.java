package com.centroinformacion.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.antlr.v4.runtime.dfa.DFA;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.UsuarioService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

	@Autowired
	private UsuarioService servicio;

	@PostMapping("/login")
	public String login(Usuario user, HttpSession session, HttpServletRequest request) {
		System.out.println(user.getPassword());
		System.out.println(user.getLogin());
		Usuario usuario = servicio.login(user);
		usuario = servicio.buscaPorLogin(user.getLogin());
		if (usuario == null) {
			request.setAttribute("mensaje", "El usuario no existe");
			return "intranetLogin";
		} else {
			List<Opcion> menus = servicio.traerEnlacesDeUsuario(usuario.getIdUsuario());
			List<Opcion> menusTipo1 = menus.stream().filter(p -> p.getTipo() == 1).toList();
			List<Opcion> menusTipo2 = menus.stream().filter(p -> p.getTipo() == 2).toList();
			List<Opcion> menusTipo3 = menus.stream().filter(p -> p.getTipo() == 3).toList();
			List<Opcion> menusTipo4 = menus.stream().filter(p -> p.getTipo() == 4).toList();
			Date fecha = new Date();
			
			session.setAttribute("objUsuario", usuario);
			session.setAttribute("registroUsu", fecha);
			session.setAttribute("objMenusTipo1", menusTipo1);
			session.setAttribute("objMenusTipo2", menusTipo2);
			session.setAttribute("objMenusTipo3", menusTipo3);
			session.setAttribute("objMenusTipo4", menusTipo4);

			return "intranetHome";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		session.invalidate();

		response.setHeader("Cache-control", "no-cache");
		response.setHeader("Expires", "0");
		response.setHeader("Pragma", "no-cache");

		request.setAttribute("mensaje", "El usuario salió de sesión");
		return "intranetLogin";

	}

}
