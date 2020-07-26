<%-- 
    Document   : emitirfactura
    Created on : 25/02/2020, 10:18:33 AM
    Author     : Usuario
--%>
<%@page import="java.sql.*"%>
<%@page import="bd.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
       
        
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Emitir Boleta</title>
  <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
  

        <%!
            //consulta
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            
            //consulta 1
            String consulta1;
            Connection cn1;
            PreparedStatement pst1;
            ResultSet rs1;
            String count;
            
            //acciones en la pagina
            String s_accion;
            String s_CRUD;
            String s_error;
            String s_agregarproducto;
            
            //tabla cliente
            String s_idcliente;
            String s_nombre;
            String s_dni;
            String s_direccion;
            String s_apellido;
            String s_estado;
            
            //tabla venta
            String s_idventa;
            String s_numero;
            
            //tabla producto
            String s_codigo;
            String s_producto;
            
            //tabla detaalle_venta
            String s_cantidad;
            String s_precioventa;
            String s_idproducto;
            String s_total;
            String s_iddetalleventa;


        %>
    </head>
    <body>
        
    <%
            try {
                
                
                s_accion = request.getParameter("f_accion");
                s_numero = request.getParameter("f_numero");
                s_CRUD = request.getParameter("f_CRUD");
                
                //coneccion de la base de datos
                ConectaBd bd = new ConectaBd();
                cn = bd.getConnection();
                cn1 = bd.getConnection();
                
                
                //Aqui verificamos si el numero de boleta que ingresamos ya existe o no
                if(s_accion != null && s_accion.equals("CrearBoleta")){
                    
                    //lo verificamos mediante un contador, si es "1" signica que existe y si es "0" significa que no existe, que puede avanzar con normalidad
                    consulta = "select count(*) from venta where numero='"+s_numero+"';";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    String resultado1="";
                    if(rs.next()){
                      resultado1=rs.getString(1);
                    }
                    
                    //En caso que sea uno:
                    if (resultado1.equals("1")) {
                        
                        //cambiamos la accion CrearBoleta por la accion BuscarCliente para volver a ingresar el numero de boleta
                        s_accion="BuscarCliente"; %>
                        
                        
                        <%-- mostramos un mensaje de error --%>
                        <p style="font-size:10px; text-align: center"><a>El numero de boleta ya existe, pruebe nuevamente</a></p>
                        
                        
                        <%
                    } 
                }
                
                
                //Aqui se realizan las acciones editar y eliminar de detalle_venta
                if (s_CRUD != null) {
                    
                                s_iddetalleventa = request.getParameter("f_iddetalleventa");
                                
                                
                                //Si crud es E, entonces elimanos el registro seleccionado
                                if (s_CRUD.equals("E")) {
                                    
                                    //aqui hacemos la consulta para eliminar
                                    consulta = " delete from detalle_venta where iddetalle_venta=" + s_iddetalleventa + " ; ";
                                    //out.print(consulta);
                                    pst = cn.prepareStatement(consulta);
                                    pst.executeUpdate();
                                
                                //Editar paso 2: Si crud es M2 entonces editamos el registros con los datos ingresados en el crud M1
                                } else if (s_CRUD.equals("M2")) {
                                    s_codigo = request.getParameter("f_codigo");
                                    s_cantidad = request.getParameter("f_cantidad");
                                    
                                    //con esta consulta pedimos el idproducto de la tabla producto gracias al nombre del codigo, hacemos esta consulta porque en la tabla detalle_venta solo existe idproducto no codigo
                                    //tambien pedimos precioventa ya que necesitamos el precio de nuevo producto
                                    consulta = "select idproducto, precioventa from producto where codigo='" + s_codigo + "';";
                                    //out.print(consulta);
                                    pst = cn.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    
                                    if (rs.next()) {
                                        //aqui guardamos los valores que pedimos en la consulta
                                        s_idproducto=rs.getString(1);
                                        s_precioventa=rs.getString(2);
                                    }
                                    
                                    //ya con los valores obtenidos podemos hacer el update en la tabla detalle_venta
                                    consulta = "update detalle_venta "
                                            + "set "
                                            + "idproducto='" + s_idproducto+ "', "
                                            + "cantidad='" + s_cantidad+ "', "
                                            + "precioventa='" + s_precioventa+ "' "
                                            + "where iddetalle_venta= " + s_iddetalleventa +";";
                                    //out.print(consulta);
                                    pst = cn.prepareStatement(consulta);
                                    pst.executeUpdate();

                                }
                }
                
                
                
                
                
                
                s_idcliente = request.getParameter("f_idcliente");
                s_dni = request.getParameter("f_dni");
                
                
                
                
                /*  ----------- ETAPA 2 -----------  */
                
                
                
                //Aqui hacemos el proceso de buscar cliente
                if (s_accion != null && s_accion.equals("BuscarCliente")) {
                    
                    //en esta consulta pedimos los datos del DNI que ingresamo en la ETAPA 1
                    consulta = "select nombre, apellido, direccion, estado, idcliente from cliente where dni= " + s_dni + ";";
                        //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    String idc;
                    String ida;
                    if (rs.next()) {
                        idc=rs.getString(5);
                        ida=rs.getString(4);
                        %>
                    
                <%-- Si el estado del cliente esta desactivado hacemos lo siguiente: --%>        
                <% if(ida.equals("D")){%>
                
                <%-- Mostramos un mensaje de error --%>    
                <p style="font-size:10px; text-align: center"><a>EL cliente no esta disponible, se encuentra inhabilitado</a></p>
                
                <%}%>
                
               
                
            <fieldset style="margin:auto; width: 300px">
            <form method="post" name="f_formbuscarcliente" action="Venta.jsp">
                
                        <p style="text-align: center">Resultado</p>
                
                
                <%-- Si el estado del cliente esta Activado mostramos la opcion de ingresar el numero de boleta: --%>    
                <% if(ida.equals("A")){%> 
                <p style="text-align:left"><a style="color: #90CAF9">Nro de Boleta:</a> <input  style="width : 150px" name="f_numero" type="text" required value=""></p>
                <% } %>
                
                
                <p style="text-align:left"><a style="color: #90CAF9">Nombre:</a> <%out.print(rs.getString(2).toUpperCase()+", "+rs.getString(1));%></p>
                <p style="text-align:left"><a style="color: #90CAF9">Direccion:</a> <%out.print(rs.getString(3));%></p>
                
                
                <%-- Si el estado del cliente esta activado cambiamos la letra A por la palabra Activado, y mostramos el boton iniciar --%>    
                <% if(ida.equals("A")){%>   
                <p style="text-align:left"><a style="color: #90CAF9">Estado:</a> Activado</p>
                <p style="margin:auto; width: 50px"><input type="submit" value="Iniciar" name="f_buscarcliente" /></p>                 
                
                <%-- cuando le damos iniciar pasamos a la accion Crear BOleta --%>    
                <input type="hidden" value="CrearBoleta" name="f_accion" />
                <input type="hidden" value="<%=idc%>" name="f_idcliente" />
                <input type="hidden" value="<%=s_dni%>" name="f_dni" />
                
                
                <%-- Si el estado del cliente esta desactivado cambiamos la letra D por la palabra desactivado y mostramos el boton volver --%>    
                <%} if(ida.equals("D")){%>   
                <p style="text-align:left"><a style="color: #90CAF9">Estado:</a> Desactivado</p>
                <p style="margin:auto; width: 50px"><input style='width:100%' type="submit" value="Volver" name="f_buscarcliente" /></p>
                
                <%}%>
                
                
            </form>
            </fieldset>
                        
                        <%
                    }
                    
                    
                } else 
                    
                    if(s_accion != null ){
                        
                        
                        
                    /*  ----------- ETAPA 3 -----------  */
                        
                        
                    //si la accion es CrearBoleta o IngresarProducto entramos a la etapa 3
                    if(s_accion.equals("CrearBoleta") || s_accion.equals("IngresarProducto")){
                            
                            //si la accion es crear boleta, creamos un regsitro fantasma en la tabla venta
                            if(s_accion.equals("CrearBoleta")){
                                
                            s_numero = request.getParameter("f_numero");
                            s_idcliente = request.getParameter("f_idcliente");
                            
                            //en esta consulta creamos el registro con datos inexistentes
                            consulta = " insert into venta (numero, fecha, total, estado, idcliente) "
                                    + " values ('" + s_numero + "', CURDATE(), '0', 'D', '"+ s_idcliente + "'); ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                            }
                            
                        
                        s_numero = request.getParameter("f_numero");
                        s_idcliente = request.getParameter("f_idcliente");
                        
                        //en esta consulta obtenemos el idventa gracias al numero de boleta que es unico, al obtener el idventa solo nos faltaria el idproducto para ingresar registros en la tabla detalle_venta
                        consulta = "select idventa from venta where numero='"+ s_numero +"' and idcliente='"+ s_idcliente +"';";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        rs = pst.executeQuery();
                        if (rs.next()) {
                                    
                                    //guardamos el idventa
                                    s_idventa = rs.getString(1);
                        }

                        
                        
                        //Editar paso 1: Aqui pedimos los datos para hacer el update
                        if(s_CRUD != null && s_CRUD.equals("M1")){
                            
                            s_iddetalleventa = request.getParameter("f_iddetalleventa");
                        
                        //en esta consulta pedimos la cantidad y el idproducto del registro que seleccionamos para editar
                        consulta = "select cantidad, idproducto from detalle_venta where iddetalle_venta= " + s_iddetalleventa + ";";
                        //out.print(consulta);
                        pst = cn.prepareStatement(consulta);
                        rs = pst.executeQuery();
                        
                        if (rs.next()) {
                            s_idproducto=rs.getString(2);
                        
                            %>
            <fieldset style="margin:auto; width: 300px" >
            <form method="post" name="f_formbuscarcliente" action="Venta.jsp">
            
                <p style="text-align: center">Editar Producto</p>
                
                <%-- mostramos el input de codigo con el valor que este tenìa --%>
                
                <p>Codigo: <input name="f_codigo" type="text" required value="<%
                            
                            //en esta consulta pedimos el codigo gracias al idproducto, queremos el codigo porque es lo que nos piden ingresar
                            consulta1 = "select codigo from producto where idproducto='" + s_idproducto + "';";
                            //out.print(consulta);
                            pst1 = cn1.prepareStatement(consulta1);
                            rs1 = pst1.executeQuery();
                            if (rs1.next()) {
                                
                                //aqui mostramos el codigo en pantalla
                                out.print(rs1.getString(1));
                                
                            }
                        
                            %>"></p>
                        
                <%-- mostramos el input de cantidad con el valor que este tenìa --%>        
                <p>Cantidad: <input name="f_cantidad" id="username1" type="text" required value="<%=rs.getString(1)%>"></p>
                        
                        
                <%-- mostramos el boton Editar --%> 
                <p style="margin: auto; width: 100px;"><input type="submit" value="Editar" name="f_buscarcliente" /></p>                  
                    
                    <%-- al darle al boton la siguiente accion sera ingresar producto --%>
                    <input type="hidden" value="IngresarProducto" name="f_accion" />
                    
                    <%-- al darle al boton pasamos a Editar paso 2 --%>
                    <input type="hidden" value="M2" name="f_CRUD" /> 
                    <input type="hidden" value="<%out.print(s_iddetalleventa);%>" name="f_iddetalleventa" /> 
                    <input type="hidden" value="<%out.print(s_idcliente);%>" name="f_idcliente" /> 
                    <input type="hidden" value="<%out.print(s_numero);%>" name="f_numero" /> 
                
            </form>
            </fieldset>
                            
                            <%
                        }}else{
                %>
            
                
                
            <%-- Aqui mostramos el formulario de ingresar producto --%>
            <fieldset style="margin:auto; width: 300px" >
            <form method="post" name="f_formbuscarcliente" action="Venta.jsp">
                
                
                <p style="text-align: center">Agregar Producto</p>
                
                <%-- mostramos el input de codigo --%>
                <p>Codigo: <input name="f_codigo" type="text" required ></p>
                
                <%-- mostramos el input de cantidad --%>
                <p>Cantidad: <input name="f_cantidad" id="username1" type="text" required ></p>
                
                <%-- mostramos el boton agregar --%>
                <p style="margin: auto; width: 100px;"><input type="submit" value="Agregar" name="f_buscarcliente" /></p>                  
                    
                    <%-- al darle al boton la siguiente accion sera ingresar producto --%>
                    <input type="hidden" value="IngresarProducto" name="f_accion" /> 
                    
                    <%-- al darle al boton agregarproducto sera SI --%>
                    <input type="hidden" value="SI" name="f_agregarproducto" /> 
                    <input type="hidden" value="<%out.print(s_idcliente);%>" name="f_idcliente" /> 
                    <input type="hidden" value="<%out.print(s_numero);%>" name="f_numero" /> 
                
            </form>
            </fieldset>
                <% }
                    
                    s_agregarproducto = request.getParameter("f_agregarproducto");
                    
                    
                    //Si agregarproducto es SI entonces hacemos un insert en la tabla detalle_venta
                    if (s_agregarproducto != null && s_agregarproducto.equals("SI")) {
                            s_codigo = request.getParameter("f_codigo");
                            s_cantidad = request.getParameter("f_cantidad");
                            
                            
                            //en esta consulta pedimos el idproducto y el precioventa gracias al codigo que ingresamos, pedimos estos datos porque son necesarios para el insert de detalle_venta
                            consulta = "select idproducto, precioventa from producto where codigo='" + s_codigo + "';";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            rs = pst.executeQuery();
                            if (rs.next()) {
                                
                                //guardamos el idproducto y el precioventa
                                s_idproducto=rs.getString(1);
                                s_precioventa=rs.getString(2);
                            }
                            
                            //en esta consulta recien hacemos el insert ya que ya tenemos todos los datos necesarios
                            consulta = " insert into detalle_venta (cantidad, precioventa, idventa, idproducto) "
                                    + " values ('" + s_cantidad + "','" + s_precioventa + "','" + s_idventa + "','" + s_idproducto + "'); ";
                            //out.print(consulta);
                            pst = cn.prepareStatement(consulta);
                            pst.executeUpdate();
                    }        

                
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
                <p style="text-align:left"><a style="color: #90CAF9">Nombre:</a> <%out.print(rs.getString(2).toUpperCase()+", "+rs.getString(1));%></p>
                <p style="text-align:left"><a style="color: #90CAF9">DNI:</a> <%out.print(rs.getString(4));%></p>
                <p style="text-align:left"><a style="color: #90CAF9">Direccion:</a> <%out.print(rs.getString(3));%></p>
               
                <%
                    }
                    %>
                
                 
                                    <%-- los titulos de la cabecera de la tabla --%>
                                    <table style="margin:auto" >
                                        <thead>
                                            <tr>
                                                <th>Num</th>
                                                <th>Producto</th>
                                                <th>Precio</th>
                                                <th>Cantidad</th>
                                                <th>SubTotal</th>
                                                <th colspan="2">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            
                                        <%
                    //en esta consulta hacemos un select con los datos necesarios para completar la tabla detalle_venta
                    consulta = "select detalle_venta.iddetalle_venta, producto.nombre, detalle_venta.precioventa, detalle_venta.cantidad from detalle_venta, producto where producto.idproducto=detalle_venta.idproducto and detalle_venta.idventa='"+ s_idventa +"';";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    
                    //aqui creamos variables de apoyo para obtener el subtotal y el monto total
                    int num = 0;
                    String idp;
                    String cantidad;
                    String precio;
                    double subtotal;
                    double A;
                    double B;
                    double monto=0.00;
                    
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
                                                A=Double.parseDouble(cantidad);
                                                B=Double.parseDouble(precio);
                                                subtotal=A*B;
                                                monto= monto + subtotal;

                                                out.print(subtotal); %></td>
                                            
                                            <%-- boton eliminar --%>
                                            <td><a style="color: #90CAF9" href="Venta.jsp?f_CRUD=E&f_accion=IngresarProducto&f_iddetalleventa=<%out.print(idp);%>&f_idcliente=<%out.print(s_idcliente);%>&f_numero=<%out.print(s_numero);%>">Eliminar</a></td>
                                           
                                            <%-- boton Editar etapa 1--%>
                                            <td><a style="color: #90CAF9" href="Venta.jsp?f_CRUD=M1&f_accion=IngresarProducto&f_iddetalleventa=<%out.print(idp);%>&f_idcliente=<%out.print(s_idcliente);%>&f_numero=<%out.print(s_numero);%>">Editar</a></td>
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
                                            <td></td>
                                            <td></td>
                                        </tr>
                          
                                </tbody>
                          </table> 
                                            
                          <%-- creamos otro formulario que nos dirige a imprimirboleta.jsp --%>
                          <form style="margin:auto; width: 100px;" method="post" name="f_formbuscarcliente" action="imprimirboleta.jsp">
                              <%-- mostramos el boton guardar --%>
                              <input type="submit" value="Guardar" name="f_buscarcliente" />                  
                              <input type="hidden" value="IngresarProducto" name="f_accion" />  
                              <input type="hidden" value="<%out.print(s_idventa);%>" name="f_idventa" /> 
                              <input type="hidden" value="<%out.print(s_idcliente);%>" name="f_idcliente" /> 
                              <input type="hidden" value="<%out.print(monto);%>" name="f_total" />      
                          </form>
        </fieldset>            
                        <%

                        }} 

else{
 
        /* -------------- ETAPA 1 ---------- */
                        
                        
                        
            s_error = request.getParameter("f_error");
            
            //si error tiene un valor nos muestra un mensaje de error donde nos dice que el dni no existe en la base de datos
            if (s_error != null) {

        %>
        
            <p style="font-size:10px; text-align: center">DNI no registrado, <a style="color: #90CAF9" href="datosclientes.jsp?f_accion=C1"> CLICK AQUI PARA REGISTRAR NUEVO CLIENTE</a></p>
               
        <%            }
        %>


        <%-- creamos un formulario que nos dirige a valida.jsp, donde valida hace la operacion de si existe o no el dni ingresado --%>
        <fieldset style="margin:auto; width: 250px">
        <form method="post" name="f_formbuscarcliente" action="valida.jsp">
                
            <p style="text-align: center ">Buscar Cliente</p>
                   
       
            <%-- mostramos el input dni --%>
            <p>DNI: <input name="f_dni" id="username" type="text" required value="" maxlength="8"></p>
            
            <%-- mostramos el boton enviar --%>
            <p style="margin:auto; width: 50px"><input type="submit" value="Enviar" name="f_buscarcliente" /></p>                  
                    
            <%-- al darle al boton la accion nueva es buscar cliente --%>
            <input type="hidden" value="BuscarCliente" name="f_accion" />
            <p style="font-size:15px;" ><a style="color: #90CAF9" href="menu.jsp">Volver</a></p>
            
        
        </form>
        </fieldset>
                <%}
                
                
   
                



                                                
                                                } catch (SQLException e) {
                                                System.out.println("Error: " + e.getMessage());
                                            }
                                        %>

    </body>
</html>  
