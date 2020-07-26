<%-- 
    Document   : imprimirboleta
    Created on : 26/02/2020, 01:26:42 PM
    Author     : Usuario
--%>

<%@page import="java.sql.*"%>
<%@page import="bd.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Datos Venta</title>
  <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
  <link href="css/NOIMPRIMIR.css" rel="stylesheet" type="text/css"/>

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
            String s_idventa;
            String s_total;
            String s_idcliente;
            


        %>
    </head>
    <body> 
                        <%
            try {

                //conecction de la base datos
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                cn1 = bd.getConnection();
                                    
                
                                    s_idventa = request.getParameter("f_idventa");
                                    s_accion = request.getParameter("f_accion");
                                    s_total = request.getParameter("f_total");
                                    s_idcliente = request.getParameter("f_idcliente");
                                    
                                    //en esta consulta hacemos el update en venta con los datos reales, ya que se finalizo la boleta
                                    consulta = "update venta "
                                            + "set "
                                            + "fecha=CURDATE(), "
                                            + "total='" + s_total+ "', "
                                            + "estado='A' "
                                            + "where idventa= " + s_idventa+";";
                                    //out.print(consulta);
                                    pst = cn.prepareStatement(consulta);
                                    
                                    pst.executeUpdate();             
                                 
                                 
                                 
                                 
                               %>
                    <fieldset style="margin:auto; width: 500px">           
                               
                               <%-- aqui mostramos la boleta final --%>
                               <p style="text-align: center">PRODUCTOS Y ABARROTES S.A.C.</p>
                                           
                                           <%                    
                                    
                                               //en esta consulta pedimos el numero y la fecha
                                               consulta = "select numero, CURDATE() from venta where idventa= " + s_idventa + ";";
                                               //out.print(consulta);
                                               pst = cn.prepareStatement(consulta);
                                               rs = pst.executeQuery();
                                               if (rs.next()) {

                                           %>
                                           
                                           <%-- aqui recien mostramos el numero de boleta y la fecha  --%>
                                              <p style="text-align:center"><a style="color: #90CAF9">Nro de Boleta: </a><%out.print(rs.getString(1));%> ⠀⠀ <a style="color: #90CAF9">Fecha:</a> <%out.print(rs.getString(2));%></p>
                

                                           <%}
                                               
                                               //en esta consulta pedimos los datos del cliente
                                               consulta = "select nombre, apellido, direccion, dni from cliente where idcliente= " + s_idcliente + ";";
                                               //out.print(consulta);
                                               pst = cn.prepareStatement(consulta);
                                               rs = pst.executeQuery();
                                               if (rs.next()) {

                                           %>

                                           <%-- y aqui mostramos los datos de ese cliente --%>
                                           <p style="text-align:left"><a style="color: #90CAF9">Nombre:</a> <%out.print(rs.getString(2).toUpperCase() + ", " + rs.getString(1));%></p>
                                           <p style="text-align:left"><a style="color: #90CAF9">DNI:</a> <%out.print(rs.getString(4));%></p>
                                           <p style="text-align:left"><a style="color: #90CAF9">Direccion:</a> <%out.print(rs.getString(3));%></p>
               
                                           <%
                                               }
                                           %>


                                           <%-- los titulos de la cabecera de la tabla --%>
                                    <table style="margin:auto" >
                                        <thead>
                                            <tr>
                                                <th>Nro</th>
                                                <th>Producto</th>
                                                <th>Precio</th>
                                                <th>Cantidad</th>
                                                <th>SubTotal</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                                   <%
                                               
                                                       //en esta consulta pedimos los datos necesarios de la tabla detalle_venta
                                                       consulta = "select detalle_venta.iddetalle_venta, producto.nombre, detalle_venta.precioventa, detalle_venta.cantidad from detalle_venta, producto where producto.idproducto=detalle_venta.idproducto and detalle_venta.idventa='" + s_idventa + "';";
                                                       //out.print(consulta);
                                                       pst = cn.prepareStatement(consulta);
                                                       rs = pst.executeQuery();
                                                       
                                                       //variables de apoyo para calcular el subtotal y el monto
                                                       int num = 0;
                                                       String idp;
                                                       String cantidad;
                                                       String precio;
                                                       double subtotal;
                                                       double A;
                                                       double B;
                                                       double monto = 0.00;

                                                       while (rs.next()) {
                                                           idp = rs.getString(1);
                                                           precio = rs.getString(3);
                                                           cantidad = rs.getString(4);
                                                           num++;
                                                   %>
                                                   <tr>
                                            <%-- aqui mostramos el numero de la tabla --%>
                                            <td><% out.print(num);%></td>
                                            
                                            <%-- aqui mostramos el nombre del producto --%>
                                            <td><% out.print(rs.getString(2)); %></td>
                                            
                                            <%-- aqui mostramos el precio --%>
                                            <td><% out.print(precio); %></td>
                                            
                                            <%-- aqui mostramos la cantidad --%>
                                            <td><% out.print(cantidad); %></td>
                                            
                                            <%-- aqui hacemos la operacion de como obtenemos el subtotal y el monto --%>
                                            <td><%
                                                               A = Double.parseDouble(cantidad);
                                                               B = Double.parseDouble(precio);
                                                    subtotal = A * B;
                                                    monto = monto + subtotal;

                                                    out.print(subtotal); %></td>
                                            </tr>
                                                   <%
                                                       }

                                                   %>

                                                   <tr>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            
                                            <%-- mostramos el monto --%>
                                            <td><a style="color: #90CAF9">Monto: </a><%out.print("S/" +monto+"0");%></td>
                                        </tr>
                          
                                </tbody>
                          </table>


                                            <table style="margin:auto"  id="parte1">
                                                               <tr>
                                                                   <td>⠀</td>
                                                                   <td>
                                                                       
                                            <%-- creo un formulario con el boton emitir nueva boleta que me dirige a venta.jsp --%>
                                            <form style="margin:auto" method="post" name="f_formbuscarcliente" action="Venta.jsp">
                                                <input type="submit" value="Emitir Nueva Boleta" name="f_buscarcliente" />                  
                                            </form>
                                            
                                                                   </td>
                                                                   <td>
                                                                       
                                            <%-- creo un formulario con el boton volver al menu que me dirige a menu.jsp --%>
                                            <form style="margin:auto" method="post" name="f_formbuscarcliente" action="menu.jsp">
                                                <input type="submit" value="Volver al Menu" name="f_buscarcliente" />                  
                                            </form>
                                                                   </td>
                                                           </tr>
                                                          </table>
                    </fieldset>
                                 <%  

                                                rs.close();
                                                pst.close();
                                                cn.close();
                                            } catch (SQLException e) {
                                                System.out.println("Error: " + e.getMessage());
                                            }
                                        %>
    
                
                
                
   
    </body>
</html>