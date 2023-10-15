<jsp:include page="intranetValida.jsp" />
<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
<link rel="stRegistro Pruebaylesheet" href="css/bootstrapValidator.css"/>

<title>Intranet</title>
</head>
<body>
<jsp:include page="intranetCabecera.jsp" />
<div class="container" style="margin-top: 4%"><h4>Registro Tesis</h4></div>

<div class="container" style="margin-top: 1%">
<!-- Agregar aquí -->
	<form id="id_form" method="POST"> 
		<div class="row" style="margin-top: 5%">
			<div class="form-group col-sm-6">
				<div class="col-sm-4">
					<label class="control-label" for="id_titulo">Título</label>
				</div>
				<div class="col-sm-8">
					<input class="form-control" type="text" id="id_titulo" name="titulo" placeholder="Ingrese el título" maxlength="40">
				</div>
			</div>
			<div class="form-group  col-sm-6">
				<div class="col-sm-4">
					<label class="control-label" for="id_tema">Tema</label>
				</div>
				<div class="col-sm-8">
					<input class="form-control" type="text" id="id_tema" name="tema" placeholder="Ingrese el tema" maxlength="40">
		 		</div>
			</div>
		</div>
		<div class="row" style="margin-top: 0%">
			<div class="form-group col-sm-6">
				<div class="col-sm-4">
					<label class="control-label" for="id_fecha">Fecha de Creación</label>
				</div>
				<div class="col-sm-8">
					<input class="form-control" type="date" id="id_fecha" name="fechaCreacion" placeholder="Ingrese la fecha" maxlength="100">
		 		</div>
				
			</div>
			<div class="form-group  col-sm-6">
				 <div class="col-sm-4">
					<label class="control-label" for="id_alumno">Alumno</label>
				</div>
				<div class="col-sm-8">
					<select id="id_alumno" name="alumno.idAlumno" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			</div>
		</div>
		
		<div class="row" style="margin-top: 2%" align="center"	>
				<button id="id_registrar" type="button" class="btn btn-primary" >Crea Tesis</button>
		</div>	
	</form>
</div>

<script type="text/javascript">
<!-- Agregar aquí -->
$.getJSON("listaAlumno", {}, function(data) {
	$.each(data, function(index, item) {
		$("#id_alumno").append(
				"<option value="+item.idAlumno +">" + item.nombres
						+ " " + item.apellidos + "</option>");
	});
});

$("#id_registrar").click(function (){ 

	var validator = $('#id_form').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()){
		$.ajax({
			type: 'POST',  
			data: $("#id_form").serialize(),
			url: 'registraTesis',
			success: function(data){
				mostrarMensaje(data.MENSAJE);
				limpiar();
				validator.resetForm();
			},
			error: function(){
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
})

function limpiar(){
			$("#id_titulo").val('');
			$("#id_tema").val('');
			$("#id_fecha").val('');
			$("#id_alumno").val(' ');
		}
		
		$(document).ready(function () {
			$('#id_form').bootstrapValidator({
				message: 'This value is not valid',
				feedbackIcons: {
					valid: 'glyphicon glyphicon-ok',
					invalid: 'glyphicon glyphicon-remove',
					validating: 'glyphicon glyphicon-refresh'
				},
				fields: {
					titulo: {
						selector: "#id_titulo",
						validators: {
							notEmpty: {
								message: 'El título es obligatorio'
							},
							stringLength: {
								min: 3,
								max: 40,
								message: 'El título es de 3 a 40 caracteres'
							},
						}
					},
					tema: {
						selector: "#id_tema",
						validators: {
							notEmpty: {
								message: 'El tema es obligatorio'
							},
							stringLength: {
								min: 3,
								max: 40,
								message: 'El tema es de 3 a 40 caracteres'
							},
						}
					},
					fechaCreacion: {
						selector: "#id_fecha",
						validators: {
							notEmpty: {
								message: 'La fecha es obligatorio'
							}
						}
					},
					alumno: {
						selector: '#id_alumno',
						validators: {
							notEmpty: {
								message: 'Alumno es un campo obligatorio'
							},
						}
					},
				}
			});

		});

</script>   		
</body>
</html>