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
<html lang="en" dir="ltr">
<head>
<meta charset="UTF-8">
<title>Create Booking Form</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if(session.getAttribute("clientID")==null)
    response.sendRedirect("login.jsp");
%>

<sql:setDataSource var="ic" 
	driver="org.jdbc.mysql.Driver"
	url="jdbc:mysql://localhost/cscproject" 
	user="root" 
	password="" />

<sql:query dataSource="${ic}" var="oc">
  SELECT *
  FROM skill
</sql:query>

<sql:query dataSource="${ic}" var="ov">
  SELECT *
  FROM trainer
</sql:query>

<sql:query dataSource="${ic}" var="aid">
		<%
    int jclientID = 0;
    
    if(request.getParameter("clientID")==null){
      jclientID = (Integer) session.getAttribute("clientID");
    }
    else{
      jclientID = Integer.parseInt(request.getParameter("clientID"));
      session.setAttribute("clientID", jclientID);
    }
  %>
  <c:set var="jclientID" value="<%=jclientID%>" />
  	SELECT clientID FROM client WHERE clientID=?
  <sql:param value="${jclientID}" />
</sql:query>

	<section class="home-section">
		<div class="home-content">
			<div class="container">
				<div class="title">book training session</div>
				<div class="content">
					<form method="post">
						<div class="user-details">
							<div class="input-box">
								<span class="details">Training Sports</span>
								<input type="text" name="trainingSports">
							</div>
							<div class="input-box">
								<span class="details">Start Date</span> 
								<input type="date" name="startDate">
							</div>
							<div class="input-box">
								<span class="details">End Date</span> 
								<input type="date" name="endDate">
							</div>
							<div class="input-box">
								<span class="details">Training Venue</span>
								<select name="trainingVenue">
									<option>Petaling Jaya</option>
									<option>Cyberjaya</option>
								</select>
							</div>
							<div class="input-box">
								<span class="details">Skill : </span> 
								<select name="skillID">
									<c:forEach items="${oc.rows}" var="skill">
										<option value="<c:out value="${skill.SkillID}"/>"><c:out value="${skill.skillName}" /></option>
									</c:forEach>
								</select>
							</div>
							<div class="input-box">
								<span class="details">Trainer : </span> 
								<select name="skillID">
									<c:forEach items="${ov.rows}" var="trainer">
										<option value="<c:out value="${trainer.trainerID}"/>"><c:out value="${trainer.trainerID}"/></option>
									</c:forEach>
								</select>
							</div>
						</div>
						<c:forEach items="${aid.rows}" var="client">
							<input type="hidden" name="clientID"
								value="${client.clientID}"/>
						</c:forEach>
						<input type="hidden" name="action" value="createtraining">
						<div>
							<input type="submit" value="Book" formaction="TrainingController">
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</body>
</html>


