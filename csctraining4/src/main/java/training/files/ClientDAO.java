package training.files;
import java.sql.*;

import training.connection.ConnectionManager;

import static java.lang.System.out;
public class ClientDAO {
	
	static Connection con = null;
	static ResultSet rs = null; 
	static PreparedStatement ps=null;
	static Statement stmt=null;

    public void signupclient (Client client) throws SQLException {

        // try-with-resource statement will auto close the connection.
    	try {
    		con = ConnectionManager.getConnection();
    		
    		ps = con.prepareStatement("INSERT INTO client (clientName, clientAge, clientPhoneno, clientEmail, clientSports, clientPassword) values (?,?,?,?,?,?)");
			ps.setString(1,client.getClientName());
			ps.setString(2,client.getClientAge());
			ps.setString(3,client.getClientPhoneno());
			ps.setString(4,client.getClientEmail());
			ps.setString(5,client.getClientSports());
			ps.setString(6,client.getClientPassword());
			
			ps.executeUpdate();
			System.out.println("Successfully inserted");
			con.close();
      } catch (SQLException e) {
          printSQLException(e);
      }
    }

    public boolean updateclient(Client client) throws SQLException {
        boolean rowUpdated = false;
        try
        {
        	con = ConnectionManager.getConnection();
         
        	ps = con.prepareStatement("UPDATE client SET clientName=?, clientAge=?, clientPhoneno=?, clientEmail=?, clientSports=?, clientPassword=?  WHERE clientID=?");
        	ps.setString(1,client.getClientName());
			ps.setString(2,client.getClientAge());
			ps.setString(3,client.getClientPhoneno());
			ps.setString(4,client.getClientEmail());
			ps.setString(5,client.getClientSports());
			ps.setString(6,client.getClientPassword());
            ps.setInt(7, client.getClientID());

            rowUpdated = ps.executeUpdate() > 0;
            con.close();
        }catch(SQLException e) {
        	printSQLException(e);
        }
        return rowUpdated;
    }
    public boolean deleteclient(int clientID) throws SQLException {
        boolean rowDeleted = false;
        try{
        	con = ConnectionManager.getConnection();
        	
        	ps = con.prepareStatement("delete from client where clientID=?");
            ps.setInt(1, clientID);
            rowDeleted = ps.executeUpdate() > 0;
            con.close();
        }catch(SQLException e) {
        	printSQLException(e);
        }
        return rowDeleted;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
