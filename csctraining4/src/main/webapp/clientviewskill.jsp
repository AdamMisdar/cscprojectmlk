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
    <title> Client View Skill </title>
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
    SELECT *
    from skill
</sql:query>

<section class="home-section">
    <div class="home-content">
        <div class="container">
        <a href="homepageclient.jsp">homepage</a>
            <header class="main_title" style="font-size: xx-large">Skill list</header>
                <section>
                    <div>
                    <c:forEach var="skill" items="${oc.rows}">
                    <input type="hidden" name="skillID" value="${skill.skillID}">
                            <div class="text">
                                <h2>${skill.skillName}</h2>
                                <div class="content">
                                    <span>type:</span>
                                    <span>${skill.skillType}</span>
                                    <span>Description</span>
                                    <span>${skill.skillDesc}</span>
                                    <span>Price:</span>
                                    <span>${skill.skillPrice}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>        
        </div>
    </div>
</section>
</body>
</html>