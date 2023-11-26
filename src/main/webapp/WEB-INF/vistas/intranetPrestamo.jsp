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
<div class="container" style="margin-top: 4%"><h4 style="font-size: 23pt; font-weight: 500;">PRÉSTAMOS</h4></div>
<div class="container">
	
			<input type="hidden" id="id_metodo"  class="form-control"/>
			<input type="hidden" id="id_elimina" class="form-control"/>
			<input type="hidden" id="id_usuario_id" value="-1" class="form-control"/>
			<input type="hidden" id="id_libro_id"  value="-1" class="form-control"/>
				<div class="row" id="steps">
				<div class="panel panel-default col-md-6">
					<div class="panel-heading">Usuario</div>
						<div class="panel-body">
							<form  class="form-horizontal">
							<div class="form-group">
									<label class="col-lg-3 control-label">Buscar Usuario</label>
									<div class="col-lg-5">
										<button type="button" id="id_btnUsuario" data-toggle='modal' class='btn btn-success' >Elegir Usuario</button>
									</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">Apellido</label>
								<div class="col-lg-5">
									<input type="text"  id="id_apellidos" name="apellidos" class="form-control" readonly="readonly"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">Nombre</label>
								<div class="col-lg-5">
									<input type="text"id="id_nombres" name="nombres" class="form-control"	readonly="readonly"/>
								</div>
							</div>
							</form>
					</div>
				</div>
				<div class="panel panel-default col-md-6">
					<div class="panel-heading">Libro</div>
						<div class="panel-body">
							<form  class="form-horizontal">
							<div class="form-group">
								<label class="col-lg-3 control-label">Buscar Libro</label>
								<div class="col-lg-5">
									<button type="button" id="id_btnLibro" data-toggle='modal' class='btn btn-success'>Ingresar Libro</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">Título</label>
								<div class="col-lg-5">
									<input type="text" name="titulo" id="id_titulo" class="form-control" readonly="readonly"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-3 control-label">Serie</label>
								<div class="col-lg-3">
									<input type="text" name="serie" id="id_serie" class="form-control" readonly="readonly"/>
								</div>
							</div>
							</form>
						</div>
				</div>
			</div>
			<div>
				<label class="col-lg-3 control-label">Fecha de devolución</label>
					<div class="col-lg-3">
						<input type="date" name="fecDev" id="id_fecDev" class="form-control" readonly="readonly"/>
					</div>
			</div>
			
			
			<div class="panel panel-default" style="margin-top: 60px">
					<div class="panel-heading">Registro de Préstamo</div>
						<div class="panel-body">
							<div class="form-group">
								<div class="col-lg-9 col-lg-offset-3">
									<button type="button" id="id_btnAgregar" class="btn btn-primary">AGREGAR</button>
									<button type="button" id="id_btnRegistrar"  class="btn btn-primary">REGISTRA PRÉSTAMO</button>
								</div>
							</div>
							<div class="form-group">
								<div class="col-lg-12">
									<table id="id_table" class="table table-striped table-bordered">
										<thead>
											<tr>
												<th>ID</th>
												<th>Título</th>
												<th>Serie</th>
												<th>Año</th>
												<th></th>
											</tr>
										</thead>
										<tbody id="id_table_body">
											
										</tbody>
									</table>
								</div>
							</div>
					</div>
				</div>


<!-- El formulario de busqueda de Cliente (Modal) -->

  	 <div class="modal fade" id="idBuscaUsuario" >
			<div class="modal-dialog" style="width: 60%; height: 60%">

				<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Busqueda de Usuario</h4>
				</div>
				<div class="modal-body" style="padding: 20px 10px;">
						    <div class="panel-group" id="steps">
		                        <div class="panel panel-default">
		                        			<form  class="form-horizontal">
											<div class="form-group">
													<label class="col-lg-3 control-label">
														Usuario
													</label>   
													<div class="col-lg-5">
														<input id="id_txtUsuario" class="form-control" name="usuario" type="text" />
													</div>
											</div>
											<div class="form-group">
												<div class="col-lg-12">
												<table id="id_table_usuario" class="table table-striped table-bordered">
														<thead>
															<tr>
																<th style="width: 20%">Id</th>
																<th style="width: 35%">Nombre</th>
																<th style="width: 35%">Apellido</th>
																<th style="width: 10%"></th>
															</tr>
														</thead>
														<tbody>

														</tbody>				
												</table>
												</div>
											</div>
											</form>
			                        </div>
		                    </div>
					</div>
			</div>
			</div>
		</div>

