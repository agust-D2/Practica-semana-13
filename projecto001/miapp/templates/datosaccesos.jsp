<%-- 
    Document   : datosaccesos
    Created on : 18/02/2020, 07:34:17 PM
    Author     : USUARIO
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
  <title>Datos Accesos</title>
  <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
  <link rel="apple-touch-icon-precomposed" href="images/favicon/apple-touch-icon-152x152.png">
  
  <link href="css/legend_1.css" rel="stylesheet" type="text/css"/>
  <link href="css/separador/separadoracceso.css" rel="stylesheet" type="text/css"/>
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
            
            String consulta1;
            Connection cn1;
            PreparedStatement pst1;
            ResultSet rs1;
            
            String s_accion;
            String s_idacceso;
            String s_nombre;
            String s_url;
            String s_orden;
            String s_estado;

        %>
    </head>
    <body class="blue">
        
      
        
        
        
        	
                        
        
                            
                            
                        
                        <%
            try {
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                s_accion = request.getParameter("f_accion");
                s_idacceso = request.getParameter("f_idacceso");

                if (s_accion != null && s_accion.equals("M1")) {
                    consulta = "select nombre, orden, url, estado"
                            + " from accesos "
                            + " where "
                            + " idacceso = " + s_idacceso;
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    if (rs.next()) {

        %>
        
            <div>⠀⠀</div>
        <fieldset style="margin:auto" class="z-depth-4" >
    <form method="post" class="login-form" id="form" name="f_EditarDatosPersona" action="datosaccesos.jsp">
                <div>
                    <div class="input-field col s12 center">
                        <p class="center login-form-text">Editar Acceso</p>
                    </div>
                </div>
                
               
        <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
       
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-table icon-2x prefix"></i>
                        <input name="f_nombre" id="username" type="text" required value="<%=rs.getString(1)%>">
                        <label for="username">Nombre</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-list-ol icon-2x prefix"></i>
                        <input name="f_orden" id="username1" type="text" required value="<%=rs.getString(2)%>">
                        <label for="username1">orden</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-paste icon-2x prefix "></i>
                        <input name="f_url" id="username2" type="text" required value="<%=rs.getString(3)%>">
                        <label for="username2">url</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <select name="f_estado" required="">
                               <option value="" disabled hidden>Estado</option>
                               <option value="A" <% if(rs.getString(4).equals("A")){%>  selected <%}%> >Activo</option>
                               <option value="D" <% if(rs.getString(4).equals("D")){%>  selected <%}%> >Desactivo</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <input class="btn waves-effect waves-light col s12" style='width:100%' type="submit" value="Editar" name="f_editar" />                  
                    <input type="hidden" value="M2" name="f_accion" />
                    <input type="hidden" value="<%=s_idacceso%>" name="f_idacceso" />
                </div>
        
            </form>
            </fieldset>
        
        
                
        
        <%  }
        } else {
             s_accion = request.getParameter("f_accion");
                //out.print(s_accion);
                if (s_accion != null && s_accion.equals("C1")) {
        %>
<div>⠀⠀</div>
<div>⠀⠀</div>
       <fieldset style="margin:auto" class="z-depth-4" >
    <form method="post" action="datosaccesos.jsp" class="login-form" id="form" name="f_datospersonaformulario">
                <div>
                    <div class="input-field col s12 center">
                        <p class="center login-form-text">Registrar Nuevo Acceso</p>
                    </div>
                </div>
                
               
        <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
       
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-table icon-2x prefix"></i>
                        <input name="f_nombre" id="username" type="text" required >
                        <label for="username">Nombre</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-list-ol icon-2x prefix"></i>
                        <input name="f_orden" id="username1" type="text" required >
                        <label for="username1">Orden</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-paste icon-2x prefix  "></i>
                        <input name="f_url" id="username2" type="text" required >
                        <label for="username2">URL</label>
                    </div>
                </div>   
                <div class="row margin">
                    <div class="input-field col s12">
                        <select name="f_estado" required="">
                               <option value="" disabled hidden selected>Estado</option>
                               <option value="A">Activo</option>
                               <option value="D">Desactivo</option>
                        </select>
                    </div>
                </div>   
                <div class="row">
                    <input class="btn waves-effect waves-light col s12" style='width:100%' type="submit" value="Registrar" name="f_registrar" />                  
                    <input type="hidden" name="f_accion" value="C" size="15" />
                </div>
        
        </form>
            </fieldset>
            
         
            
           

        <%            }}
        %>
                        
                        
                        
                        <div>⠀⠀</div>
                        <div>
                        
                            
                            <div id="login-page" class="row">
                                <div class="col s12 z-depth-4 card-panel">
                                    <div class="input-field col s12 center">
                                        <p class="center login-form-text" >Tabla Accesos</p>
                                    </div>
                                    <div class="col s12 center">
                                        <p class="center" style="font-size:10px;"><a>listado de ACCESOS</a></p>
                                    </div>

                                    <div class="table">
                                        <div class="rown header">
                                            <div class="cell">
                                                Num
                                            </div>
                                            <div class="cell">
                                                Nombre
                                            </div>
                                            <div class="cell">
                                                Orden
                                            </div>
                                            <div class="cell">
                                                URL
                                            </div>
                                            <div class="cell">
                                                Estado
                                            </div>
                                            <div class="cell">
                                                Acciones
                                            </div>
                                        </div>

                                        <%
                    //out.print("Accion: " + s_accion + "-----");
                    if (s_accion != null) {
                        if (s_accion.equals("E")) {
                            consulta = " delete from accesos "
                                    + " where idacceso = " + s_idacceso + " ; ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                        } else if (s_accion.equals("M2")) {
                            //out.print("Editar --> " + s_idpersona);
                            s_nombre = request.getParameter("f_nombre");
                            s_orden = request.getParameter("f_orden");
                            s_url = request.getParameter("f_url");
                            s_estado = request.getParameter("f_estado");
                            consulta = " update accesos "
                                    + " set "
                                    + " nombre = '" + s_nombre + "', "
                                    + " orden = '" + s_orden + "', "
                                    + " estado = '" + s_estado + "', "
                                    + " url = '" + s_url + "' "
                                    + " where"
                                    + " idacceso = " + s_idacceso;
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                        } else if (s_accion.equals("C")) {
                            s_nombre = request.getParameter("f_nombre");
                            s_orden = request.getParameter("f_orden");
                            s_url = request.getParameter("f_url");
                            s_estado = request.getParameter("f_estado");
                            //out.println("Registrando nuevo estudiante...");
                            consulta = " insert into accesos (nombre,orden,url,estado) "
                                    + " values ('" + s_nombre + "','" + s_orden + "','" + s_url + "','" + s_estado + "'); ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                        }
                    }
                    consulta = "select idacceso, nombre, orden, url, estado from accesos order by orden asc";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    int num = 0;
                    String idp;
                    String ida;
                    while (rs.next()) {
                        idp = rs.getString(1);
                        ida = rs.getString(5);
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
                                            <div class="cell" data-title="DNI">
                                                <% out.print(rs.getString(4)); %>
                                            </div>
                                            <div class="cell" data-title="DNI">
                                                <% 
                                                
                                                 if (ida.equals("A")) {
                                                     
                            out.print("Activo");
                        } else{
                                            out.print("Desactivo");         
                                                 }
                                                
                                                %>
                                            </div>
                                            <div class="cell" data-title="Eliminar">
                                                <a href="datosaccesos.jsp?f_accion=E&f_idacceso=<%out.print(idp);%>"><i class="icon-trash icon-large"></i></a>
                                            ⠀⠀
                                                <a href="datosaccesos.jsp?f_accion=M1&f_idacceso=<%out.print(idp);%>" style="color:#0091ea"><i class="icon-pencil icon-large " ></i></a>
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
                                                <a href="datosaccesos.jsp?f_accion=C1" class="center"><i class="icon-plus icon-large"></i></a>
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                        </div>
                                        
                                        <div class="rown">
                                            <div class="cell">
                                                <a href="menu.jsp" class="center"><i class="icon-arrow-left icon-large"></i></a>
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
                                            </div>
                                            <div class="cell">
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
