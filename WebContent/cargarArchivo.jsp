<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pruebas.ConexionMySql"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		Usuario:<%=request.getParameter("txtUsuario") %>
		<br/><br/><br/>
		<%
			String mensaje = (String)request.getAttribute("message");
			if(mensaje!=null && mensaje.trim()!=""){
		%>
				<%=mensaje%><br/><br/><br/>
		<%
			}
		%>
		
	<form action="servSubirArchivos" method="post" enctype="multipart/form-data">
		
		<input type="file" name="file" /> 
		<br /> 
		<input type="submit" value="Subir archivo" />
		<input type="hidden" name="txtUsuario" value='<%=request.getParameter("txtUsuario") %>'/>
	</form>
	<br/><br/>
	
	<%
			ConexionMySql util = new ConexionMySql();
			ArrayList<String> listaArch = util.getListaArchivos(request);
			Connection con = util.getConexion();
			ArrayList<String> log = util.getLog(con);
	%>

	<table border="1">
		<tr>
			<td colspan="2" align="center">Lista de Archivos</td>
		</tr>
		<tr>
			<td bgcolor="#3F3F3F" align="center"><b>Nombre del Archivo</b></td>
			<td bgcolor="#3F3F3F" align="center"><b>Opciones</b></td>
		</tr>
		<%
			if (listaArch != null && listaArch.size() > 0) {
				for (int i = 0; i < listaArch.size(); i++) {
		%>
		<tr>
			<td><%=listaArch.get(i)%></td>
			<td><a href="uploadFiles/<%=listaArch.get(i)%>">Descargar</a></td>
		</tr>
		<%
			}
			} else {
		%>
		<tr>
			<td colspan="2">No se encontraron archivos</td>
		</tr>
		<%
			}
		%>
	</table>
	
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