package training.files;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "TrainingController", value = "/TrainingController")
public class TrainingController extends HttpServlet {
    //private static final long serialVersionUID = 1L;
    private TrainingDAO dao;
    public void init() {
        dao = new TrainingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");

        String action = request.getParameter("action");
        try {
            switch (action) {
                case "createtraining":
                	createtraining(request, response);
                    break;
                case "updatetraining":
                	updatetraining(request, response);
                    break;
                case "deletetraining":
                	deletetraining(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //############################# createtraining #######################################*/
    private void createtraining(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException {
        //HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try{
            Training training = new Training();
            Client client = new Client();
            Trainer trainer = new Trainer();
            Skill skill = new Skill();

            training.setTrainingSports(request.getParameter("trainingSports"));
            training.setStartDate(Date.valueOf(request.getParameter("startDate")));
            training.setEndDate(Date.valueOf(request.getParameter("endDate")));
            training.setTrainingSports(request.getParameter("trainingSports"));
            client.setClientID(Integer.parseInt(request.getParameter("clientID")));
            trainer.setTrainerID(Integer.parseInt(request.getParameter("trainerID")));
            skill.setSkillID(Integer.parseInt(request.getParameter("skillID")));

            dao.createtraining(training, skill , client, trainer);
        } catch (Exception e) {
            e.printStackTrace();
        }
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Training successfully created!');");
        out.println("location='clientviewtraining.jsp';");
        out.println("</script>");
    }
      
    //######################## updatetraining ############################
    
    private void updatetraining(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

            Training training = new Training();
            Client client = new Client();
            Trainer trainer = new Trainer();
            Skill skill = new Skill();

            training.setTrainingSports(request.getParameter("trainingSports"));
            training.setStartDate(Date.valueOf(request.getParameter("startDate")));
            training.setEndDate(Date.valueOf(request.getParameter("endDate")));
            training.setTrainingSports(request.getParameter("trainingSports"));
            client.setClientID(Integer.parseInt(request.getParameter("clientID")));
            trainer.setTrainerID(Integer.parseInt(request.getParameter("trainerID")));
            skill.setSkillID(Integer.parseInt(request.getParameter("skillID")));

            dao.createtraining(training, skill , client, trainer);
        
        session.removeAttribute("training");
        session.setAttribute("training", training);
        response.sendRedirect("clientviewtraining.jsp");
    }
    
    //######################## deletetraining #############################
    private void deletetraining(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int trainingID = Integer.parseInt(request.getParameter("trainingID"));
        dao.deletetraining(trainingID);
        response.sendRedirect("clientViewTraining.jsp");
    }

    
}