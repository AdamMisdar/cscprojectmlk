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
<html>
<head>
    <meta charset="UTF-8">
    <title> Staff View Booking </title>
    <link rel="stylesheet" href="bookingHandler.css">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
    <c:set var="jstaffid" value="<%=jstaffid%>"/>
    SELECT bookingid, spacename, TO_CHAR(bookingdate, 'DD-MM-YYYY')bookingdate, TO_CHAR(eventdate, 'DD-MM-YYYY')eventdate, bookingdescription, bookingstatus
    FROM booking b
    JOIN space s
    ON b.spaceid = s.spaceid
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
            <a class="main-menu" href="staffViewSpace.jsp">
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
                <li><a href="staffApproveBooking.jsp">PENGESAHAN TEMPAHAN</a></li>
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
            <a href="https://www.instagram.com.surau_ar_rahman_pchg"><i class="fab fa-instagram"></i></a>
        </div>
    </nav>
    <div class="home-content">
        <div class="table">
            <div class="table_header">
                <a href="staffCreateBooking.jsp"><button class="add">BUAT TEMPAHAN</button></a>
                <header class="main_title" style="font-size: xx-large">SENARAI TEMPAHAN</header>
            </div>
            <table class="container">
                <tr>
                    <th>NO. TEMPAHAN</th>
                    <th>NAMA RUANG</th>
                    <th>TARIKH TEMPAHAN</th>
                    <th>TARIKH AKTIVITI</th>
                    <th>PERINCIAN AKTIVITI</th>
                    <th>STATUS</th>
                    <th>BATAL TEMPAHAN</th>
                </tr>
                <c:forEach var="result" items="${oc.rows}">
                    <form action="" method="post">
                        <input type="hidden" name="bookingid" value="${result.bookingid}">
                        <tr>
                            <td>${result.bookingid}</td>
                            <td>${result.spacename}</td>
                            <td>${result.bookingdate}</td>
                            <td>${result.eventdate}</td>
                            <td>${result.bookingdescription}</td>
                            <td>${result.bookingstatus}</td>
                            <td>
                                <input type="hidden" name="action" value="staffcancelbooking">
                                <button formaction="BookingServlet" onclick="return confirm('Adakah anda yakin untuk batalkan tempahan ini?')" >Batal</button>
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