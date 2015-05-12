package pruebas;

import java.sql.*;
import java.util.ArrayList;

public class ConexionMySql {
	
	public Connection getConexion() {
		String url = "jdbc:mysql://localhost:3306/";
		String dbName = "test";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "root";
		String password = "admin";
		try {
			Class.forName(driver).newInstance();
			Connection conn = DriverManager.getConnection(url + dbName,
					userName, password);
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void insertarLog(String usuario, String nomArchivo, Connection con){
		try {
			if(con!=null && !con.isClosed()){

				PreparedStatement ps = con.prepareStatement("INSERT INTO `logarchivos` (`usuario`, `nombreArchivo`, `fecha`) VALUES (?, ?, sysdate())");
				ps.setString(1,  usuario);
				ps.setString(2, nomArchivo);
				
				if(ps.executeUpdate()<1){
					System.out.println("No se guardó");
				}
				ps.close();

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<String> getLog(Connection con){
		ArrayList<String> lista = new ArrayList<String>();
		try {
			if(con!=null && !con.isClosed()){

				PreparedStatement ps = con.prepareStatement("SELECT * from logarchivos");
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()){
					lista.add(rs.getString(0));
					lista.add(rs.getString(1));
					lista.add(rs.getString(2));
				}
				rs.close();
				ps.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lista;
	}
}