<!-- El formulario de busqueda de Producto (Modal) -->

  	 <div class="modal fade" id="idBuscaLibro" >
			<div class="modal-dialog" style="width: 60%">

				<div class="modal-content">
				<div class="modal-header" style="padding: 35px 50px">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Busqueda de Libro</h4>
				</div>
				<div class="modal-body" style="padding: 20px 10px;">
						    <div class="panel-group" id="steps">
		                        <div class="panel panel-default">
		                        		<form  class="form-horizontal">
											<div class="form-group">
													<label class="col-lg-3 control-label">
														Libro 
													</label>   
													<div class="col-lg-5">
														<input id="id_txtLibro" class="form-control" name="libro" type="text" />
													</div>
											</div>
											<div class="form-group">
												<div class="col-lg-12">
												<table id="id_table_libro" class="table table-striped table-bordered" >
														<thead>
															<tr>
																<th style="width: 15%">Id</th>
																<th style="width: 45%">Título</th>
																<th style="width: 15%">Serie</th>
																<th style="width: 15%">Año</th>
																<th style="width: 10%"></th>
															</tr>
														</thead>
														<tbody>

														</tbody>				
												</table>
												</div>
											</div>
										</form>	
		                        </div>
		                    </div>
				</div>
			</div>
			</div>
		</div>
		<!-- Modal Mensaje -->	
		  <div class="modal fade" id="idMensaje" >
			<div class="modal-dialog" style="width: 60%">

				<div class="modal-content">
				<div class="modal-header" style="padding: 20px 20px">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4><span class="glyphicon glyphicon-ok-sign"></span> Mensaje</h4>
				</div>
				<div  id="idMensajeTexto" class="modal-body" style="padding: 30px 30px;align-content: center;">
					
			    </div>
			</div>
			</div>
		</div>
</div>

