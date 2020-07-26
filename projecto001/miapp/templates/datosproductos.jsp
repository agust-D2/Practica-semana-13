<%-- 
    Document   : datosproductos
    Created on : 18/02/2020, 10:57:15 AM
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
  <title>Datos Productos</title>
  <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
  <link rel="apple-touch-icon-precomposed" href="images/favicon/apple-touch-icon-152x152.png">
  
  
  <link href="css/legend_1.css" rel="stylesheet" type="text/css"/>
  <link href="css/separador/datosproveedores.css" rel="stylesheet" type="text/css"/>
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
            String s_idproducto;
            String s_nombre;
            String s_codigo;
            String s_stock;
            String s_precioventa;
            String s_estado;



        %>
    </head>
    <body class="blue">
        
    
        
        
    <div>⠀⠀</div>
        
    	
                        
        
                            
                            
                        
                        <%
           
               try {
                    ConectaBd bd = new ConectaBd();
                    cn = bd.getConnection();
                    cn1 = bd.getConnection();
                    s_accion = request.getParameter("f_accion");
                    s_idproducto = request.getParameter("f_idproducto");

                    if (s_accion != null && s_accion.equals("M1")) {
                        consulta = "select nombre, codigo, stock, precioventa, estado"
                                + " from producto "
                                + " where "
                                + " idproducto = " + s_idproducto;
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        rs = pst.executeQuery();
                        if (rs.next()) {


            %>

        
        <fieldset style="margin:auto" class="z-depth-4" >
            <form method="post" class="login-form" id="form" name="f_EditarDatosPersona" action="datosproductos.jsp">
                <div>
                    <div class="input-field col s12 center">
                        <p class="center login-form-text">Editar Productos</p>
                    </div>
                </div>
                
               
        <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
       
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-shopping-cart icon-2x prefix"></i>
                        <input name="f_nombre" id="username" type="text" required value="<%=rs.getString(1)%>">
                        <label for="username">Nombre</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-tag icon-2x prefix"></i>
                        <input name="f_codigo" id="username1" type="text" required value="<%=rs.getString(2)%>">
                        <label for="username1">codigo</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-truck icon-2x prefix"></i>
                        <input name="f_stock" id="username2" type="text" required value="<%=rs.getString(3)%>">
                        <label for="username2">stock</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-usd icon-2x prefix"></i>
                        <input name="f_precioventa" id="username3" type="text" required value="<%=rs.getString(4)%>">
                        <label for="username3">Precio Venta</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <select name="f_estado" required="">
                               <option value="" disabled hidden>Estado</option>
                               <option value="A" <% if(rs.getString(5).equals("A")){%>  selected <%}%> >Activo</option>
                               <option value="D" <% if(rs.getString(5).equals("D")){%>  selected <%}%> >Desactivo</option>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <input class="btn waves-effect waves-light col s12" style='width:100%' type="submit" value="Editar" name="f_editar" />                  
                    <input type="hidden" value="M2" name="f_accion" />
                    <input type="hidden" value="<%=s_idproducto%>" name="f_idproducto" />
                </div>
        
            </form>
            </fieldset>
            
        
                
                
        
        <%  }
        } else {


            s_accion = request.getParameter("f_accion");
                //out.print(s_accion);
            if (s_accion != null && s_accion.equals("C1")) {



        %>

        <fieldset style="margin:auto" class="z-depth-4" >
            <form method="post" action="datosproductos.jsp" class="login-form" id="form" name="f_datospersonaformulario">
                <div>
                    <div class="input-field col s12 center">
                        <p class="center login-form-text">Registrar Nuevo Producto</p>
                    </div>
                </div>
                
               
        <div>
                    <div class="input-field col s12 center">
                        <p class="center" style="font-size:10px;" ><a>Complete los campos</a></p>
                    </div>
                </div>
       
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-shopping-cart icon-2x prefix"></i>
                        <input name="f_nombre" id="username" type="text" required >
                        <label for="username">Nombre</label>
                    </div>
                </div>
                
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-tag icon-2x prefix"></i>
                        <input name="f_codigo" id="username1" type="text" required >
                        <label for="username1">codigo</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-truck icon-2x prefix"></i>
                        <input name="f_stock" id="username2" type="text" required >
                        <label for="username2">Stock</label>
                    </div>
                </div>
                <div class="row margin">
                    <div class="input-field col s12">
                        <i class="icon-usd icon-2x prefix"></i>
                        <input name="f_precioventa" id="username3" type="text" required >
                        <label for="username3">Precio Venta</label>
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
        
         
            
            

             
        
             <%            } 
                    }
                

            %>
<div>⠀⠀</div>
        <div>⠀⠀</div> 
                        <div>
                        
                            
                            <div id="login-page" class="row">
                                <div class="col s12 z-depth-4 card-panel">
                                    <div class="input-field col s12 center">
                                        <p class="center login-form-text" >Tabla Producto</p>
                                    </div>
                                    <div class="col s12 center">
                                        <p class="center" style="font-size:10px;"><a>listado de Producto</a></p>
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
                                                Codigo
                                            </div>
                                            <div class="cell">
                                                Stock
                                            </div>
                                            <div class="cell">
                                                Precio Venta
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
                                            consulta = " delete from producto "
                                                    + " where idproducto = " + s_idproducto + " ; ";
                                            //out.print(consulta);
                                            pst = cn.prepareStatement(consulta);
                                            pst.executeUpdate();
                                        } else if (s_accion.equals("M2")) {
                                            //out.print("Editar --> " + s_idpersona);
                                            s_nombre = request.getParameter("f_nombre");
                                            s_codigo = request.getParameter("f_codigo");
                                            s_stock = request.getParameter("f_stock");
                                            s_estado = request.getParameter("f_estado");
                                            s_precioventa = request.getParameter("f_precioventa");
                                            consulta = " update producto "
                                                    + " set "
                                                    + " nombre = '" + s_nombre + "', "
                                                    + " codigo = '" + s_codigo + "', "
                                                    + " stock = '" + s_stock + "', "
                                                    + " estado = '" + s_estado + "', "
                                                    + " precioventa = '" + s_precioventa + "' "
                                                    + " where"
                                                    + " idproducto = " + s_idproducto;
                                            //out.print(consulta);
                                            pst = cn.prepareStatement(consulta);
                                            pst.executeUpdate();
                                        } else if (s_accion.equals("C")) {
                                             s_nombre = request.getParameter("f_nombre");
                                            s_codigo = request.getParameter("f_codigo");
                                            s_stock = request.getParameter("f_stock");
                                            s_estado = request.getParameter("f_estado");
                                            s_precioventa = request.getParameter("f_precioventa");
                                            //out.println("Registrando nuevo estudiante...");
                                            consulta = " insert into producto (nombre, codigo, stock, estado, precioventa) "
                                                    + "values('" + s_nombre + "','" + s_codigo + "','" + s_stock + "','" + s_estado + "','"+ s_precioventa + "');";
                                            //out.print(consulta);
                                            pst = cn.prepareStatement(consulta);
                                            pst.executeUpdate();
                                        }
                                    }
                                    consulta = "select idproducto, nombre, codigo, stock, precioventa, estado from producto";
                                    //out.print(consulta);
                                    pst = cn.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    int num = 0;
                                    String idp;
                                    String ida;
                                    while (rs.next()) {
                                        idp = rs.getString(1);
                                        ida = rs.getString(6);
                                        num++;
                            %>


                                        <div class="rown">
                                            <div class="cell" data-title="Num">
                                                <% out.print(num);%>
                                            </div>
                                            <div class="cell" data-title="Nombre">
                                                <% out.print(rs.getString(2)); %>
                                            </div>
                                            <div class="cell" data-title="Nombre">
                                                <% out.print(rs.getString(3)); %>
                                            </div>
                                            <div class="cell" data-title="Nombre">
                                                <% out.print(rs.getString(4)); %>
                                            </div>
                                            <div class="cell" data-title="Nombre">
                                                <% out.print(rs.getString(5)); %>
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
                                                <a 
                                                <%
                                                    
                                                 consulta1 = "select count(*) from detalle_venta where idproducto='" + idp + "';";
                                            out.print(consulta1);
                                            pst1 = cn1.prepareStatement(consulta1);
                                            rs1 = pst1.executeQuery();
                                            String resultado = "";
                                            if (rs1.next()) {
                                                resultado = rs1.getString(1);
                                            }

                                            if (resultado.equals("0")) {


                                                            %>
                                                            
                                                            href="datosproductos.jsp?f_accion=E&f_idproducto=<%out.print(idp);%>"
                                                            
                                                            <%  
                                                        } 
else {
%>
style="color:#616161"
                                                            <%
    }
                                                    %>
                                            ><i class="icon-trash icon-large"></i></a>
                                            ⠀⠀
                                            <a href="datosproductos.jsp?f_accion=M1&f_idproducto=<%out.print(idp);%>" style="color:#0091ea"><i class="icon-pencil icon-large " ></i></a>
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
                                                <a href="datosproductos.jsp?f_accion=C1" class="center"><i class="icon-plus icon-large"></i></a>
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