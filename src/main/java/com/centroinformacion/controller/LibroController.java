package com.centroinformacion.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Estado;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.LibroService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.apachecommons.CommonsLog;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
@CommonsLog
public class LibroController {
	
	private final LibroService service;
	
	public LibroController(LibroService service) {
		// TODO Auto-generated constructor stub
		this.service = service;
	}
	
	@GetMapping("/reporteLibroPdf")
	public void report(HttpServletRequest request, HttpServletResponse response, String filtro,  int categoria, int tipo, int anio) {
		try {
			System.out.println("<<<<<<<<<<<<<<<<<<Hola>>>>>>>>>>>>>>>>>>");
			//PASO 1: Obtener el dataSource que va generar el reporte
			List<Libro> lstSalida = service.filtrarLibro(filtro, categoria,tipo, anio);
			JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(lstSalida);
			
			//PASO 2: Obtener el archivo que contiene el diseño del reporte
			String fileDirectory = request.getServletContext().getRealPath("/WEB-INF/reportes/reporteLibroEFSR.jasper");
			log.info(">>> " + fileDirectory);
			FileInputStream stream   = new FileInputStream(new File(fileDirectory));
			
			//PASO 3: Parámetros adicionales
			String fileLogo = request.getServletContext().getRealPath("/WEB-INF/imgs/logo.png");
			log.info(">> LOGO >> " + fileLogo);
			
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("LOGO", fileLogo);
			
			//PASO 4: Enviamos dataSource, diseño y parámetros para generar el PDF
			JasperReport jasperReport = (JasperReport) JRLoader.loadObject(stream);
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);
			
			//PASO 5: Enviar el PDF generado
			response.setContentType("application/x-pdf");
		    response.addHeader("Content-disposition", "attachment; filename=ReporteLibro.pdf");

			OutputStream outStream = response.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping("/filtrarLibro")
	@ResponseBody
	public List<Libro> listarLibro(String filtro, String categoria, String tipo, String anio){
		if(anio == "") anio = "-1";
		if(categoria.trim() == "") categoria = "-1";
		if(tipo.trim() == "") tipo = "-1";
		
		System.out.println("<<<<<<<<<<"+filtro);
		System.out.println("<<<<<<<<<<"+categoria);
		System.out.println("<<<<<<<<<<"+tipo);
		System.out.println("<<<<<<<<<<"+anio);
		return service.filtrarLibro(filtro, Integer.parseInt(categoria), Integer.parseInt(tipo), Integer.parseInt(anio));
	}
	
	@GetMapping("/listarLibroTitulo")
	@ResponseBody
	public List<Libro> listarLibroTitulo(String filtro){
		return service.listarLibro(filtro);
	}
	
	@PostMapping("/registrarLibro")
	@ResponseBody
	public Map<?, ?> registrarLibro(Libro libro, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		libro.setEstado(AppSettings.ACTIVO);
		libro.setFechaRegistro(new Date());
		libro.setFechaActualiza(new Date());
		Estado estado = new Estado();
		estado.setIdEstado(AppSettings.ESTADO_LIBRO_DISPONIBLE);
		libro.setEstadoV(estado);
		libro.setUsuarioRegistro(objUsuario);
		libro.setUsuarioActualiza(objUsuario);
		
		Libro objSalida = service.registraLibro(libro);
		if (objSalida == null) {
			map.put("ERROR", "Error en el registro");
		} else {
			List<Libro> lista = service.listarLibro("%");
			map.put("lista", lista);
			map.put("mensaje", "Registro Exitoso");
		}
		return map;
	}
	
	@PostMapping("/estadoLibro")
	@ResponseBody
	public List<Libro> eliminacionLogica(int id, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		Libro libro = service.buscarLibroPorId(id).get();
		libro.setEstado(libro.getEstado() == 0 ? 1 : 0);
		libro.setFechaActualiza(new Date());
		libro.setUsuarioActualiza(objUsuario);
		service.actualizaLibro(libro);
		return service.listarLibro("%");
		
	}
	
	@PostMapping("/actualizarLibro")
	@ResponseBody
	public Map<?, ?> actualizarLibro(Libro libro, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		Libro objLibro = service.buscarLibroPorId(libro.getIdLibro()).get();
		libro.setEstado(objLibro.getEstado());
		libro.setFechaRegistro(objLibro.getFechaRegistro());
		libro.setFechaActualiza(new Date());
		libro.setEstadoV(objLibro.getEstadoV());
		libro.setUsuarioRegistro(objLibro.getUsuarioRegistro());
		libro.setUsuarioActualiza(objUsuario);
		
		Libro objSalida = service.actualizaLibro(libro);
		if (objSalida == null) {
			map.put("ERROR", "Error en la actualización");
		} else {
			List<Libro> lista = service.listarLibro("%");
			map.put("lista", lista);
			map.put("mensaje", "Actualización Exitosa");
		}
		return map;
	}
}
