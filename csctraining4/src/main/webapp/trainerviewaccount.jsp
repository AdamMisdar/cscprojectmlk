<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("sessionEmail")==null)
      response.sendRedirect("/csctraining3/trainerlogin.jsp");
  %>     
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title> View Staff Profile </title>
    <link rel="stylesheet" href="accountHandler.css">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if(session.getAttribute("staffid")==null)
        response.sendRedirect("index.jsp");
%>
<sql:setDataSource
        var="ic"
        driver="org.postgresql.Driver"
        url="jdbc:postgresql://ec2-52-72-56-59.compute-1.amazonaws.com:5432/d274lnoegak379"
        user="dnzxqagexabepj"
        password="edb330e6fe55ed3bb6d1ee1eb3c1f995e6b205eb5d464bee634abc3345b2d294"/>

<sql:query dataSource="${ic}" var="oc">
    <%
        int jstaffid = 0;

        if(request.getParameter("staffid")==null){
            jstaffid = (Integer) session.getAttribute("staffid");
        }
        else{
            jstaffid = Integer.parseInt(request.getParameter("staffid"));
            session.setAttribute("staffid", jstaffid);
        }
    %>
    <sql:query dataSource="${ic}" var="sv">
        <c:set var="jstaffid" value="<%=jstaffid%>"/>
        Select m.staffid AS "Supervisorid", m.staffname AS "Supervisor"
        from staff s
        join staff m
        on s.supervisorid = m.staffid
        WHERE s.staffid=?
        <sql:param value="${jstaffid}" />
    </sql:query>

    <c:set var="jstaffid" value="<%=jstaffid%>"/>
    SELECT staffid,staffname,staffic,staffdateofbirth,staffaddress,staffemail,staffphone,staffrole,staffusername,staffpassword
    from staff
    WHERE staffid=?
    <sql:param value="${jstaffid}" />
</sql:query>



<div class="sidebar">
    <div class="logo-details">
        <img src="logoWhite.png">
    </div>
    <ul class="nav-links">
        <li>
            <a class="main-menu" href="homepageStaff.jsp">
                <i class='bx bx-home'></i>
                <span class="links_name">LAMAN UTAMA</span>
            </a>
        </li>

        <li>
            <a class="main-menu" href="#">
                <i class='bx bx-box' ></i>
                <span class="links_name">RUANG</span>
            </a>
            <ul class="sub-menu">
                <li><a href="staffViewSpace.jsp">DEWAN</a></li>
                <li><a href="staffViewRoom.jsp">BILIK</a></li>
            </ul>
        </li>

        <li>
            <a class="main-menu" href="#">
                <i class='bx bx-bookmark'></i>
                <span class="links_name">TEMPAHAN</span>
            </a>
            <ul class="sub-menu">
                <li><a href="staffViewBooking.jsp">LIHAT TEMPAHAN</a></li>
                <li><a href="staffApproveBooking.jsp">SAHKAN TEMPAHAN</a></li>
            </ul>
        </li>

        <li>
            <a class="main-menu" href="staffViewAccount.jsp">
                <i class='bx bx-user'></i>
                <span class="links_name">AKAUN</span>
            </a>
        </li>
        <li class="log_out">
            <a class="main-menu" href="index.jsp">
                <i class='bx bx-log-out'></i>
                <span class="links_name">LOG KELUAR</span>
            </a>
        </li>
    </ul>
</div>
<section class="home-section">
    <nav>
        <div class="sidebar-button">
            <span class="dashboard">SURAU AR-RAHMAN BANDAR PUCHONG JAYA</span>
        </div>
        <div class="media_icons">
            <a href="https://www.facebook.com/sarpuchongjaya/"><i class="fab fa-facebook-f"></i></a>
            <a href="https://www.instagram.com/surau_ar_rahman_pchg/"><i class="fab fa-instagram"></i></a>
        </div>
    </nav>
    <c:forEach var="staff" items="${oc.rows}">
        <div class="home-content">
            <div class="container-staff">
                <div class="rightbox">
                    <form action="" method="post">
                        <div class="profile tabShow">
                            <h1>MAKLUMAT STAFF</h1>
                            <input type="hidden" name="staffid" value="${staff.staffid}">
                            <h2>NAMA PENUH</h2>
                            <p class="input">${staff.staffname}</p>
                            <h2>Kad Pengenalan</h2>
                            <p class="input">${staff.staffic}</p>
                            <h2>Tarikh Lahir</h2>
                            <p class="input">${staff.staffdateofbirth}</p>
                            <h2>Alamat</h2>
                            <p class="input">${staff.staffaddress}</p>
                            <h2>Email</h2>
                            <p class="input">${staff.staffemail}</p>
                            <h2>Nombor Telefon</h2>
                            <p class="input">${staff.staffphone}</p>
                            <h2>Jawatan</h2>
                            <p class="input">${staff.staffrole}</p>

                            <h2>Penyelia</h2>
                            <c:forEach var="staff" items="${sv.rows}">
                                <p class="input">${staff.Supervisorid} - ${staff.Supervisor}</p>
                            </c:forEach>
                            <c:forEach var="staff" items="${oc.rows}">
                                <h2>Nombor Staf</h2>
                                <p class="input">${staff.staffusername}</p>
                                <h2>Kata Laluan</h2>
                                <p class="input">${staff.staffpassword}</p>
                            </c:forEach>

                            <input type="hidden" name="action" value="deleteStaff">
                            <button class="btn update" onclick="form.action='staffUpdateAccount.jsp'">KEMASKINI</button>
                            <button class="btn cancel" formaction="StaffServlet"
                                    onclick="return confirm('Adakah anda yakin untuk padam akaun anda?');" >PADAM</button>

                        </div>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</section>
</body>
</html>


