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

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>

<link rel="stylesheet" href="css/form-elements.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrapValidator.css">

<title>Intranet</title>
</head>   
<body>    


        <div class="top-content">
            <div class="inner-bg">
                <div class="container">
                <%  if (request.getAttribute("mensaje") != null) { %>
                	<div class="alert alert-danger fade in" id="success-alert">
				        <a href="#" class="close" data-dismiss="alert">&times;</a>
				        <strong><%= request.getAttribute("mensaje")  %></strong>
				    </div>
				<% } %>
				<%  if (request.getAttribute("test") != null) { %>
                	<div class="alert alert-success fade in" id="success-alert2">
				        <a href="#" class="close" data-dismiss="alert">&times;</a>
				        <strong><%= request.getAttribute("test")  %></strong>
				    </div>
				<% } %>
				<%  if (request.getParameter("msg") != null) { %>
                	<div class="alert alert-success fade in" id="success-alert2">
				        <a href="#" class="close" data-dismiss="alert">&times;</a>
				        <strong><%= request.getParameter("msg")  %></strong>
				    </div>
				<% } %>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<img alt="" src="https://themes.odilo.io/Bib-Municipal-Lima_E0907/images/logo.png">
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form id="id_form"  action="login" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Usuario</label>
			                        	<input type="text" name="login" placeholder="Ingrese Usuario" class="form-username form-control" id="form-username" maxlength="20" value="admin">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Contraseña</label>
			                        	<input type="password" name="password" placeholder="Ingrese Contraseña" class="form-password form-control" id="form-password" maxlength="20" value="admin">
			                        </div>
			                        <div class="form-group">
				                        <button type="submit" class="btn btn-primary">Ingresar</button>
				                        <a style="width: 100%; margin-top: 10px; height: 50px; padding: 15px 0" type="button" class="btn btn-warning" href="/registrarse">Registrarse</a>
			                        </div>
			                    </form>
		                    </div>
                        </div>   
                    </div>
                    
                </div>
            </div>
            
        </div>


     
<script type="text/javascript">
$("#success-alert").fadeTo(1000, 500).slideUp(500, function(){
    $("#success-alert").slideUp(500);
});

</script>


<script type="text/javascript">
$(document).ready(function() {
    $('#id_form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	dni: {
                validators: {
                    notEmpty: {
                        message: 'El usuario es obligatorio'
                    },
                    stringLength :{
                    	message: 'El usuario es de 3 a 20 caracteres',
                    	min : 3,
                    	max : 20
                    }
                }
            },
            password: {
                validators: {
                    notEmpty: {
                        message: 'La contraseña es obligatorio'
                    },
                    stringLength :{
                    	message: 'La contraseña es de 3 a 20 caracteres',
                    	min : 3,
                    	max : 20
                    }
                }
            }
        }   
    });

    $('#validateBtn').click(function() {
        $('#id_form').bootstrapValidator('validate');
    });
});
</script>

</body>
</html>