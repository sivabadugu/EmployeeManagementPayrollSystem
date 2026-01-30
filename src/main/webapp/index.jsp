<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payroll Login</title>

<link rel="stylesheet" href="css/index.css">

</head>
<body>
<div class="bg-shape shape1"></div>
<div class="bg-shape shape2"></div>
<div class="bg-shape shape3"></div>

<div class="container">
    
    <!-- Left Welcome Panel -->
    <div class="left-panel">
        <h1>Welcome Back!</h1>
        <h4>You can login in to access your payroll account.</h4>
    </div>

    <!-- Right Login Form -->
    <div class="right-panel">
        <h2>Login In</h2>

       <form action="${pageContext.request.contextPath}/login" method="post">
       
        
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>

            <div class="options">
                
                <a href="forgotPassword.jsp">Forgot password?</a>
            </div>

            <button type="submit">Login In</button>
        </form>
    </div>
    <% if(request.getParameter("error") != null){ %>
        <p class="error-message">Invalid Username or Password</p>
    <% } %>
</div>



</body>
</html>
