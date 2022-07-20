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

@WebServlet(name = "SkillController", value = "/SkillController")
public class SkillController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SkillDAO dao;

    HttpSession session = null;

    public void init() {
        dao = new SkillDAO();
    }
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	HttpSession session = request.getSession();
        session.removeAttribute("trainerID");
        session.invalidate();
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "createskill":
                    createskill(request, response);
                    break;
                case "deleteskill":
                	deleteskill(request, response);
                    break;
                case "updateskill":
                    updateskill(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }


    }

    /*######################################################(CREATE SPACE)#############################################################*/

    private void createskill(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException {
        Skill skill = new Skill();
        skill.setSkillName(request.getParameter("skillName"));
        skill.setSkillDesc(request.getParameter("skillDesc"));
        skill.setSkillType(request.getParameter("skillType"));
        skill.setSkillPrice(Double.parseDouble(request.getParameter("skillName")));

        dao.createskill(skill);
        response.sendRedirect("trainerviewskill.jsp");

    }

    /*######################################################( UPDATE )#############################################################*/

    private void updateskill(HttpServletRequest request, HttpServletResponse response)throws SQLException, IOException {
        HttpSession session = request.getSession();
        Skill skill = new Skill();
        skill.setSkillName(request.getParameter("skillName"));
        skill.setSkillDesc(request.getParameter("skillDesc"));
        skill.setSkillType(request.getParameter("skillType"));
        skill.setSkillPrice(Double.parseDouble(request.getParameter("skillName")));

        dao.updateskill(skill);

        session.removeAttribute("skill");
        session.setAttribute("skill", skill);
        response.sendRedirect("trainerviewskill.jsp");


    }

    /*######################################################( DELETE )#############################################################*/

    private void deleteskill(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int skillID = Integer.parseInt(request.getParameter("skillID"));
        dao.deleteskill(skillID);
        response.sendRedirect("trainerviewskill.jsp");
    }
}