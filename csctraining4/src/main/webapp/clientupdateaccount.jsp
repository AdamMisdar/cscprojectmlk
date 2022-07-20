<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("sessionEmail")==null)
      response.sendRedirect("/csctraining3/login.jsp");
  %> 
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title> Update Client Form </title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<sql:setDataSource
    var="ic"
    driver="org.jdbc.mysql.Driver"
    url="jdbc:mysql://localhost/cscproject" 
	user="root" 
	password=""/>

<sql:query dataSource="${ic}" var="aid">
	<% int jclientID = 0;
    
    if(request.getParameter("clientID")==null){
      jclientID = (Integer) session.getAttribute("clientID");
    }
    else{
      jclientID = Integer.parseInt(request.getParameter("clientID"));
      session.setAttribute("clientID", jclientID);
    } %>
  <c:set var="jclientID" value="<%=jclientID%>" />
  	SELECT clientID FROM client WHERE clientID=?
  <sql:param value="${jclientID}" />
</sql:query>

<section class="home-section">
  
  <c:forEach var="client" items="${aid.rows}">
    <form action="ClientController" method="post">
            <div class="profile tabShow">
              <h1>Personal Info</h1>
              <input type="hidden" name="clientID" value="${client.clientID}"/>
              <h2>name : </h2>
              <input type="text" name="clientName" class="input" value = "${client.clientName}" >
              <h2>Sports</h2>
              <input type="text" name="clientSports" class="input" value = "${client.clientSports}" >
              <h2>Email</h2>
              <input type="text" name="clientEmail" class="input" value = "${client.clientEmail}" >
              <h2>Phone no</h2>
              <input type="text" name="clientPhoneno" class="input" value = "${client.clientPhoneno}" >
              <h2>Age </h2>
              <input type="text" name="clientAge" class="input" value = "${client.clientAge}" >
              <h2>Password </h2>
              <input type="text" name="clientPassword" class="input" value = "${client.clientPassword}" >

              <input type="hidden" name="action" value="updateclient">
              <a href="clientviewaccount.jsp" ><button>Save</button></a>
              <a href="clientviewaccount.jsp"><button class="btn cancel">Cancel</button></a>
            </div>
          </form>
  </c:forEach>
</section>
</body>
</html>

