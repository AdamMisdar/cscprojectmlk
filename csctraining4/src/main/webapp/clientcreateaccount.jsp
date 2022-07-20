<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <title> SignUp client Form </title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<section>
  
  <div class="home-content">
    <div class="contain_client">
      <header>Register Account</header>
      <form method="post">
          <div class="details personal">
            <span class="title">Personal Info</span>

            <div class="fields">
              <div class="input-field input-box">
                <label class="details">Name : </label>
                <input type="text" name="clientName" required>
              </div>
              <div class="input-field input-box">
                <label class="details">Age : </label>
                <input type="text" name="clientAge" pattern="[0-9]{2}" placeholder="XX" required>
              </div>
              <div class="input-field input-box">
                <label class="details">Email : </label>
                <input type="email" name="clientEmail" required>
              </div>
              <div class="input-field input-box">
                <label class="details">Phone no : </label>
                <input type="text" name="clientPhoneno" pattern="[0-9]{3}-[0-9]{7}" placeholder="xxx-xxxxxxx" required>
              </div>
            </div>
          
              <div class="input-field input-box">
                <label class="details">Password : </label>
                <input type="password" name="clientPassword" required>
              </div>
            <input type="hidden" name="action" value="signupclient">

            <div>
              <input type="submit" value="Daftar" formaction="ClientController">
            </div>
          </div>
      </form>
    </div>
  </div>
</section>
</body>
</html>


