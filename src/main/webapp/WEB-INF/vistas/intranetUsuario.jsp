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
<div class="container" style="margin-top: 4%"><h4 style="font-size: 23pt; font-weight: 500;">Gestión de Usuarios</h4></div>

<div class="container" style="margin-top: 1%">
	<div class="col-md-23" >  
		<div class="row" style="height: 70px">
			<div class="col-md-4" >
				<input class="form-control" id="id_filtro_login"  name="login" placeholder="Ingrese usuario" type="text" maxlength="30"/>
			</div>
			<div class="col-md-4" >
				<input class="form-control" id="id_filtro_dni"  name="dni" placeholder="Ingrese dni" type="text" maxlength="8"/>
			</div>
			<div class="col-md-2" >
				<select id="id_filtro_rol" name="rol" class='form-control'>
					<option value="-1">[Seleccione]</option>
				</select>
			</div>
			<div class="col-md-2" >
				<button type="button" class="btn btn-primary" id="id_btn_filtrar" style="width: 150px">FILTRA</button>
			</div>
		</div>
		<div class="row" > 
			<div class="col-md-12">
				<div class="content" >
					<table id="id_table" class="table table-striped table-bordered" >
						<thead>
							<tr>
								<th style="width: 5%" >ID</th>
								<th style="width: 10%">Nombres</th>
								<th style="width: 10%">Apellidos</th>
								<th style="width: 10%">DNI</th>
								<th style="width: 10%">Usuario</th>
								<th style="width: 10%">Contraseña</th>
								<th style="width: 10%">Correo</th>
								<th style="width: 5%">Fec. Nacimiento</th>
								<th style="width: 5%">Rol</th>
								<th style="width: 10%">Estado</th>
								<th style="width: 10%">Actualizar</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>	
			</div>
		</div>
	 </div>
	 <div class="modal fade" id="id_div_modal_actualiza" >
		<div class="modal-dialog" style="width: 60%">	
			<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Actualiza Usuario</h4>
				</div>
				<div class="modal-body" style="padding: 20px 10px;">
					<form id="id_form_actualiza" accept-charset="UTF-8"  action="registraActualizaCrudModalidad" class="form-horizontal"     method="post">
		            	<div class="panel-group" id="steps">
		                	<div class="panel panel-default">
		                    	<div class="panel-heading">
		                        	<h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps" href="#stepOne">Datos de Usuario</a></h4>
		                        </div>
		                        <div id="stepOne" class="panel-collapse collapse in">
		                        	<div class="panel-body">
		                            	<div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_ID">ID</label>
		                                   	<div class="col-lg-8">
		                                    	<input class="form-control" id="id_ID" readonly="readonly" name="idUsuario" type="text" maxlength="8"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_nombres">Nombres</label>
		                                    <div class="col-lg-8">
										 		 <input class="form-control" id="id_act_nombres" name="nombres" placeholder="Ingrese nombres" type="text" maxlength="30"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_apellidos">Apellidos</label>
		                                    <div class="col-lg-8">
										 		 <input class="form-control" id="id_act_apellidos" name="apellidos" placeholder="Ingrese apellidos" type="text" maxlength="30"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_dni">DNI</label>
		                                    <div class="col-lg-3">
										 	    <input class="form-control" id="id_act_dni" name="dni" placeholder="Ingrese dni" type="text" maxlength="8"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_login">Usuario</label>
		                                    <div class="col-lg-3">
										 		<input class="form-control" id="id_act_login" name="login" placeholder="Ingrese usuario" type="text" maxlength="30"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_password">Contraseña</label>
		                                    <div class="col-lg-3">
										 		<input class="form-control" id="id_act_password" name="password" placeholder="Ingrese contraseña" type="password" maxlength="30"/>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_correo">Correo</label>
		                                    <div class="col-lg-3">
										 		<input class="form-control" id="id_act_correo" name="correo" placeholder="Ingrese correo" type="text" maxlength="30"/>
		                                    </div>
		                                </div> 
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_fecNacimiento">Fecha de Nacimiento</label>
		                                    <div class="col-lg-3">
										 		<input class="form-control" id="id_act_fecNacimiento" name="fecNacimiento" placeholder="Ingrese fecha de nacimiento" type="date"/>
		                                    </div>
		                                </div> 
		                                <div class="form-group">
		                                    <label class="col-lg-3 control-label" for="id_act_rol">Rol</label>
		                                    <div class="col-lg-3">
										 	    <select id="id_act_rol" name="rol" class='form-control'>
							                       	<option value=" ">[Seleccione]</option>
							                    </select>
		                                    </div>
		                                </div>
		                                <div class="form-group">
		                                    <div class="col-lg-9 col-lg-offset-3">
		                                       	<button type="button" class="btn btn-primary" id="id_btn_actualiza">ACTUALIZA</button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </form>   			
				</div>
			</div>
		</div>	
	</div>	
</div>

<script type="text/javascript">
<!-- Agregar aquí -->
$.getJSON("listaRol", {}, function(data){
	$.each(data, function(i, item){
		$("#id_act_rol").append("<option value="+ item.idRol +">"+ item.descripcion + "</option>");
		$("#id_filtro_rol").append("<option value="+ item.idRol +">"+ item.descripcion + "</option>");
	});
});

