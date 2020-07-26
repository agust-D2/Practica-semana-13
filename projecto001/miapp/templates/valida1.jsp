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
           
        %>
       
    </head>
    <body>
        <%
            s_usuario=request.getParameter("f_usuario");
            s_clave=request.getParameter("f_clave");
           
           
           
            try {
                    //conecta java con mysql
                    ConectaBd bd = new ConectaBd();
                    cn = bd.getConnection();

                    consulta = "select count(*) from silverausuario where login='"+s_usuario+"' and clave='"+ s_clave+"';";
                    out.print(consulta);
                    pst = cn.prepareStatement(consulta);
                    rs = pst.executeQuery();
                     String resultado="";
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
                   
               } catch (Exception e) {
                            System.out.println("ERROR");
                        }
                  
            %>
    </body>
</html>