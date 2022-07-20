package training.files;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import static java.lang.System.out;

public class TrainerDAO {
  
	String dbURL = "jdbc:mysql://localhost/cscproject";
	String user = "root";
	String pass = "";
	
  protected Connection getConnection()
  {
    Connection connection = null;
    try {
      Class.forName("org.jdbc.mysql.Driver");
      connection = DriverManager.getConnection(dbURL, user, pass);
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (ClassNotFoundException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
    return connection;
  }
  
  
  public void signuptrainer (Trainer bean) throws SQLException {
    
    // try-with-resource statement will auto close the connection.
    try (Connection connection = getConnection();
    PreparedStatement ps = connection.prepareStatement("INSERT INTO trainer (trainerName, trainerPhone, trainerEmail, trainerQualification, trainerPassword) values (?,?,?,?,?)");)
    {
    	ps.setString(1, bean.getTrainerName());
		ps.setString(2, bean.getTrainerPhone());
		ps.setString(3, bean.getTrainerEmail());
		ps.setString(4, bean.getTrainerQualification());
		ps.setString(5, bean.getTrainerPassword());

        out.println(ps);
        ps.executeUpdate();
      } catch (SQLException e) {
          printSQLException(e);
      }
    }
  
    public boolean updatetrainer(Trainer bean) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("UPDATE staff set trainerName=?, trainerPhone=?, trainerEmail=?, trainerQualification=?, trainerPassword=? where trainerID=?");)
        {
        	ps.setString(1, bean.getTrainerName());
    		ps.setString(2, bean.getTrainerPhone());
    		ps.setString(3, bean.getTrainerEmail());
    		ps.setString(4, bean.getTrainerQualification());
    		ps.setString(5, bean.getTrainerPassword());
            ps.setInt(6, bean.getTrainerID());

          rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    public boolean deletetrainer(int trainerID) throws SQLException {
            boolean rowDeleted;
            try (Connection connection = getConnection();
                 PreparedStatement ps = connection.prepareStatement("delete from trainer where trainerID=?");) {
                ps.setInt(1, trainerID);
                rowDeleted = ps.executeUpdate() > 0;
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