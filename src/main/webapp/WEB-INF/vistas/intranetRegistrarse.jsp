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

<link rel="stylesheet" href="css/form-elements.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>

<title>Intranet</title>
</head>
<body>
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<img alt="" src="https://themes.odilo.io/Bib-Municipal-Lima_E0907/images/logo.png">
                        		</div>
                            </div>
                            <div class="form-bottom">
							<form id="id_form_registra" accept-charset="UTF-8" action="registrarUsuario3" class="form-horizontal" method="post">
		
		                    <div class="panel-group" id="steps">
		                        <!-- Step 1 -->
		                        <div class="panel panel-default">
		                            <div class="panel-heading">
		                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#steps" href="#stepOne">Registrarse</a></h4>
		                            </div>
		                            <div id="stepOne" class="panel-collapse collapse in">
		                                <div class="panel-body">
		                                     <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_nombres">Nombres</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_nombres" name="nombres" placeholder="Ingrese nombres" type="text" maxlength="30"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_apellidos">Apellidos</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_apellidos" name="apellidos" placeholder="Ingrese apellidos" type="text" maxlength="40"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_dni">DNI</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_dni" name="dni" placeholder="Ingrese DNI" type="text" maxlength="8"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_correo">Correo</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_correo" name="correo" placeholder="Ingrese email" type="text" maxlength="30"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_login">Nombre de usuario</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_login" name="login" placeholder="Ingrese Nuevo Usuario" type="text" maxlength="25"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_password">Contraseña</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_password" name="password" placeholder="Ingrese contraseña" type="password" maxlength="30"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label class="col-lg-3 control-label" for="id_reg_fecNac">Fecha de Nacimiento</label>
		                                        <div class="col-lg-8">
													<input class="form-control" id="id_reg_fecNacimiento" name="fecNacimiento" placeholder="Ingrese fecha de nacimiento" type="date"/>
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <div class="col-lg-8 col-lg-offset-3">
		                                        	<button type="button" class="btn btn-primary" id="id_btn_registra">REGISTRA</button>
		                                        	<a style="width: 100%; margin-top: 10px" type="button" class="btn btn-warning" href="/">Atrás</a>
		                                        </div>
		                                    </div>  
		                                    </div>
		                                    </div>
		                                    </div>
		                                    </div>
		                </form>
		                </div>
		                </div>
<script type="text/javascript">
<!-- Agregar aquí -->
function limpiar(){
	$("#id_reg_nombres").val('');
	$("#id_reg_apellidos").val('');
	$("#id_reg_dni").val('');
	$("#id_reg_correo").val('');
	$("#id_reg_login").val('');
	$("#id_reg_password").val('');
	$("#id_reg_fecNacimiento").val('');
}


$("#id_btn_registra").click(function(){
	
	var validator = $("#id_form_registra").data('bootstrapValidator');
	validator.validate();
	
	if(validator.isValid()){
		$.ajax({
			type: "POST",
			url: "registrarUsuario3",
			data: $('#id_form_registra').serialize(),
			success: function(response) {
				window.location.href = "/?msg="+response.msg;
			    validator.resetForm();
			}
		});
	}
})

$(document).ready(function() {
	$('#id_form_registra').bootstrapValidator({
	    message: 'This value is not valid',
	    feedbackIcons: {
	        valid: 'glyphicon glyphicon-ok',
	        invalid: 'glyphicon glyphicon-remove',
	        validating: 'glyphicon glyphicon-refresh'
	    },
	    fields: {
	    	nombres: {
	    		selector : '#id_reg_nombres',
	            validators: {
	                notEmpty: {
	                    message: 'El nombre es un campo obligatorio'
	                },
	                stringLength :{
	                	message:'El nombre es de 2 a 40 caracteres',
	                	min : 2,
	                	max : 40
	                }
	            }
	        },
	        apellidos: {
	    		selector : '#id_reg_apellidos',
	            validators: {
	                notEmpty: {
	                    message: 'El apellido es un campo obligatorio'
	                },
	                stringLength :{
	                	message:'El apellido es de 2 a 60 caracteres',
	                	min : 2,
	                	max : 60
	                }
	            }
	        },
	        dni: {
	    		selector : '#id_reg_dni',
	            validators: {
	                notEmpty: {
	                    message: 'DNI es un campo obligatorio'
	                },
	                regexp: {
	                    regexp: /^[0-9]{8}$/,
	                    message: 'El DNI tiene 8 dígitos'
	                },
	            }
	        },
	        correo: {
	    		selector : '#id_reg_correo',
	            validators: {
	                notEmpty: {
	                    message: 'Correo es un campo obligatorio'
	                },
	                regexp: {
	                    regexp: /^[^@]+@[^@]+\.[a-zA-Z]{2,}$/,
	                    message: 'Correo no válido'
	                }
	                
	            }
	        },
	        login: {
	    		selector : '#id_reg_login',
	            validators: {
	                notEmpty: {
	                    message: 'El nombre de usuario es un campo obligatorio'
	                },
	                stringLength :{
	                	message:'El usuario es de 2 a 40 caracteres',
	                	min : 2,
	                	max : 40
	                }
	            }
	        },
	        password: {
	    		selector : '#id_reg_password',
	            validators: {
	                notEmpty: {
	                    message: 'La contraseña es un campo obligatorio'
	                },
	                stringLength :{
	                	message:'La contraseña es de 2 a 40 caracteres',
	                	min : 2,
	                	max : 40
	                }
	            }
	        },
	        fecNacimiento: {
	    		selector : '#id_reg_fecNacimiento',
	            validators: {
	            	notEmpty: {
	                    message: 'Fecha de nacimiento es un campo obligatorio'
	                },
	            }
	        },
	        
	    	
	    }   
	});
    $('#validateBtn').click(function() {
        $('#id_form').bootstrapValidator('validate');
    });
});
</script>
</body>
</html>