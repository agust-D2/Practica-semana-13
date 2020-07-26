<%-- 
    Document   : registrarventas
    Created on : 18/02/2020, 11:30:51 AM
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
                //coneccion de la base de datos
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                cn1 = bd.getConnection();
                
                s_accion = request.getParameter("f_accion");
                
                            //si ese accion es igual a VerBoleta mostramos la boleta que seleccionamos
                             if (s_accion != null && s_accion.equals("VerBoleta")) {
                                 
                                 s_idventa = request.getParameter("f_idventa");
                                 s_idcliente = request.getParameter("f_idcliente");
                                 
                               %>
                               <fieldset style="margin:auto; width: 500px">
                                            <%-- Aqui mostramos la tabla detalle_venta con todos los productos que ingresamos --%>
                                            <p style="text-align: center">PRODUCTOS Y ABARROTES S.A.C.</p>
                                           <%                    
                                 
                                               //en esta consulta pedimos el numero y la fecha actual de la tabla venta
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
                                               
                                                       //en esta consulta pedimos los datos de la tabla detalla_venta
                                                       consulta = "select detalle_venta.iddetalle_venta, producto.nombre, detalle_venta.precioventa, detalle_venta.cantidad from detalle_venta, producto where producto.idproducto=detalle_venta.idproducto and detalle_venta.idventa='" + s_idventa + "';";
                                                       //out.print(consulta);
                                                       pst = cn.prepareStatement(consulta);
                                                       rs = pst.executeQuery();
                                                       
                                                       //variables de apoyo para hallar el monto y el subtotal
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
                    </fieldset>
                                 <%
                             }     
                                    
                                    
                                    
                                    
                                    
                                    
                                    %>
  
                                    
                                    
                        <%-- aqui mostramos la tabla de todas las boletas--%>
                        
                        <fieldset id="parte1" style="margin:auto; width: 700px">
                            <p style="text-al1gn: center">Tabla Ventas</p>
                            <p style="font-size:10px; text-align: center"><a style="color: #90CAF9">listado de Boletas</a></p>
                                    
                                    
                                    <%-- aqui el encabezado de la tabla --%>
                                    <table style="margin:auto;">
                                        <thead>
                                            <tr>
                                                <th>Nro</th>
                                                <th>Fecha</th>
                                                <th>Nro De boleta</th>
                                                <th>Cliente</th>
                                                <th>DNI</th>
                                                <th>Monto</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                       <%
                             
                            //en esta consulta mostramos los datos necesarios de la tabla venta
                            consulta = "SELECT venta.idventa, venta.fecha, venta.numero, cliente.nombre, cliente.apellido, cliente.dni, venta.idcliente, venta.total from venta, cliente WHERE cliente.idcliente=venta.idcliente and venta.estado='A' ORDER by fecha ASC;";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            rs = pst.executeQuery();
                            int num = 0;
                            String idp;
                            String idc;
                            while (rs.next()) {
                                idp = rs.getString(1);
                                idc = rs.getString(7);
                                num++;

                %>
                                        <tr>
                                            <%-- aqui mostramos el numero de la tabla --%>
                                            <td><% out.print(num);%></td>
                                            
                                            <%-- aqui mostramos la fecha --%>
                                            <td><% out.print(rs.getString(2)); %></td>
                                            
                                            <%-- aqui mostramos el numero de boleta --%>
                                            <td><% out.print(rs.getString(3)); %></td>
                                            
                                            <%-- aqui mostramos el nombre del cliente --%>
                                            <td><% out.print(rs.getString(5).toUpperCase()+ ", " +rs.getString(4)); %></td>
                                            
                                            <%-- aqui mostramos el dni --%>
                                            <td><% out.print(rs.getString(6)); %></td>
                                            
                                            <%-- aqui mostramos el MONTO --%>
                                            <td><% out.print("S/"+ rs.getString(8)); %></td>
                                            
                                            <%-- aqui mostramos el boton ver boleta --%>
                                            <td><a style="color: #90CAF9" href="datosventa.jsp?f_accion=VerBoleta&f_idventa=<%out.print(idp);%>&f_idcliente=<%out.print(idc);%>">Ver Boleta</a></td>
                                        </tr>
                                        
                                            
                                            <%
                                                }
                                                rs.close();
                                                pst.close();
                                                cn.close();
                                            } catch (SQLException e) {
                                                System.out.println("Error: " + e.getMessage());
                                            }
                                        %>
                                        
                                  <tr>
                                            <td colspan="9"><a style="color: #90CAF9" href="menu.jsp" class="center">Volver</a></td>
                                        </tr> 
                                        
                                        </tbody>
                                    </table>
                        </fieldset>           

    </body>
</html>  