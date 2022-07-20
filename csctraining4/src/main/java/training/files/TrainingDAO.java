package training.files;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import static java.lang.System.out;

public class TrainingDAO {

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

    public void createtraining(Training bean, Skill skill, Client client, Trainer trainer) throws SQLException{
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("INSERT INTO training (trainingSports, startDate, endDate, trainingVenue, playerID, skillID, trainerID) values (?,?,?,?,?,?)");)
        {
        	ps.setString(1, bean.getTrainingSports());
			ps.setDate(2, bean.getStartDate());
			ps.setDate(3, bean.getEndDate());
			ps.setString(4, bean.getTrainingVenue());
			ps.setInt(5, client.getClientID());
			ps.setInt(6, trainer.getTrainerID());
            ps.setInt(7, skill.getSkillID());
            ps  .executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updatetraining(Training bean, Client client, Skill skill, Trainer trainer) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("UPDATE staff set trainingSports=?, startDate=?, endDate=?, trainingVenue=?, playerID=?, skillID=?, trainerID=? where trainingID=?");)
        {
        	ps.setString(1, bean.getTrainingSports());
			ps.setDate(2, bean.getStartDate());
			ps.setDate(3, bean.getEndDate());
			ps.setString(4, bean.getTrainingVenue());
			ps.setInt(5, client.getClientID());
			ps.setInt(6, trainer.getTrainerID());
            ps.setInt(7, skill.getSkillID());

          rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }
    
    public boolean deletetraining(int trainingID) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("delete from training where trainingID=?");) {
            ps.setInt(1, trainingID);
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
