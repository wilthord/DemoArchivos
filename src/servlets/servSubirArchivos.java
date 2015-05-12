package servlets;

	import java.io.File;
import java.io.IOException;
	 

import java.sql.Connection;
import java.sql.SQLException;

	import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import pruebas.ConexionMySql;
	 
	@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
	                 maxFileSize=1024*1024*10,      // 10MB
	                 maxRequestSize=1024*1024*50)   // 50MB
		@WebServlet("/servSubirArchivos")
		public class servSubirArchivos extends HttpServlet {
	 
	    /**
	     * Name of the directory where uploaded files will be saved, relative to
	     * the web application directory.
	     */
	    private static final String SAVE_DIR = "uploadFiles";
	     
	    /**
	     * handles file upload
	     */
	    protected void doPost(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	        // gets absolute path of the web application
	        String appPath = request.getServletContext().getRealPath("");
	        // constructs path of the directory to save uploaded file
	        String savePath = appPath  + SAVE_DIR;
	        System.out.println(savePath);
	         
	        // creates the save directory if it does not exists
	        File fileSaveDir = new File(savePath);
	        if (!fileSaveDir.exists()) {
	            fileSaveDir.mkdirs();
	        }
	        
	        ConexionMySql miConn = new ConexionMySql();
	        Connection conn = miConn.getConexion();
	        try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
	        for (Part part : request.getParts()) {
	            String fileName = extractFileName(part);
	            if(fileName!=null && fileName.trim()!=""){
	            	System.out.println(savePath + File.separator + fileName);
	            	part.write(savePath + File.separator + fileName);
	            	miConn.insertarLog(request.getParameter("txtUsuario"), fileName, conn);
	            }
	        }
	        
	        try{   
	        	conn.close();
	        } catch (SQLException e) {
	        	// TODO Auto-generated catch block
	        	e.printStackTrace();
	        }

	        request.setAttribute("message", "Upload has been done successfully!");
	        getServletContext().getRequestDispatcher("/login.jsp").forward(
	                request, response);
	    }
	 
	    /**
	     * Extracts file name from HTTP header content-disposition
	     */
	    private String extractFileName(Part part) {
	        String contentDisp = part.getHeader("content-disposition");
	        String[] items = contentDisp.split(";");
	        for (String s : items) {
	            if (s.trim().startsWith("file")) {
	                return s.substring(s.indexOf("=") + 2, s.length()-1);
	            }
	        }
	        return "";
	    }
	}