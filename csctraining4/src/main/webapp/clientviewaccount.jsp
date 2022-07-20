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
    <title> View Client Profile </title>
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
  	SELECT * FROM client WHERE clientID=?
  <sql:param value="${jclientID}" />
</sql:query>

<section class="home-section">
    <c:forEach var="client" items="${aid.rows}">
        <div class="home-content">
            <div class="container">
            <a href="homepageclient.jsp">homepage</a>
                <div class="rightbox">
                    <form action="" method="post">
                    <div class="profile tabShow">
                        <h1>MAKLUMAT PEMOHON</h1>
                        <input type="hidden" name="clientID" value="${client.clientID}"/>
                        <h2>Nama : </h2>
                        <p class="input">${client.clientName}</p>
                        <h2>Sports : </h2>
                        <p class="input">${client.clientSports}</p>
                        <h2>Email</h2>
                        <p class="input">${client.clientEmail}</p>
                        <h2>Phone no : </h2>
                        <p class="input">${client.clientPhone}</p>
                        <h2>Age : </h2>
                        <p class="input">${client.clientAge}</p>
                        <h2>Password</h2>
                        <p class="input">${client.clientPassword}</p>

                        <input type="hidden" name="action" value="deleteclient">
                        <button class="btn update" onclick="form.action='clientupdateaccount.jsp'">Update</button>
                        <button class="btn cancel" formaction="ClientController" 
                        onclick="return confirm('Are you sure you want to delete your account?');">Delete</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</section>

</body>
</html>


