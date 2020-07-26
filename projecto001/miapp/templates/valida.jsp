<%--
    Document   : valida
    Created on : 15/01/2020, 03:02:15 PM
    Author     : lab02
--%>
<%@page import="java.sql.*" %>
<%@page import="bd.*" %>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%!
           
           
           
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
           
            String s_usuario;
            String s_clave;
            
            String s_dni;
            String resultado;
           
        %>
       
    </head>
    <body>
        <%
            s_usuario=request.getParameter("f_usuario");
            s_clave=request.getParameter("f_clave");
            s_dni=request.getParameter("f_dni");
           
           
           
            try {
                    //conecta java con mysql
                    ConectaBd bd = new ConectaBd();
                    cn = bd.getConnection();
                    
                    //valida para login.jsp
                    if(s_usuario != null){
                    consulta = "select count(*) from usuario where usuario='"+s_usuario+"' and clave='"+ s_clave+"';";
                    //out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    resultado="";
                    if(rs.next()){
                      resultado=rs.getString(1);
                    }
                  rs.close();
                    pst.close();
                    cn.close();
                  
                   
                   
                    if (resultado.equals("1")) {
                        response.sendRedirect("menu.jsp");
                    } else if(resultado.equals("0")) {
                        response.sendRedirect("login.jsp?f_error=1");
                    }
                    
                    }
                    
                    
                    //valida para ventas.jsp
                    if(s_dni != null){
                        
                    //en esta consulta hacemos un count para saber si el dni existe en nuestra base de datos ya que el dni es unique
                    consulta = "select count(*) from cliente where dni='"+s_dni+"' ;";
                    out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                    resultado="";
                    if(rs.next()){
                      resultado=rs.getString(1);
                    }
                    rs.close();
                    pst.close();
                    cn.close();
                 
                   
                    //si existe el dni entonces regresamos a venta.jsp pero con una nueva accion la de BuscarCliente
                    if (resultado.equals("1")) {
                        response.sendRedirect("Venta.jsp?f_accion=BuscarCliente&f_dni="+s_dni+" ");
                    
                    //si no existe el dni entonces regresamos a venta.jsp con s_error=1 para que ingrese nuevamente
                    } else if(resultado.equals("0")) {
                        response.sendRedirect("Venta.jsp?f_error=1");
                    }
                    }
               } catch (Exception e) {
                            System.out.println("ERROR");
                        }
                  
            %>
    </body>
</html>