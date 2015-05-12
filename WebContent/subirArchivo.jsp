<%@page import="org.apache.tomcat.util.http.fileupload.FileUploadException"%>
<%@page import="org.apache.tomcat.util.http.fileupload.RequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %> 

<%
 	String ubicacionArchivo = request.getContextPath();

 DiskFileItemFactory factory = new DiskFileItemFactory();
 factory.setSizeThreshold(1024); 
 factory.setRepository(new File(ubicacionArchivo));
 System.out.println(request.getContextPath());
 ServletFileUpload upload = new ServletFileUpload(factory);

 try
 {
 List<FileItem> partes = upload.parseRequest((RequestContext)request);

 		for (FileItem item : partes) {
 			File file = new File(ubicacionArchivo, item.getName());
 			item.write(file);
 		}
 		out.write("El archivo se a subido correctamente");
 	} catch (FileUploadException ex) {
 		out.write("Error al subir archivo " + ex.getMessage());
 	}
 %>