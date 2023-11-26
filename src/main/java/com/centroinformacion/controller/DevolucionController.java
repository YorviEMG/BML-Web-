package com.centroinformacion.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Categoria;
import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.Estado;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Prestamo;
import com.centroinformacion.entity.PrestamoHasLibro;
import com.centroinformacion.entity.PrestamoHasLibroPK;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.DevolucionService;
import com.centroinformacion.service.PrestamoService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class DevolucionController {
	private final DevolucionService service;
	private final PrestamoService servicePrestamo;
	private final DevolucionService serviceDevolucion;
	
	public DevolucionController(DevolucionService service, PrestamoService servicePrestamo, DevolucionService serviceDevolucion) {
		// TODO Auto-generated constructor stub
		this.service = service;
		this.servicePrestamo = servicePrestamo;
		this.serviceDevolucion = serviceDevolucion;
	}
	
	@PostMapping("/cargarDevolucion")
	@ResponseBody
	public Map<?, ?> cargarDevolucion(int idPrestamo){
		HashMap<String, Object> map = new HashMap<>();
		if(idPrestamo == -1) {
			map.put("detalle", -1);
		}else {
			Prestamo prestamo = servicePrestamo.buscarPrestamoPorId(idPrestamo).get();
			System.out.println(prestamo.getDetallesPrestamo());
			System.out.println("<<<<<<<<<<<<<<<<"+prestamo.getDetallesPrestamo().get(0).getLibro().getTitulo());
			map.put("detalle", prestamo.getDetallesPrestamo());
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        String fecha = sdf.format(prestamo.getFechaAsignada());
			map.put("fecha", fecha);
		}		
		return map;
	}
	
	@PostMapping("/realizarDevolucion")
	@ResponseBody
	public Map<?, ?> realizarDevolucion(HttpServletRequest request, HttpSession session, int idPrestamo) throws ParseException{
		HashMap<String, Object> map = new HashMap<>();
		
		Usuario usuSesion = (Usuario)session.getAttribute("objUsuario");
		
		Devolucion devolucion = serviceDevolucion.buscarDevolucionPorPrestamo(idPrestamo).get();
		devolucion.setFechaActualiza(new Date());
		devolucion.setUsuarioAct(usuSesion);
		Estado estado = new Estado();
		estado.setIdEstado(AppSettings.DEVUELTO);
		devolucion.setEstado(estado);
		
		Devolucion objSalida = serviceDevolucion.registrarDevolucion(devolucion);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String fechaP = sdf.format(objSalida.getPrestamo().getFechaAsignada());
		String fechaD = sdf.format(objSalida.getFechaActualiza());
		String salida = "-1";
		
		if (objSalida != null) {
				salida = "Se registró la devolución N° : " + objSalida.getIdDevolucion() + "<br><br>";
				salida += "Usuario: " + objSalida.getUsuario().getNombreCompleto() + "<br><br>";
				salida += "---Libros devueltos---" + "<br><br>";
				salida += "<table class=\"table\"><tr><td>Libro</td><td>Autor</td><td>Año</td><td>Estado</td></tr>";
				for (PrestamoHasLibro x : objSalida.getPrestamo().getDetallesPrestamo()) {
					salida += "<tr><td>"  + x.getLibro().getTitulo() 
							+ "</td><td>" + x.getLibro().getAutor()
							+ "</td><td>" + x.getLibro().getAnio()
							+ "</td><td>" + "Disponible" + "</td></tr>";
				}
				salida += "</table><br>";
				salida += "Fecha asignada máxima : " + fechaP + "<br><br>";
				salida += "Fecha realizada la devolución : " + fechaD + "<br>";
				
				map.put("text", salida);
		}
		return map;
	}
}