<script type="text/javascript">
/*Transacción*/
//Al pulsar el botón cliente
	$("#id_btnUsuario").click(function (){
		$.getJSON("filtrarUsuarioSimple",{"filtro":""}, function (data){
			agregarUsuario(data);	
		});
		$("#idBuscaUsuario").modal("show");
	});

	//Al pulsar el botón producto
	$("#id_btnLibro").click(function (){
		$.getJSON("listarLibroTitulo",{"filtro":""}, function (data){
			agregarLibro(data);	
		});
		$("#idBuscaLibro").modal("show");
	});
	
	//Al escribir en la caja de texto del cliente
	$("#id_txtUsuario").keyup( function (e){
		var var_usuario = $("#id_txtUsuario").val();
		console.log(">> " + var_usuario);
		
		$.getJSON("filtrarUsuarioSimple",{"filtro":var_usuario}, function (data){
			agregarUsuario(data);	
		});
	});
	
	//Al escribir en la caja de texto del cliente
	$("#id_txtLibro").keyup( function (e){
		var var_libro = $("#id_txtLibro").val();
		console.log(">> " + var_libro);
		
		//Se añade los clientes a la tabla
		$.getJSON("listarLibroTitulo",{"filtro":var_libro}, function (data){
			agregarLibro(data);	
		});
	});
	
	//Se anula el enter
	$(document).on("keypress", "form", function(event) { 
	    return event.keyCode != 13;
	});
	
	//Al pulsar selecciona cliente
	function f_seleccione_usuario(id,nombres,apellidos){
		$("#id_usuario_id").val(id);
		$("#id_nombres").val(nombres);
		$("#id_apellidos").val(apellidos);
		$("#idBuscaUsuario").modal("hide");
	}
	
	//Al pulsar selecciona producto
	function f_seleccione_libro(id,titulo,serie,anio){
		$("#id_libro_id").val(id);
		$("#id_titulo").val(titulo);
		$("#id_serie").val(serie);
		$("#id_anio").val(anio);
		$("#idBuscaLibro").modal("hide");
	}
	function limpiar_todo(){
		$("#id_usuario_id").val("-1");
		$("#id_nombres").val("");
		$("#id_apellidos").val("");
		$("#id_libro_id").val("-1");
		$("#id_titulo").val("");
		$("#id_serie").val("");
		$("#id_anio").val("");
	}
	
	function limpiar_libro(){
		$("#id_libro_id").val("");
		$("#id_titulo").val("");
		$("#id_serie").val("");
		$("#id_anio").val("");
	}
	$("#id_btnAgregar").click(function() {
		var id = $("#id_libro_id").val();
		var idU = $("#id_usuario_id").val();
		console.log(id);
		console.log(idU);
		var yaExiste = false;
		$("#id_table_body tr").each(function() {
			if($(this).find('td:eq(0)').html() == id){
				yaExiste = true;
			}
		});
		if ( id == '-1' ){
			$("#idMensajeTexto").text("Seleccione un Libro");
			$("#idMensaje").modal("show");
		}else if (idU == '-1'){
			$("#idMensajeTexto").text("Seleccione un usuario");
			$("#idMensaje").modal("show");
		}else if (yaExiste){
			$("#idMensajeTexto").text("Ya Existe el libro que eligió");
			$("#idMensaje").modal("show");
		}else{
		
		$("#id_table_body").empty();
		
        $.ajax({
	          type: "POST",
	          url: "ingresarLibro", 
	          data: {"idLibro":id,"idUsuario":idU},
	          success: function(data){
	        	  agregarGrilla(data.datos);
	        	  mostrarMensaje(data.mensaje);
	        	  $("#id_fecDev").val(data.fecDev);
	        	  console.log(data.fecDev);
	          },
	          error: function(){
	        	  mostrarMensaje(MSG_ERROR);
	          }
	    });
		}
	});

	$("#id_btnRegistrar").click(function() {
		var id = $("#id_libro_id").val();
		var idU = $("#id_usuario_id").val();
		var fec = $("#id_fecDev").val();
		console.log(id);
		console.log(idU);
		console.log(fec);
		if ( idU === "-1" ){
			$("#idMensajeTexto").text("Seleccione un Usuario");
			$("#idMensaje").modal("show");
		}else if ( id === "-1" ){
			$("#idMensajeTexto").text("Seleccione un Libro");
			$("#idMensaje").modal("show");
		}else if ( fec === "" ){
			$("#idMensajeTexto").text("Complete campos por favor");
			$("#idMensaje").modal("show");
		}else{
		$.ajax({
	          type: "POST",
	          url: "registrarPrestamo", 
	          data: {"idLibro":id,"idUsuario":idU,"fec":fec},
	          success: function(data){
	        	  if(data.text != "-1"){
						console.log(data.text);
						$("#idMensajeTexto").html(data.text);
						$("#idMensaje").modal("show");
						$("#id_table_body").empty();
						limpiar_todo();
					}else
						swal("Error al agregar la Boleta","","error");
					return false;
				},
	          error: function(){
	        	  mostrarMensaje(MSG_ERROR);
	          }
	    });
		}
	});
	
	//Al pulsar el botón eliminar
	function f_elimina_seleccion(id){	
		$.ajax({
	          type: "POST",
	          url: "quitarLibro", 
	          data: {"idLibro":id},
	          success: function(data){
	        	  agregarGrilla(data.datos);
	          },
	          error: function(){
	        	  mostrarMensaje(MSG_ERROR);
	          }
	    });
	}
	
	//Solo numeros en caja de texto
	function validarSoloNumerosEnteros(e) { // 1
		tecla = (document.all) ? e.keyCode : e.which; // 2
		if (tecla == 8)	return true; // 3
		patron = /[0-9]/;// Solo acepta números
		te = String.fromCharCode(tecla); // 5
		return patron.test(te); // 6
	}

	function agregarGrilla(lista){
		 $('#id_table').DataTable().clear();
		 $('#id_table').DataTable().destroy();
		 $('#id_table').DataTable({
				data: lista,
				searching: true,
				ordering: true,
				processing: true,
				pageLength: 10,
				lengthChange: false,
				info:true,
				scrollY: 305,
		        scroller: {
		            loadingIndicator: true
		        },
				columns:[
					{data: "idLibro",className:'text-center'},
					{data: "titulo",className:'text-center'},
					{data: "serie",className:'text-center'},
					{data: "anio",className:'text-center'},
					{data: function(row, type, val, meta){
						return '<button type="button" class="btn btn-danger btn-sm"  onClick="f_elimina_seleccion(\'' + row.idLibro +'\');" >Eliminar</button>';
					},className:'text-center'},
				]                                     
		    });
	}
	
	function agregarUsuario(lista){
		 $('#id_table_usuario').DataTable().clear();
		 $('#id_table_usuario').DataTable().destroy();
		 $('#id_table_usuario').DataTable({
				data: lista,
				searching: false,
				ordering: true,
				processing: true,
				pageLength: 10,
				lengthChange: false,
				info:true,
				scrollY: 305,
		        scroller: {
		            loadingIndicator: true
		        },
				columns:[
					{data: "idUsuario",className:'text-center'},
					{data: "nombres",className:'text-center'},
					{data: "apellidos",className:'text-center'},
					{data: function(row, type, val, meta){
						return '<button type="button" class="btn btn-info btn-sm" onClick="f_seleccione_usuario(\'' + row.idUsuario + '\',\'' +  row.nombres   + '\',\'' +  row.apellidos  +'\')" >Seleccione</button>';
					},className:'text-center'},
				]                                     
		    });
	}
	
	function agregarLibro(lista){
		 $('#id_table_libro').DataTable().clear();
		 $('#id_table_libro').DataTable().destroy();
		 $('#id_table_libro').DataTable({
				data: lista,
				searching: false,
				ordering: true,
				processing: true,
				pageLength: 10,
				lengthChange: false,
				info:true,
				scrollY: 305,
		        scroller: {
		            loadingIndicator: true
		        },
				columns:[
					{data: "idLibro",className:'text-center'},
					{data: "titulo",className:'text-center'},
					{data: "serie",className:'text-center'},
					{data: "anio",className:'text-center'},
					{data: function(row, type, val, meta){
						return '<button type="button" class="btn btn-info btn-sm" onClick="f_seleccione_libro(\'' + row.idLibro + '\',\'' +  row.titulo   + '\',\'' +  row.serie + '\',\'' +  row.anio  +'\')" >Seleccione</button>';
					},className:'text-center'},
				]                                     
		    });
	}
	
	
	

</script>   		
</body>
</html>