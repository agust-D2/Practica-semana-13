<%--
    Document   : menu.jsp
    Created on : 15/01/2020, 03:02:26 PM
    Author     : lab02
--%>
<%@page import="java.sql.*" %>
<%@page import="bd.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   
    <head>
        <link href="css/tabla.css" rel="stylesheet" type="text/css"/>
        
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="msapplication-tap-highlight" content="no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
        <link rel="icon" href="images/favicon/favicon-32x321.png" sizes="32x32">
        <link href="css/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection">
        <link href="css/style.min.css" type="text/css" rel="stylesheet" media="screen,projection">
        <link href="css/layouts/page-center.css" type="text/css" rel="stylesheet" media="screen,projection">
        
       
        <%!
            String consulta;
            Connection cn;
            PreparedStatement pst;
            ResultSet rs;
            
            String consulta2;
            Connection cn2;
            PreparedStatement pst2;
            ResultSet rs2;

            String consulta1;
            Connection cn1;
            PreparedStatement pst1;
            ResultSet rs1;
            
            String consulta3;
            Connection cn3;
            PreparedStatement pst3;
            ResultSet rs3;
            
            
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
    
    <%
                    //´por temas de seguridad

                    try {

                        //conecta java con mysql
                        ConectaBd bd = new ConectaBd();
                        cn = bd.getConnection();
                        cn1 = bd.getConnection();
                        cn2 = bd.getConnection();
                        cn3 = bd.getConnection();
                        %>
   
    <div id="login-page" class="row">
        <div class="col s12 z-depth-4 card-panel">
                    <div class="input-field col s12 center">
                        <p class="center login-form-text" >Tabla MENU</p>
                    </div>
                    <div class="col s12 center">
                        <p class="center" style="font-size:10px;"><a>presione un REGISTRO</a></p>
                    </div>
            
            <div class="table">

                

                
                        
                        
<%
                        consulta = "select idacceso, nombre, url from accesos where estado='A' order by orden asc";
                        //out.print(consulta);

                        pst = cn.prepareStatement(consulta);
            //para mostrar resultado
                        rs = pst.executeQuery();
                        String nombre;
                        while (rs.next()) {
                        nombre = rs.getString(1);

                %>
                <div class="rown">
                    <div class="cell" data-title="Name">
                        <%
                        if(nombre.equals("3")){
                            consulta1 = "select count(*) from cliente;";
                            pst1 = cn1.prepareStatement(consulta1);
                            rs1 = pst1.executeQuery();
                            String resultado = "";
                            
                            consulta2 = "select count(*) from producto;";
                            pst2 = cn2.prepareStatement(consulta2);
                            rs2 = pst2.executeQuery();
                            String resultado1 = "";
                            
                            if (rs1.next()) {
                                    resultado = rs1.getString(1);
                            }
                            
                            if (rs2.next()) {
                                    resultado1 = rs2.getString(1);
                            }

                            if (resultado.equals("0") || resultado1.equals("0")){
                                %>
                                <a style="color:#616161 " ><%out.println(rs.getString(2)); %></a>
                        
                                <%
                                    
                            } else { 
                                
                                

                                
                                %>
                            <a style="color:#22262e " href="<% out.println(rs.getString(3)); %>"><%out.println(rs.getString(2)); %></a>
                        
                            <%
                                    
                            }
                            
                            
                        } else{
%>
                            <a style="color:#22262e " href="<% out.println(rs.getString(3)); %>"><%out.println(rs.getString(2)); %></a>
                        
                            <%
}

                         %>   
                    </div>
                </div>
                <%
                        }
                        rs.close();
                        pst.close();
                        cn.close();
                    } catch (Exception e) {
                        System.out.println("ERROR");
                    }
                %>


                

            </div>
        </div>
    </div>
       
       

       
                   
                   
                   
                   
                   
                    <script type="text/javascript" src="js/plugins/jquery-1.11.2.min.js"></script>
                    <script type="text/javascript" src="js/materialize.min.js"></script>
                    <script type="text/javascript" src="js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
                    <script type="text/javascript" src="js/plugins.min.js"></script>
                    <script type="text/javascript" src="js/custom-script.js"></script>
    </body>
</html>

