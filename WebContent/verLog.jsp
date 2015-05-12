<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pruebas.ConexionMySql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cargar Archivos</title>
<link rel="stylesheet" type="text/css" href="pro_dropdown_3/pro_dropdown_3.css" />
<script src="pro_dropdown_3/stuHover.js" type="text/javascript"></script>
</head>
<body>
	<span class="preload1"></span>
	<span class="preload2"></span>

	<ul id="nav">
		<li class="top"><a href="" id="archivos" class="top_link"><span
				class="down">Archivos&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
			<ul class="sub">
				<li><a href='cargarArchivo.jsp?txtUsuario=<%=request.getParameter("txtUsuario") %>'>Cargar</a></li>
				<li><a href='verLog.jsp?txtUsuario=<%=request.getParameter("txtUsuario") %>'>Historial</a></li>
				<li><a href='verArchivos.jsp?txtUsuario=<%=request.getParameter("txtUsuario") %>'>Archivos</a></li>
			</ul></li>
		<li class="top"><a href="login.jsp" id="services"
			class="top_link"><span>Salir</span></a></li>
	</ul>
	<br/>
	<b>Usuario:</b>&nbsp;<%=request.getParameter("txtUsuario") %>
		<br/><br/><br/>
	
	<%
			ConexionMySql util = new ConexionMySql();
			Connection con = util.getConexion();
			ArrayList<String> log = util.getLog(con);
	%>
	
	<table border="1">
		<tr>
			<td colspan="3" align="center">Historial</td>
		</tr>
		<tr>
			<td bgcolor="#3F3F3F" align="center"><b>Usuario</b></td>
			<td bgcolor="#3F3F3F" align="center"><b>Archivo</b></td>
			<td bgcolor="#3F3F3F" align="center"><b>fecha</b></td>
		</tr>
		<%
			if (log != null && log.size() > 0) {
				for (int i = 0; i < log.size()-2; i+=3) {
		%>
		<tr>
			<td><%=log.get(i)%></td>
			<td><%=log.get(i+1)%></td>
			<td><%=log.get(i+2)%></td>
		</tr>
		<%
			}
			} else {
		%>
		<tr>
			<td colspan="3">No hay registros en el historial</td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>