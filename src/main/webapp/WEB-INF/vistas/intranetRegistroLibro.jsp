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
<div class="container" style="margin-top: 4%"><h4 style="font-weight: bolder; font-size: xx-large;">Registro Libro</h4></div>

<div class="container" style="margin-top: 1%">
<!-- Agregar aquí -->
	<form id="id_form" action="registraLibro" method="post"> 
		<div class="row" style="margin-top: 5%">
			<div class="form-group col-sm-6">
				<div class="col-sm-2">
					<label class="control-label" for="id_titulo">Título</label>
				</div>
				<div class="col-sm-10">
					<input class="form-control" type="text" id="id_titulo" name="titulo" placeholder="Ingrese el título" maxlength="40">
				</div>
			</div>
			<div class="form-group  col-sm-3">
				<div class="col-sm-3">
					<label class="control-label" for="id_anio">Año</label>
				</div>
				<div class="col-sm-9">
					<input class="form-control" type="text" id="id_anio" name="anio" placeholder="Ingrese el año" maxlength="4">
		 		</div>
			</div>
			<div class="form-group col-sm-3">
				<div class="col-sm-3">
					<label class="control-label" for="id_serie">Serie</label>
				</div>
				<div class="col-sm-9">
					<input class="form-control" type="text" id="id_serie" name="serie" placeholder="AA999 Ingrese serie" maxlength="5">
				</div>
			</div>
		</div>
		
		<div class="row" style="margin-top: 0%;">
			<div class="form-group col-md-6">
				<div class="col-sm-12">					
					<label class="control-label" for="id_categoria">Categoría</label>
					<select id="id_categoria" name="categoriaLibro.idDataCatalogo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
				</div>
			</div>
			<div class="form-group col-md-6">
				<div class="col-sm-12">
					<label class="control-label" for="id_tipo">Tipo</label>
					<select id="id_tipo" name="tipoLibro.idDataCatalogo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>	
			</div>
		    		  
		</div>
		  
		<div class="row" style="margin-top: 2%" align="center"	>
				<button id="id_registrar" type="button" class="btn btn-primary" >Crea Libro</button>
		</div>	
	</form>
	
</div>

<script type="text/javascript">
<!-- Agregar aquí -->
$.getJSON("listaCategoriaDeLibro", {}, function(data){
	$.each(data, function(index,item){
		$("#id_categoria").append("<option value="+item.idDataCatalogo +">"+ item.descripcion +"</option>");
	});
});

$.getJSON("listaTipoLibroRevista",{}, function(data){
	$.each(data, function(index,item){
		$("#id_tipo").append("<option value="+item.idDataCatalogo+">"+item.descripcion+"</option");
	});
});
/*Cuando el bootstrap validator encuentra un evento, automáticamente 
 * valida, sin importar el id u otro elemento. En este caso si eliminamos
 el click u cambiamos el evento click por ready y a la vez cambiamos el
 id del form, igual encontrará el form.
 */
 
 $("#id_registrar").click(function(){
 	var validator = $('#id_form').data('bootstrapValidator');
 	validator.validate();
 	
 	if(validator.isValid()){
 		$.ajax({
 			type: 'POST',
 			data: $("#id_form").serialize(),
 			url: 'registraLibro',
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
	$("#id_titulo").val('');
	$("#id_anio").val('');
	$("#id_serie").val('');
	$("#id_categoria").val(' ');
	$("#id_tipo").val(' ');
}


$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	titulo: {
    		selector : '#id_titulo',
            validators: {
                notEmpty: {
                    message: 'El título es un campo obligatorio'
                },
                remote : {
                	delay : 1000,
                	url : 'buscaPorTitulo',
                	message : 'Título ya existe'
                },
                stringLength :{
                	message:'El nombre es de 2 a 40 caracteres',
                	min : 2,
                	max : 40
                }
            }
        },
        anio: {
    		selector : '#id_anio',
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
    		selector : '#id_serie',
            validators: {
                notEmpty: {
                    message: 'Serie es un campo obligatorio'
                },
                remote : {
                	delay : 1000,
                	url : 'buscaPorSerie',
                	message : 'Serie ya existe'
                },
                regexp: {
                    regexp: /^[A-z]{2}[0-9]{3}$/,
                    message: 'Formato serie AA999'
                }
                
            }
        },
        
        categoria: {
    		selector : '#id_categoria',
            validators: {
            	notEmpty: {
                    message: 'Categoría es un campo obligatorio'
                },
            }
        },
        tipo: {
    		selector : '#id_tipo',
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