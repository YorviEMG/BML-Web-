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
<div class="container" style="margin-top: 6%"><h4 style="font-size: 23pt; font-weight: 500; margin-bottom: 20px">DEVOLUCIONES</h4></div>
<div class="container">
				<div class="row" id="steps">
				<div class="panel panel-default col-md-6">
					<div class="panel-heading">Préstamo</div>
						<div class="panel-body">
							<div class="form-group">
									<label class="col-lg-12 control-label">Buscar Préstamo</label>
									<select id="id_prestamo" class='form-control' name="prestamo">
										<option value="-1">Seleccione Préstamo</option>
									</select>
							</div>
					</div>
				</div>
				<div class="panel panel-default col-md-6">
					<div class="panel-heading">Devolución</div>
						<div class="panel-body">
							<div class="form-group">
									<label class="col-lg-12 control-label">Fecha Máxima de Devolución</label>
									<input id="id_fecDev" type="date" class="form-control" readonly="readonly">
							</div>
						</div>
				</div>
			</div>
			
			
			<div class="panel panel-default" style="margin-top: 20px">
					<div class="panel-heading">Libros Prestados</div>
						<div class="panel-body">
							
							<div class="form-group">
								<div class="col-lg-12">
									<table id="id_table" class="table table-striped table-bordered">
										<thead>
											<tr>
												<th>ID</th>
												<th>Título</th>
												<th>Serie</th>
												<th>Año</th>
											</tr>
										</thead>
										<tbody id="id_table_body">
											
										</tbody>
									</table>
								</div>
							</div>
							<div class="form-group">
								<div class="col-lg-9 col-lg-offset-5">
									<button type="button" id="id_btnRegistrar"  class="btn btn-success">REALIZAR DEVOLUCIÓN</button>
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

$.getJSON("listaPrestamo", {}, function(data){
	$.each(data, function(i, item){
		$("#id_prestamo").append("<option value="+ item.prestamo.idPrestamo +">"+ "Préstamo N° "+item.prestamo.idPrestamo + "</option>");
	});
});

function limpiarTodo(){
	$("#id_prestamo").val("-1");
	$("#id_fecDev").val("");
}
$("#id_prestamo").change(function(){
	var id = $("#id_prestamo").val();
	$.ajax({
		type: "POST",
		url: "cargarDevolucion",
		data: {"idPrestamo":id},
		success: function(lista){
			console.log(lista.detalle);
			if(lista.detalle==-1){
				$("#idMensajeTexto").text("Seleccione un Préstamo");
				$("#idMensaje").modal("show");
			}else{
				$("#id_table_body").empty();
				$.each(lista.detalle, function(index, item){
					$('#id_table_body').append("<tr><td>" +item.libro.idLibro + "</td><td>" +item.libro.titulo + "</td><td>" +item.libro.serie+ "</td><td>" +item.libro.anio + "</td></tr>");
				});
				$("#id_fecDev").val(lista.fecha);
				console.log(lista.fecha);
			}
			
		}
	});
});
$("#id_btnRegistrar").click(function(){
	var id = $("#id_prestamo").val();
	$.ajax({
        type: "POST",
        url: "realizarDevolucion", 
        data: {"idPrestamo":id},
        success: function(data){
      	  if(data.text != "-1"){
					console.log(data.text);
					$("#idMensajeTexto").html(data.text);
					$("#idMensaje").modal("show");
					$("#id_table_body").empty();
					limpiarTodo();
				}else
					swal("Error al agregar la Boleta","","error");
				return false;
			},
        error: function(){
      	  mostrarMensaje(MSG_ERROR);
        }
  });
});
</script>
</body>
</html>