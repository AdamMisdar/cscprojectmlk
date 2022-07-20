package training.files;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import static java.lang.System.out;

public class SkillDAO{

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

    public void createskill(Skill bean) throws SQLException  {

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("INSERT INTO skills (skillName,skillType, skillDesc, skillPrice) values (?,?,?,?)");)
        {
        	ps.setString(1, bean.getSkillName());
			ps.setString(2, bean.getSkillType());
			ps.setString(3, bean.getSkillDesc());
			ps.setDouble(4, bean.getSkillPrice());

            out.println(ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public boolean updateskill(Skill bean) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("UPDATE space SET skillName=?,skillType=?, skillDesc=?, skillPrice=? where skillID=?");)
        {
            ps.setString(1, bean.getSkillName());
			ps.setString(2, bean.getSkillType());
			ps.setString(3, bean.getSkillDesc());
            ps.setInt(4, bean.getSkillID());

            rowUpdated = ps.executeUpdate() > 0;

        }
        return rowUpdated;
    }

    public boolean deleteskill(int skillID) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement("delete from skills where skillID=?");) {
            ps.setInt(1, skillID);
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
