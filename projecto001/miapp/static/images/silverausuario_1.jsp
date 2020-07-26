<%-- 
    Document   : DatosUsuario
    Created on : 05/02/2020, 10:22:08 AM
    Author     : Usuario
--%>

<%@page import="java.sql.*"%>
<%@page import="bd.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="msapplication-tap-highlight" content="no">
  <title>Datos Usuario</title>
  <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
  <link rel="apple-touch-icon-precomposed" href="images/favicon/apple-touch-icon-152x152.png">
  
  
  <link href="css/legend_1.css" rel="stylesheet" type="text/css"/>
  <link href="css/separador/datosusuarios.css" rel="stylesheet" type="text/css"/>
  <link href="css/tabla1.css" rel="stylesheet" type="text/css"/>
  <link href="css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/style.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/custom/custom.min.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="css/layouts/page-center.css" type="text/css" rel="stylesheet" media="screen,projection">
  <link href="js/plugins/perfect-scrollbar/perfect-scrollbar.css" type="text/css" rel="stylesheet" media="screen,projection">


        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            String s_accion;
            String s_idusuario;
            String s_usuario;
            String s_clave;

        %>
    </head>
    <body class="blue">
        
        <!-- Start Page Loading -->
    <div id="loader-wrapper">
        <div id="loader"></div>        
        <div class="loader-section section-left"></div><!-- panel para la derecha -->
        <div class="loader-section section-right"></div><!-- panel para la izquierda -->
    </div>
    <!-- End Page Loading -->
        
        
        
        
    <div id="contenedor">	
                        
        
                            
                            
                        
                        <%
            try {
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idusuario = request.getParameter("f_idusuario");
                
                           

                if (s_accion != null && s_accion.equals("M1")) {
                    consulta = "select login, clave "
                            + " from silverausuario "
                            + " where "
                            + " idusuario = " + s_idusuario;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {

        %>
       <fieldset style="margin:auto" class="z-depth-4" >
    
           <form method="post" class="login-form" id="form" name="f_EditarDatosPersona" action="silverausuario.jsp">
                <div>
                    <div class="input-field col s12 center">
                        <p class="center login-form-text">Editar Usuario</p>
                    </div>
                </div>
                
               
        <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
       
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-social-person-outline prefix"></i>
                        <input name="f_usuario" id="username" type="text" required value="<%=rs.getString(1)%>">
                        <label for="username">Usuario</label>
                    </div>
                </div>
                
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-action-lock-outline prefix"></i>
                        <input name="f_clave" id="password" type="text" required value="<%=rs.getString(2)%>">
                        <label for="password">Password</label>
                    </div>
                </div>
                <div class="row">
                    <input class="btn waves-effect waves-light col s12" style='width:100%' type="submit" value="Editar" name="f_editar" />                  
                    <input type="hidden" value="M2" name="f_accion" />
                    <input type="hidden" value="<%=s_idusuario%>" name="f_idusuario" />
                </div>
        
            </form>
           
            </fieldset>
       
       
        
                
                        
        
        <%  }
        } else {
                    
                    
                    if (s_accion != null && s_accion.equals("R")) {
%>



<fieldset style="margin:auto" class="z-depth-4" >
    <legend><div class="col s12 login-form-text" style="color:white">Registrar Nuevo Usuario</div></legend>
                
                <form method="post" action="silverausuario.jsp" class="login-form" id="form" name="f_datospersonaformulario">
                    <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="mdi-social-person-outline prefix"></i>
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
                 </form>
            </fieldset>

<%

} else{



                            
                                %>
                
                <form style="margin:auto" method="post" action="silverausuario.jsp" class="login-form" id="form" name="f_datospersonaformulario">
                          
                <div class="row">
                    <input class="btn waves-effect waves-light col s12" style='width:100%' type="submit" value="INGRESAR NUEVO REGISTRO" name="f_registrar" />                  
                    <input type="hidden" name="f_accion" value="R" size="15" />
                </div>
                 </form>
                                
                                
                
                               
       
        

        
        

        <%          }  }
        %>
                        
                        
                        
        <div>⠀⠀</div>
                        <div>
                        
                            
                            <div id="login-page" class="row">
                                <div class="col s12 z-depth-4 card-panel">
                                    <div class="input-field col s12 center">
                                        <p class="center login-form-text" >Tabla Usuario</p>
                                    </div>
                                    <div class="col s12 center">
                                        <p class="center" style="font-size:10px;"><a>listado de USUARIOS</a></p>
                                    </div>

                                    <div class="table">
                                        <div class="rown header">
                                            <div class="cell">
                                                Num
                                            </div>
                                            <div class="cell">
                                                Usuario
                                            </div>
                                            <div class="cell">
                                                Clave
                                            </div>
                                            <div class="cell">
                                                Acciones
                                            </div>
                                            
                                        </div>

                                        <%
                    //out.print("Accion: " + s_accion + "-----");
                    if (s_accion != null) {
                        if (s_accion.equals("E")) {
                            consulta = " delete from silverausuario "
                                    + " where idusuario = " + s_idusuario + " ; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                        } else if (s_accion.equals("M2")) {
                            //out.print("Editar --> " + s_idpersona);
                            s_usuario = request.getParameter("f_usuario");
                            s_clave = request.getParameter("f_clave");
                            consulta = " update silverausuario "
                                    + " set "
                                    + " login = '" + s_usuario + "', "
                                    + " clave = '" + s_clave + "' "
                                    + " where"
                                    + " idusuario = " + s_idusuario;
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                        } else if (s_accion.equals("C")) {
                            s_usuario = request.getParameter("f_usuario");
                            s_clave = request.getParameter("f_clave");
                            //out.println("Registrando nuevo estudiante...");
                            consulta = " insert into silverausuario (login,clave) "
                                    + " values ('" + s_usuario + "','" + s_clave + "'); ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                        }
                    }
                    consulta = "select idusuario, login, clave from silverausuario";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    int num = 0;
                    String idp;
                    while (rs.next()) {
                        idp = rs.getString(1);
                        num++;
                %>
                                        <div class="rown">
                                            <div class="cell" data-title="Num">
                                                <% out.print(num);%>
                                            </div>
                                            <div class="cell" data-title="Nombre">
                                                <% out.print(rs.getString(2)); %>
                                            </div>
                                            <div class="cell" data-title="Apellido">
                                                <% out.print(rs.getString(3)); %>
                                            </div>
                                            <div class="cell" data-title="Eliminar">
                                                <a href="silverausuario.jsp?f_accion=E&f_idusuario=<%out.print(idp);%>"><i class="icon-trash icon-large"></i></a>
                                            ⠀⠀
                                                <a href="silverausuario.jsp?f_accion=M1&f_idusuario=<%out.print(idp);%>" style="color:#0091ea"><i class="icon-pencil icon-large " ></i></a>
                                            </div>
                                        </div>
                                        <%
                                                }
                                                rs.close();
                                                pst.close();
                                                cn.close();
                                            } catch (SQLException e) {
                                                System.out.println("Error: " + e.getMessage());
                                            }
                                        %>

                                        <div class="rown">
                                            <div class="cell">
                                                <a href="silveramenu.jsp" class="center">Volver</a>
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
    </div>	
    
                
                
                
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