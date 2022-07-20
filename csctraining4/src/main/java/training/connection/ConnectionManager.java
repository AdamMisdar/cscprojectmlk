package training.connection;

import java.sql.*;

public class ConnectionManager {
	
	static Connection con;
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost/cscproject";
	private static final String DB_USER= "root";
	private static final String DB_PASSWORD = "";
	
	public static Connection getConnection() {
		
		try {
			
			Class.forName(DB_DRIVER);
			
			try{
				
				con = DriverManager.getConnection(DB_CONNECTION,DB_USER,DB_PASSWORD);
				System.out.println("Connected");
			}catch(Exception e) {
				e.printStackTrace();
			}
		}catch (ClassNotFoundException e) {
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		    }
			return con;
		}
	}