$("#id_btn_filtrar").click(function(){
	var log = $("#id_filtro_login").val();
	var dni = $("#id_filtro_dni").val();
	var rol = $("#id_filtro_rol").val();
	$.getJSON("filtrarUsuario", {"login":log,"dni":dni,"rol":rol}, function(lista){
		agregarGrilla(lista);
	});
});

function agregarGrilla(lista){
	$('#id_table').DataTable().clear();
	$('#id_table').DataTable().destroy();
	$('#id_table').DataTable({
		data: lista,
		searching: false,
		ordering: true,
		processing: true,
		pageLength: 10,
		lengthChange: false,
		columns:[
			{data: "idUsuario"},
			{data: "nombres"},
			{data: "apellidos"},
			{data: "dni"},
			{data: "login"},
			{data: "password"},
			{data: "correo"},
			{data: "fecNacimiento"},
			{data: "rol.descripcion"},
			{data: function(row, type, val, meta){
			    var salida='<button type="button" style="width: 90px" class="btn btn-warning btn-sm" onclick="accionEliminar(\'' + row.idUsuario + '\')">'+ (row.estado == 1? 'Activo':'Inactvo') +  '</button>';
				return salida;
			},className:'text-center'},
			{data: function(row, type, val, meta){
				var salida='<button type="button" style="width: 90px" class="btn btn-info btn-sm" onclick="editar(\''+row.idUsuario + '\',\'' + 
						    row.nombres +'\',\'' + row.apellidos  +'\',\'' + row.dni + '\',\'' + row.login + '\',\'' + row.password + '\',\'' +
						    row.correo + '\',\'' + row.fecNacimiento + '\',\'' +  row.rol.idRol + '\')">Editar</button>';
				return salida;
			},className:'text-center'},	
		]                                     
    });
}
function accionEliminar(id){
	$.ajax({
		type: "POST",
		url: "estadoUsuario",
		data: {"id":id},
		success: function(data){
			agregarGrilla(data);
		},
		error: function(){
			mostrarMensaje(MSG_ERROR);
		}	
	});
}
function editar(id, nombres, apellidos, dni, login, password, correo, fecNacimiento, rol){
	$("#id_ID").val(id)
	$("#id_act_nombres").val(nombres);
	$("#id_act_apellidos").val(apellidos);
	$("#id_act_dni").val(dni);
	$("#id_act_login").val(login);
	$("#id_act_password").val(password);
	$("#id_act_correo").val(correo);
	$("#id_act_fecNacimiento").val(fecNacimiento);
	$("#id_act_rol").val(rol);
	$('#id_div_modal_actualiza').modal("show");
	var validator = $("#id_form_actualiza").data('bootstrapValidator');
	validator.resetForm();
}

$("#id_btn_actualiza").click(function(){
	var validator = $("#id_form_actualiza").data('bootstrapValidator');
	validator.validate();

	if(validator.isValid()){
		$.ajax({
			type: "POST",
			url: "actualizarUsuario",
			data: $("#id_form_actualiza").serialize(),
			success: function(data){
				agregarGrilla(data.lista);
				
				$("#id_div_modal_actualiza").modal("hide");
				mostrarMensaje(data.mensaje);
				limpiar();
				validator.resetForm();
			},
			error: function(){
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
	
})

$('#id_form_actualiza').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    excluded: [':disabled'],
    fields: {
    	titulo: {
    		selector : '#id_act_titulo',
            validators: {
                notEmpty: {
                    message: 'El título es un campo obligatorio'
                },
                remote : {
                	delay : 1000,
                	url : 'buscaPorTituloAct',
                	message : 'Título ya existe',
                	data: function() {
                        return {
                            titulo: $('#id_act_titulo').val(),
                            id: $('#id_ID').val()
                        };
                    },
                },
                stringLength :{
                	message:'El nombre es de 2 a 40 caracteres',
                	min : 2,
                	max : 40
                },
                

        	},
    	},
        anio: {
    		selector : '#id_act_anio',
            validators: {
                notEmpty: {
                    message: 'Año es un campo obligatorio'
                },
                regexp: {
                    regexp: /^[0-9]{1,4}$/,
                    message: 'El año tiene 4 dígitos como máximo'
                },
            }
        },
        serie: {
    		selector : '#id_act_serie',
            validators: {
                notEmpty: {
                    message: 'Serie es un campo obligatorio'
                },
                remote : {
                	delay : 1000,
                	url : 'buscaPorSerieAct',
                	message : 'Serie ya existe',
                	data: function() {
                        return {
                            titulo: $('#id_act_serie').val(),
                            id: $('#id_ID').val()
                        };
                    },
                },
                regexp: {
                    regexp: /^[A-z]{2}[0-9]{3}$/,
                    message: 'Formato serie AA999'
                }
                
            }
        },
        
        categoria: {
    		selector : '#id_act_categoria',
            validators: {
            	notEmpty: {
                    message: 'Categoría es un campo obligatorio'
                },
            }
        },
        tipo: {
    		selector : '#id_act_tipo',
            validators: {
            	notEmpty: {
                    message: 'Tipo es un campo obligatorio'
                },
            }
        },
    	
    }   
});
</script>   		
</body>
</html>