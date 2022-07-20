<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title> SignUp Staff Form </title>
    <link rel="stylesheet" href="signupAccount.css">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<sql:setDataSource
        var="ic"
        driver="org.postgresql.Driver"
        url="jdbc:postgresql://ec2-52-72-56-59.compute-1.amazonaws.com:5432/d274lnoegak379"
        user="dnzxqagexabepj"
        password="edb330e6fe55ed3bb6d1ee1eb3c1f995e6b205eb5d464bee634abc3345b2d294"/>

<sql:query dataSource="${ic}" var="oc">
    SELECT staffid,staffname from staff
</sql:query>
<div class="sidebar">
    <div class="logo-details">
        <img src="logoWhite.png">
    </div>
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
    <div class="home-content">
        <div class="contain_staff">
            <header class="main_title">PENDAFTARAN AKAUN</header>

            <form class="fstaff" method="post" >
                <div class="form first">
                    <div class="details personal">
                        <span class="title">Maklumat Peribadi</span>

                        <div class="fields">
                            <div class="input-field input-box">
                                <label class="details">Nama Penuh</label>
                                <input type="text" name="staffname"required>
                            </div>
                            <div class="input-field input-box">
                                <label class="details">Kad Pengenalan</label>
                                <input type="text" name="staffic" pattern="[0-9]{6}-[0-9]{2}-[0-9]{4}" placeholder="xxxxxx-xx-xxxx" required>
                            </div>
                            <div class="input-field">
                                <label class="details">Tarikh Lahir</label>
                                <input type="date" name="staffdateofbirth"required>
                            </div>
                            <div class="input-field input-box">
                                <label class="details">Alamat</label>
                                <input type="text" name="staffaddress"required>
                            </div>
                            <div class="input-field input-box">
                                <label class="details">Email</label>
                                <input type="email" name="staffemail"required>
                            </div>

                            <div class="input-field input-box">
                                <label class="details">Nombor Telefon</label>
                                <input type="text" name="staffphone" pattern="[0-9]{3}-[0-9]{7}" placeholder="xxx-xxxxxxx" required>
                            </div>
                            <div class="input-field">
                                <label class="details">Jawatan</label>
                                <select name="staffrole" required>
                                    <option disabled selected>Pilih Jawatan</option>
                                    <option value="Nazir">Nazir</option>
                                    <option value="Timbalan Nazir">Timbalan Nazir</option>
                                    <option value="Imam 1">Imam 1</option>
                                    <option value="Imam 2">Imam 2</option>
                                    <option value="Bilal 1">Bilal 1</option>
                                    <option value="Bilal 2">Bilal 2</option>
                                    <option value="Bendahari">Bendahari</option>
                                    <option value="Setiausaha">Setiausaha</option>
                                    <option value="Pembantu Setiausaha">Pembantu Setiausaha</option>
                                    <option value="AJK">AJK</option>
                                    <option value="Siak 1">Siak 1</option>
                                    <option value="Siak 2">Siak 2</option>
                                    <option value="Pemeriksa Kira-kira 1">Pemeriksa Kira-kira 1</option>
                                    <option value="Pemeriksa Kira-kira 2">Pemeriksa Kira-kira 2</option>
                                </select>
                            </div>
                            <div class="input-field">
                                <label class="details">Nama Penyelia</label>
                                <select class="form-control" id="supervisorid" name="supervisorid">
           							<option disabled selected>Pilih Penyelia</option>
                                    <c:forEach items="${oc.rows}" var="staff">
                                        <option value="<c:out value="${staff.staffid}"/>"><c:out value="${staff.staffname}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="details ID">
                        <span class="title">Maklumat Akaun</span>

                        <div class="fields">
                            <div class="input-field input-box">
                                <label class="details">Nombor Staf</label>
                                <input type="text" name="staffusername" required>
                            </div>

                            <div class="input-field input-box">
                                <label class="details">Kata Laluan</label>
                                <input type="password" name="staffpassword"required>
                            </div>
                        </div>

                        <input type="hidden" name="action" value="signupStaff">

                        <div class="button staff">
                            <input type="submit" value="DAFTAR" formaction="StaffServlet">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
</body>
</html>


