<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="UTF-8">
    <title> Login Account Form </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   </head>
<body>
  <section class="home-section">
    <div class="home-content">
        <div class="hero">
          <div class="form-box">
          <a href="trainerlogin.jsp">login as trainer</a><br>
          <form action="ClientController" method="POST">
            Email : <input type="text" name="clientEmail"  placeholder="Email" required><br>
            Password : <input type="password" name="clientPassword" placeholder="Password" required>
            <div class="input-box button">

               <input type="hidden" name="action" value="loginclient">

              <input type="submit" name="submit" value="login">
            </div>
            <div class="login-signup">
              <span class="text">or 
                <a href="clientcreateaccount.jsp">Register Now</a>
              </span>
            </div>
          </form>
        </div>
      </div>
    </div>
  </section>
</body>
</html>

