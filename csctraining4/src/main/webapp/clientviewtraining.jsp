<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
  <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("sessionEmail")==null)
      response.sendRedirect("/csctraining3/login.jsp");
  %>      
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title> client View training </title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%--
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setHeader("Expires", "0");
  if(session.getAttribute("clientID")==null)
    response.sendRedirect("login.jsp"); 
--%> 
<sql:setDataSource
    var="ic"
    driver="org.jdbc.mysql.Driver"
    url="jdbc:mysql://localhost/cscproject" 
	user="root" 
	password=""/>

<sql:query dataSource="${ic}" var="oc">
  <% int jclientID = 0;
    
    if(request.getParameter("clientID")==null){
      jclientID = (Integer) session.getAttribute("clientID");
    }
    else{
      jclientID = Integer.parseInt(request.getParameter("clientID"));
      session.setAttribute("clientID", jclientID);
    } %>
  <c:set var="jclientID" value="<%=jclientID%>"/>
  SELECT trainingID, trainingVenue, TO_CHAR(startDate, 'DD-MM-YYYY')Start Date, TO_CHAR(endDate, 'DD-MM-YYYY')End Date, skillName
  FROM training t
  JOIN skill s
  ON t.skillID = s.skillID
  WHERE playerID=?
  <sql:param value="${jclientID}" />
</sql:query>

<section class="home-section">
  <a href="homepageclient.jsp">homepage</a>
  <a href="clientviewskill.jsp">view skill</a>
  <a href="clientviewaccount.jsp">view account</a>
  <div class="home-content">
    <div class="table">
      <div class="table_header">
        <a href="clientcreatetraining"><button>add training session</button></a>
        <header>training list</header>
      </div>
      <table>
        <tr>
          <th>NO.</th>
          <th>training Venue</th>
          <th>Start Date</th>
          <th>End Date</th>
          <th>Skill</th>
        </tr>
        <c:forEach var="result" items="${oc.rows}">
          <form action="" method="post">
            <input type="hidden" name="bookingid" value="${result.trainingID}">
            <tr>
              <td>${result.trainingID}</td>
              <td>${result.trainingVenue}</td>
              <td>${result.starDate}</td>
              <td>${result.endDate}</td>
              <td>${result.skillName}</td>
              <td>
              	<button onclick="form.action='clientupdatetraining.jsp'">Update</button>
                <input type="hidden" name="action" value="deletetraining">
                <button formaction="TrainingController"  onclick="return confirm('Confirm to delete this training session?')">Delete</button>
              </td>
            </tr>
          </form>
        </c:forEach>
      </table>
    </div>
  </div>
</section>
</body>
</html> 