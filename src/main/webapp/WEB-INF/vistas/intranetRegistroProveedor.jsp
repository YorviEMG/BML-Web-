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
<link rel="stylesheet" href="css/bootstrapValidator.css"/>

<title>Intranet</title>
</head>
<body>
<jsp:include page="intranetCabecera.jsp" />
<div class="container" style="margin-top: 4%"><h4>Registro de proveedor</h4></div>

<div class="container" style="margin-top: 1%">
<!-- Agregar aquí -->
	<form id="id_form" method="post">
			<div class="col-md-12" style="margin-top: 2%">

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_razonsocial">Razón social</label> <input
							class="form-control" type="text" id="id_razonsocial" name="razonsocial"
							placeholder="Ingrese la razón social" minlength="2"
							maxlength="40">
					</div>

					<div class="form-group col-md-6">
						<label class="control-label" for="id_ruc">RUC</label>
						<input class="form-control" type="text" id="id_ruc"
							name="ruc" placeholder="Ingrese el RUC" required
							pattern="[0-9]{11}" maxlength="11">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_telefono">Dirección</label>
						<input class="form-control" type="text" id="id_direccion"
							name="direccion" placeholder="Ingrese la dirección" minlength="2"
							maxlength="40">
					</div>

					<div class="form-group col-md-6">
						<label class="control-label" for="id_telefono">Celular</label>
						<input class="form-control" type="text" id="id_celular"
							name="celular" placeholder="Ingrese el celular" required
							pattern="[0-9]{9}" maxlength="9">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_correo">Contacto</label>
						<input class="form-control" type="text" id="id_contacto"
							name="contacto" placeholder="Ingrese el contacto" minlength="2"
							maxlength="40">
					</div>

					<div class="form-group col-md-6">
						<label class="control-label" for="id_tipoProveedor">Tipo</label>
						<select id="id_tipoProveedor" name="tipoProveedor.idDataCatalogo"
							class="form-control">
							<option value=" ">[Seleccione]</option>
							
						</select>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-6">
						<label class="control-label" for="id_pais">País</label>
						<select id="id_pais" name="pais.idPais" class='form-control'>
							<option value=" ">[Seleccione]</option>
							
						</select>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-12" align="center">
						<button id="id_registrar" type="button" class="btn btn-success">Registrar</button>
					</div>
				</div>
			</div>
		</form>
</div>

<script type="text/javascript">
<!-- Agregar aquí -->
//cargar combo de país
$.getJSON("listaPais", {}, function(data) {
	$.each(data, function(index, item) {
		$("#id_pais").append(
				"<option value="+item.idPais +">" + item.nombre
						+ "</option>");
	});
});

//cargar combo de tipo
$.getJSON("listaTipoProveedor", {}, function(data) {
	$.each(data, function(index, item) {
		$("#id_tipoProveedor").append(
				"<option value="+item.idDataCatalogo +">" + item.descripcion
						+ "</option>");
	});
});
$("#id_registrar").click(function() {
	var validator = $('#id_form').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()) {
		$.ajax({
			type : "POST",
			url : "registraProveedor",
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
	$("#id_razon_social").val('');
	$("#id_ruc").val('');
	$("#id_direccion").val('');
	$("#id_celular").val('');
	$("#id_contacto").val('');
	$("#id_pais").val(' ');
	$("#id_tipo").val(' ');
}
$('#id_form').bootstrapValidator({
	message : 'This value is not valid',
	feedbackIcons : {
		valid : 'glyphicon glyphicon-ok',
		invalid : 'glyphicon glyphicon-remove',
		validating : 'glyphicon glyphicon-refresh'
	},
	fields : {
		razon_social : {
			selector : '#id_razon_social',
			validators : {
				notEmpty : {
					message : 'La razón social es un campo obligatorio'
				},
				stringLength : {
					message : 'La razón social debe tener entre 2 y 40 caracteres',
					min : 2,
					max : 40
				}
			}
		},
		ruc : {
			selector : '#id_ruc',
			validators : {
				notEmpty : {
					message : 'El RUC es un campo obligatorio'
				},
				stringLength : {
					message : 'El RUC debe tener 11 dígitos',
					min : 11,
					max : 11
				},
				numeric : {
					message : 'El RUC solo contiene dígitos'
				},
				remote :{
                	delay   : 1000,
                	url     : 'buscaPorRuc',
                	message : 'El RUC ya existe'
                },
                regexp : {
					message : 'Ingrese un valor válido'
				}
			}
		},
		direccion : {
			selector : '#id_direccion',
			validators : {
				notEmpty : {
					message : 'La dirección es un campo obligatorio'
				},
				stringLength : {
					message : 'La dirección debe tener entre 2 y 40 caracteres',
					min : 2,
					max : 40
				}
			}
		},
		celular : {
			selector : '#id_celular',
			validators : {
				notEmpty : {
					message : 'El celular es un campo obligatorio'
				},
				stringLength : {
					message : 'El celular debe tener 9 dígitos',
					min : 9,
					max : 9
				},
				numeric : {
					message : 'El celular debe contener solo números'
				},
				regexp : {
					message : 'Ingrese un valor válido'
				}
			}
		},
		contacto : {
			selector : '#id_contacto',
			validators : {
				notEmpty : {
					message : 'El contacto es un campo obligatorio'
				},
				stringLength : {
					message : 'El contacto debe tener entre 2 y 40 caracteres',
					min : 2,
					max : 40
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
		tipo : {
			selector : '#id_tipoProveedor',
			validators : {
				notEmpty : {
					message : 'El tipo es un campo obligatorio'
				},
			}
		},
	}
});
</script>   		
</body>
</html>