<jsp:include page="intranetValida.jsp" />
<!DOCTYPE html>
<html lang="esS">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Cache-Control" content="private" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>

<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrapValidator.css" />

<title>Intranet</title>
</head>
<body>
	<jsp:include page="intranetCabecera.jsp" />
	<div class="container" style="margin-top: 4%">

		<h4>Autor: Miguel López</h4>
		<h4>
			<strong style="font-size: 24px">Registro de Alumno</strong>
		</h4>

	</div>

	<div class="container" style="margin-top: 1%">

		<form id="id_form" method="post">
			<div class="col-md-12" style="margin-top: 2%">

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_nombres">Nombre</label> <input
							class="form-control" type="text" id="id_nombres" name="nombres"
							placeholder="Ingrese el nombre" maxlength="40">
					</div>

					<div class="form-group col-md-6">
						<label class="control-label" for="id_apellidos">Apellido</label> <input
							class="form-control" type="text" id="id_apellidos"
							name="apellidos" placeholder="Ingrese el apellido" maxlength="40">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_telefono">Teléfono</label> <input
							class="form-control" type="tel" id="id_telefono" name="telefono"
							placeholder="Ingrese el teléfono" maxlength="9">
					</div>

					<div class="form-group col-md-6">
						<label class="control-label" for="id_dni">DNI</label> <input
							class="form-control" type="text" id="id_dni" name="dni"
							placeholder="Ingrese el DNI" maxlength="8">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_correo">Correo</label> <input
							class="form-control" type="email" id="id_correo" name="correo"
							placeholder="Ingrese el correo">
					</div>

					<div class="form-group col-md-6">
						<label class="control-label" for="id_fecha_nacimiento">Fecha
							de Nacimiento</label> <input class="form-control" type="date"
							id="id_fecha_nacimiento" name="fechaNacimiento">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_pais">País</label> <select
							id="id_pais" name="pais.idPais" class='form-control'>
							<option value=" ">[Seleccione]</option>

						</select>
					</div>


					<div class="form-group col-md-6">
						<label class="control-label" for="id_modalidad">Modalidad</label>
						<select id="id_modalidad" name="modalidad.idDataCatalogo"
							class="form-control">
							<option value=" ">[Seleccione]</option>

						</select>
					</div>


					<div class="row">
						<div class="form-group col-md-12" align="center">
							<button id="id_registrar" type="button" class="btn btn-success">Registrar</button>
						</div>
					</div>

				</div>
			</div>
		</form>

	</div>

	<script type="text/javascript">
	
	
		//Para cargar el ComboBox de País
		$.getJSON("listaPais", {}, function(data) {
			$.each(data, function(index, item) {
				$("#id_pais").append(
						"<option value="+item.idPais +">" + item.nombre
								+ "</option>");
			});
		});
		

		//Para cargar el ComboBox de Modalidad
		$.getJSON("listaModalidadAlumno", {}, function(data) {
			$.each(data, function(index, item) {
				$("#id_modalidad").append(
						"<option value="+item.idDataCatalogo +">"
								+ item.descripcion + "</option>");
			});
		});

		
		$("#id_registrar").click(function() {
			var validator = $('#id_form').data('bootstrapValidator');
			validator.validate();

			if (validator.isValid()) {
				$.ajax({
					type : "POST",
					url : "registraAlumno",
					data : $('#id_form').serialize(),
					success : function(data) {
						mostrarMensaje(data.MENSAJE);
						validator.resetForm();
						limpiarFormulario();
					},
					error : function() {
						mostrarMensaje(MSG_ERROR);
					}
				});
			}
		});

		
		function limpiarFormulario() {
			$("#id_nombres").val('');
			$("#id_apellidos").val('');
			$("#id_telefono").val('');
			$("#id_dni").val('');
			$("#id_correo").val('');
			$("#id_fecha_nacimiento").val('');
			$("#id_pais").val(' ');
			$("#id_modalidad").val(' ');
		}

		$('#id_form')
				.bootstrapValidator(
						{
							message : 'This value is not valid',
							feedbackIcons : {
								valid : 'glyphicon glyphicon-ok',
								invalid : 'glyphicon glyphicon-remove',
								validating : 'glyphicon glyphicon-refresh'
							},
							fields : {
								nombres : {
									selector : '#id_nombres',
									validators : {
										notEmpty : {
											message : 'El nombre es un campo obligatorio'
										},
										stringLength : {
											message : 'El nombre debe tener entre 2 y 40 caracteres',
											min : 2,
											max : 40
										},
										regexp : {
											regexp : /^[A-Za-záéíóúÁÉÍÓÚñÑ\s]+$/,
											message : 'El nombre debe contener solo letras'
										}
									}
								},

								apellidos : {
									selector : '#id_apellidos',
									validators : {
										notEmpty : {
											message : 'El apellido es un campo obligatorio'
										},
										stringLength : {
											message : 'El apellido debe tener entre 2 y 40 caracteres',
											min : 2,
											max : 40
										},
										regexp : {
											regexp : /^[A-Za-záéíóúÁÉÍÓÚñÑ\s]+$/,
											message : 'El apellido debe contener solo letras'
										}
									}
								},
								telefono : {
									selector : '#id_telefono',
									validators : {
										notEmpty : {
											message : 'El teléfono es un campo obligatorio'
										},
										stringLength : {
											message : 'El teléfono debe tener 9 dígitos',
											min : 9,
											max : 9
										},
										numeric : {
											message : 'El teléfono debe contener solo números'
										}
									}
								},
								dni : {
									selector : '#id_dni',
									validators : {
										notEmpty : {
											message : 'El DNI es un campo obligatorio'
										},
										stringLength : {
											message : 'El DNI debe tener 8 dígitos',
											min : 8,
											max : 8
										},
										numeric : {
											message : 'El DNI debe contener solo números'
										},
										remote : {
											delay : 1000,
											url : 'buscaPorDni',
											message : 'El dni ya existe'
										}
									}
								},
								correo : {
									selector : '#id_correo',
									validators : {
										notEmpty : {
											message : 'El correo es un campo obligatorio'
										},
										emailAddress : {
											message : 'El correo no tiene un formato válido'
										},
										remote : {
											delay : 1000,
											url : 'buscaPorCorreo',
											message : 'El correo ya existe'
										}
									}
								},
								fechaNacimiento : {
									selector : '#id_fecha_nacimiento',
									validators : {
										notEmpty : {
											message : 'La fecha de nacimiento es un campo obligatorio'
										},
										date : {
											format : 'YYYY-MM-DD',
											message : 'La fecha de nacimiento debe tener el formato YYYY-MM-DD'
										}
									}
								},
								pais : {
									selector : '#id_pais',
									validators : {
										notEmpty : {
											message : 'El país es un campo obligatorio'
										},
									}
								},
								modalidad : {
									selector : '#id_modalidad',
									validators : {
										notEmpty : {
											message : 'La modalidad es un campo obligatorio'
										},
									}
								},
							}
						});
	</script>

</body>
</html>
