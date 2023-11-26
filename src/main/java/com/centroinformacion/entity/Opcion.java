package com.centroinformacion.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "tb_opcion")
public class Opcion {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idOpcion;
	private String descripcion;
	private int estado;
	private String ruta;
	private int tipo;

}
