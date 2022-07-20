package training.files;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet(name = "ClientController", value = "/ClientController")
public class ClientController extends HttpServlet{

    private ClientDAO dao;
    public void init() {
        dao = new ClientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.removeAttribute("clientID");
        session.invalidate();
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //try
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "signupclient":
                	signupclient(request, response);
                    break;
                case "loginclient":
                	loginclient(request, response);
                    break;
                case "deleteclient":
                	deleteclient(request, response);
                    break;
                case "updateclient":
                	updateclient(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    
    //############################# signup ###################################

    private void signupclient(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException {
    	Client client = new Client();
		
		client.setClientName(request.getParameter("clientName"));
		client.setClientPhoneno(request.getParameter("clientPhoneno"));
		client.setClientEmail(request.getParameter("clientEmail"));
		client.setClientAge(request.getParameter("clientAge"));
		client.setClientSports(request.getParameter("clientSports"));
		
		dao.signupclient(client);
        response.sendRedirect("login.jsp");
    }
    //############################## login #####################################


    private void loginclient(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String clientEmail = request.getParameter("clientEmail");
        String clientPassword = request.getParameter("clientPassword");

        try {

            Class.forName("com.mysql.jdbc.Driver"); // ni stay
            String dbURL = "jdbc:mysql://localhost/cscproject";
        	String user = "root";
        	String pass = "";
        	Connection conn = DriverManager.getConnection(dbURL, user, pass);

            String sql  ="SELECT clientID, clientName, clientEmail, clientPassword from client";

            if (conn != null){
                DatabaseMetaData dm = conn.getMetaData();
                System.out.println("Driver name: " + dm.getDriverName());
                System.out.println("Driver version: " + dm.getDriverVersion());
                System.out.println("Product Name: " + dm.getDatabaseProductName());
                System.out.println("Product version: " + dm.getDatabaseProductVersion());

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()){
                    if(clientEmail.equals(rs.getString("clientEmail")) && clientPassword.equals(rs.getString("clientPassword")))
                    {
                        Client client = new Client();

                        client.setClientID(rs.getInt(1));
                        client.setClientName(rs.getString(2));
                        client.setClientEmail(rs.getString(3));
                        client.setClientPassword(rs.getString(4));

                        session.setAttribute("clientID", client.getClientID());
                        session.setAttribute("clientName", client.getClientName());
                        session.setAttribute("clientEmail",client.getClientEmail());
                        session.setAttribute("clientPassword",client.getClientPassword());

                        response.sendRedirect("homepageclient.jsp");

                    }else{

                        out.println("User not exist");

                    }
                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //################################ update ###################################


    private void updateclient(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException {
    	HttpSession session = request.getSession();
    	Client client = new Client();
		
		client.setClientName(request.getParameter("clientName"));
		client.setClientPhoneno(request.getParameter("clientPhoneno"));
		client.setClientEmail(request.getParameter("clientEmail"));
		client.setClientAge(request.getParameter("clientAge"));
		client.setClientSports(request.getParameter("clientSports"));
		
		dao.updateclient(client);

        session.removeAttribute("client");
        session.setAttribute("client", client);
        response.sendRedirect("clientviewaccount.jsp");
    }

    //################################# delete ###############################

    private void deleteclient(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int clientID = Integer.parseInt(request.getParameter("clientID"));
        dao.deleteclient(clientID);
        response.sendRedirect("login.jsp");
    }

}

