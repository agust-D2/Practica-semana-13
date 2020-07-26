<%@page import="java.sql.*"%>
<%@page import="bd.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="msapplication-tap-highlight" content="no">
  <title>Registro</title>

  <!-- Favicons-->
  <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
  <!-- Favicons-->
  <link rel="apple-touch-icon-precomposed" href="images/favicon/apple-touch-icon-152x152.png">
  <!-- For iPhone -->
  <meta name="msapplication-TileColor" content="#00bcd4">
  <meta name="msapplication-TileImage" content="images/favicon/mstile-144x144.png">
  <!-- For Windows Phone -->


  <!-- CORE CSS-->
  
  <link href="css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/style.min.css" type="text/css" rel="stylesheet" media="screen,projection">
    <!-- Custome CSS-->    
    <link href="css/custom/custom.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/layouts/page-center.css" type="text/css" rel="stylesheet" media="screen,projection">

  <!-- INCLUDED PLUGIN CSS ON THIS PAGE -->
  <link href="js/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet" media="screen,projection">
<%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idpersona;
            String s_nombre;
            String s_apellido;
            String s_dni;
            String s_usuario;
            String s_clave;
            %>  
</head>

<!-- cambiar el color del fondo -->
<body class="blue">
    
    
    
    <!-- Start Page Loading -->
    <div id="loader-wrapper">
        <div id="loader"></div>        
        <div class="loader-section section-left"></div><!-- panel para la derecha -->
        <div class="loader-section section-right"></div><!-- panel para la izquierda -->
    </div>
    <!-- End Page Loading -->

    
    
                
                
    <div id="login-page" class="row">
        <div class="col s12 z-depth-4 card-panel">
            <form method="post" action="register.jsp" class="login-form" id="form" name="f_datospersonaformulario">
                <div>
                    <div class="input-field col s12 center">
                        <p class="center login-form-text">Registrar Nueva Persona</p>
                    </div>
                </div>
                
               <%
    try {
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idpersona = request.getParameter("f_idpersona");
                
                if (s_accion != null) {
                            s_nombre = request.getParameter("f_nombre");
                            s_apellido = request.getParameter("f_apellido");
                            s_dni = request.getParameter("f_dni");
                            s_usuario = request.getParameter("f_usuario");
                            s_clave = request.getParameter("f_clave");
                            //out.println("Registrando nuevo estudiante...");
                            consulta = " insert into persona (nombre,apellido,dni,usuario,clave) "
                                    + " values ('" + s_nombre + "','" + s_apellido + "','" + s_dni + "','" + s_usuario + "','" + s_clave + "'); ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                            %>
                <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:15px;" ><a>Se ha registrado con EXITO</a></p>
                    </div>
                </div>
                            
                            <%
                            
                            
                        }
else{
%>


                <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
       <%
}
               
                                            } catch (SQLException e) {
                                                System.out.println("Error: " + e.getMessage());
                                            }
                %>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-social-person-outline prefix"></i>
                        <input name="f_nombre" id="username" type="text" required >
                        <label for="username">Nombre</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-social-person prefix"></i>
                        <input name="f_apellido" id="username" type="text" required >
                        <label for="username">Apellido</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-social-person-outline prefix"></i>
                        <input name="f_dni" id="username" type="text" required >
                        <label for="username">DNI</label>
                    </div>
                </div>   
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-social-person prefix"></i>
                        <input name="f_usuario" id="username" type="text" required >
                        <label for="username">Usuario</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-action-lock-outline prefix"></i>
                        <input name="f_clave" id="password" type="text" required>
                        <label for="password">Password</label>
                    </div>
                </div>       
                <div class="row">
                    <input class="btn waves-effect waves-light col s12" style='width:100%' type="submit" value="Registrar" name="f_registrar" />                  
                    <input type="hidden" name="f_accion" value="C" size="15" />
                </div>
                <div class="row">
                    <div class="input-field col s6 m6 l6">
                        <p class="margin medium-small"><a href="login.jsp">Iniciar Sesion</a></p>
                    </div>         
                </div>
        </form>
        </div>


    
</div>

</div>



  <!-- ================================================
    Scripts
    ================================================ -->

  <!-- jQuery Library -->
  <script type="text/javascript" src="js/plugins/jquery-1.11.2.min.js"></script>
  <!--materialize js-->
  <script type="text/javascript" src="js/materialize.min.js"></script>
  <!--scrollbar-->
  <script type="text/javascript" src="js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>

      <!--plugins.js - Some Specific JS codes for Plugin Settings-->
    <script type="text/javascript" src="js/plugins.min.js"></script>
    <!--custom-script.js - Add your own theme custom JS-->
    <script type="text/javascript" src="js/custom-script.js"></script>

</body>
</html>
