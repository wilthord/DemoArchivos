<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		Usuario: <%=request.getParameter("txtUsuario") %>
		<br/><br/><br/>
		
	<form action="servSubirArchivos" method="post" enctype="multipart/form-data">
		
		<input type="file" name="file" /> 
		<br /> 
		<input type="submit" value="Subir archivo" />
		<input type="hidden" name="txtUsuario" value='<%=request.getParameter("txtUsuario") %>'/>
	</form>
</body>
</html>