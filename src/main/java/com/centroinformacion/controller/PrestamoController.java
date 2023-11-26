package com.centroinformacion.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.Estado;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Prestamo;
import com.centroinformacion.entity.PrestamoHasLibro;
import com.centroinformacion.entity.PrestamoHasLibroPK;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.DevolucionService;
import com.centroinformacion.service.LibroService;
import com.centroinformacion.service.PrestamoService;
import com.centroinformacion.service.UsuarioService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PrestamoController {

	private final PrestamoService service;
	private final LibroService serviceLibro;
	private final UsuarioService serviceUsuario;
	private final DevolucionService serviceDevolucion;
	public PrestamoController(PrestamoService service, LibroService serviceLibro, UsuarioService serviceUsuario, DevolucionService serviceDevolucion) {
		// TODO Auto-generated constructor stub
		this.service = service;
		this.serviceLibro = serviceLibro;
		this.serviceUsuario = serviceUsuario;
		this.serviceDevolucion = serviceDevolucion;
	}
	
	@PostMapping("/ingresarLibro2")
	@ResponseBody
	public Map<?, ?> detallePrestamo2(HttpServletRequest request, HttpSession session, int idLibro, int idUsuario){
		HashMap<String, Object> map = new HashMap<>();
		
		PrestamoHasLibro detalle = new PrestamoHasLibro();
		Usuario usuario = serviceUsuario.buscaPorId(idUsuario).get();
		
		Prestamo prestamo = new Prestamo();
		prestamo.setUsuario(usuario);
		Usuario usuSesion = (Usuario)session.getAttribute("objUsuario");
		prestamo.setUsuarioReg(usuSesion);
		prestamo.setUsuarioAct(usuSesion);
		prestamo.setFechaRegistro(new Date());
		prestamo.setFechaActualiza(new Date());

		detalle.setPrestamo(prestamo);
		
		Libro libro = serviceLibro.buscarLibroPorId(idLibro).get();
		if(libro == null) map.put("mensaje", "Error");
		else { 
			map.put("mensaje", "Libro agregado");
			detalle.setLibro(libro);
		}
		
		return map;
	}
	@PostMapping("/ingresarLibro")
	@ResponseBody
	public Map<?, ?> detallePrestamo(HttpServletRequest request, HttpSession session, int idLibro, int idUsuario){
		HashMap<String, Object> map = new HashMap<>();
		List<Libro> libros;
		Libro libro = serviceLibro.buscarLibroPorId(idLibro).get();
		if(session.getAttribute("datos") == null) {
			if(libro == null) map.put("mensaje", "Error");
			else { 
				map.put("mensaje", "Libro agregado");
				libros = new ArrayList<>();
				libros.add(libro);
				map.put("datos", libros);
				session.setAttribute("datos", libros);
			}
		}else {
			libros = (List<Libro>) session.getAttribute("datos");
			if(libro == null) map.put("mensaje", "Error");
			else { 
				map.put("mensaje", "Libro agregado");
				libros.add(libro);
				map.put("datos", libros);
				session.setAttribute("datos", libros);
			}
		}
		LocalDate hoy = LocalDate.now();
		LocalDate otro = hoy.plusDays(30);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String fecha = otro.format(formatter);
		
		map.put("fecDev", fecha);
		return map;
	}
	@PostMapping("/quitarLibro")
	@ResponseBody
	public Map<?, ?> detallePrestamoQuitar(HttpServletRequest request, HttpSession session, int idLibro){
		HashMap<String, Object> map = new HashMap<>();
		List<Libro> libros = (List<Libro>) session.getAttribute("datos");
		int index = -1;
		for (int i = 0; i < libros.size(); i++) {
			if (libros.get(i).getIdLibro() == idLibro) {
				index = i;
				break;
			}
		}
		libros.remove(index);
		map.put("datos", libros);
		session.setAttribute("datos", libros);
		return map;
	}
	@PostMapping("/registrarPrestamo")
	@ResponseBody
	public Map<?, ?> registrarPrestamo(HttpServletRequest request, HttpSession session, int idLibro, int idUsuario, String fec) throws ParseException{
		HashMap<String, Object> map = new HashMap<>();
		
		Usuario usuario = serviceUsuario.buscaPorId(idUsuario).get();
		
		Prestamo prestamo = new Prestamo();
		prestamo.setUsuario(usuario);
		Usuario usuSesion = (Usuario)session.getAttribute("objUsuario");
		prestamo.setUsuarioReg(usuSesion);
		prestamo.setUsuarioAct(usuSesion);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date fecha = sdf.parse(fec);
		prestamo.setFechaAsignada(fecha);
		prestamo.setFechaRegistro(new Date());
		prestamo.setFechaActualiza(new Date());

		List<PrestamoHasLibro> detalle = new ArrayList<>();
		List<Libro> libros = (List<Libro>) session.getAttribute("datos");
		for (Libro libro : libros) {	
				PrestamoHasLibroPK pk = new PrestamoHasLibroPK();
				pk.setIdLibro(libro.getIdLibro());
					
				PrestamoHasLibro phl = new PrestamoHasLibro();
				phl.setPrestamoHasLibroPK(pk);
				detalle.add(phl);
		}
		prestamo.setDetallesPrestamo(detalle);
		
		Prestamo objSalida = service.registraPrestamo(prestamo);
		
		String salida = "-1";
		
		if (objSalida != null) {
				salida = "Se generó el préstamo con código N° : " + objSalida.getIdPrestamo() + "<br><br>";
				salida += "Usuario: " + objSalida.getUsuario().getNombreCompleto() + "<br><br>";
				salida += "<table class=\"table\"><tr><td>Libro</td><td>Autor</td><td>Año</td><td>Estado</td></tr>";
				for (Libro x : libros) {
					salida += "<tr><td>"  + x.getTitulo() 
							+ "</td><td>" + x.getAutor() 
							+ "</td><td>" + x.getAnio()
							+ "</td><td>" + "Prestado" + "</td></tr>";
				}
				salida += "</table><br>";
				salida += "Fecha a devolver máxima : " + fec;

				libros.clear();
				map.put("text", salida);
		}
		
		Devolucion devolucion = new Devolucion();
		devolucion.setPrestamo(prestamo);
		devolucion.setFechaRegistro(new Date());
		devolucion.setFechaActualiza(new Date());
		devolucion.setUsuario(usuario);
		devolucion.setUsuarioAct(usuSesion);
		devolucion.setUsuarioReg(usuSesion);
		Estado estado = new Estado();
		estado.setIdEstado(AppSettings.PENDIENTE);
		devolucion.setEstado(estado);
		serviceDevolucion.registrarDevolucion(devolucion);
		return map;
	}
	
}
