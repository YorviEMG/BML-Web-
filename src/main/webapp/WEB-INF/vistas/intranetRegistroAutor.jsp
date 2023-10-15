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
<div class="container" style="margin-top: 4%"><h1>Registro Autor</h1></div>

<div class="container" style="margin-top: 1%">
<form id="id_form" action="registraLibro" method="post"> 
		<div class="row" style="margin-top: 5%">
			<div class="form-group col-sm-6">
				<div class="col-sm-3">
					<label class="control-label" for="id_nombres">Nombres</label>
				</div>
				<div class="col-sm-9">
					<input class="form-control" type="text" id="id_nombres" name="nombres" placeholder="Ingrese los nombres" maxlength="40">
				</div>
			</div>
			<div class="form-group  col-sm-6">
				<div class="col-sm-3">
					<label class="control-label" for="id_apellidos">Apellidos</label>
				</div>
				<div class="col-sm-9">
					<input class="form-control" type="text" id="id_apellidos" name="apellidos" placeholder="Ingrese los apellidos" maxlength="40">
		 		</div>
			</div>
			<div class="form-group  col-sm-6">
				<div class="col-sm-3">
					<label class="control-label" for="id_fecha">Fecha de Nacimiento</label>
				</div>
				<div class="col-sm-9">
					<input class="form-control" type="date" id="id_fecha" name="fechaNacimiento" placeholder="Ingrese la fecha" maxlength="100">
		 		</div>
			</div>
			<div class="form-group col-sm-6">
				<div class="col-sm-3">
					<label class="control-label" for="id_telefono">Teléfono</label>
				</div>
				<div class="col-sm-9">
					<input class="form-control" type="text" id="id_telefono" name="telefono" placeholder="Ingrese el teléfono" maxlength="9">
				</div>
			</div>
		</div>
		
		<div class="row" style="margin-top: 0%;">
			<div class="form-group col-md-6">
				<div class="col-sm-12">					
					<label class="control-label" for="id_pais">País</label>
					<select id="id_pais" name="pais.idPais" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-sm-12">
					<label class="control-label" for="id_grado">Grado</label>
					<select id="id_grado" name="grado.idDataCatalogo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>	
			</div>
		    		  
		</div>
		  
		<div class="row" style="margin-top: 2%" align="center"	>
				<button id="id_registrar" type="button" class="btn btn-primary" >Crea Autor</button>
		</div>	
	</form>
	
</div>

<script type="text/javascript">
$.getJSON("listaPais", {}, function(data) {
	$.each(data, function(index, item) {
		$("#id_pais").append("<option value="+item.idPais +">" + item.nombre + "</option>");
	});
});

$.getJSON("listaGradoAutor",{}, function(data){
	$.each(data, function(index,item){
		$("#id_grado").append("<option value="+item.idDataCatalogo+">"+item.descripcion+"</option");
	});
});
 
 $("#id_registrar").click(function(){
 	var validator = $('#id_form').data('bootstrapValidator');
 	validator.validate();
 	
 	if(validator.isValid()){
 		$.ajax({
 			type: 'POST',
 			data: $("#id_form").serialize(),
 			url: 'registraAutor',
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
 });


function limpiar(){
	$("#id_nombres").val('');
	$("#id_apellidos").val('');
	$("#id_fecha").val('');
	$("#id_telefono").val('');
	$("#id_pais").val(' ');
	$("#id_grado").val(' ');
}


$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	nombres: {
    		selector : '#id_nombres',
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
    		selector : '#id_apellidos',
            validators: {
                notEmpty: {
                    message: 'El apellido es un campo obligatorio'
                },
                stringLength :{
                	message:'El apellido es de 2 a 40 caracteres',
                	min : 2,
                	max : 40
                }
            }
        },
        fechaNacimiento : {
			selector : '#id_fecha',
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
        telefono: {
    		selector : '#id_telefono',
            validators: {
                notEmpty: {
                    message: 'El teléfono es un campo obligatorio'
                },               
                regexp: {
                    regexp: /^[0-9]{9}$/,
                    message: 'El teléfono debe tener 9 dígitos'
                }
                
            }
        },
        
        pais: {
    		selector : '#id_pais',
            validators: {
            	notEmpty: {
                    message: 'El país es un campo obligatorio'
                },
            }
        },
        grado: {
    		selector : '#id_grado',
            validators: {
            	notEmpty: {
                    message: 'El grado es un campo obligatorio'
                },
            }
        },
    	
    }   
});


</script>   		
</body>
</html>