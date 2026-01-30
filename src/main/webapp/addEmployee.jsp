<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee</title>
    <style>
    @charset "UTF-8";

    /* Page background */
    body {
        margin: 0;
        min-height: 100vh;
        font-family: Arial, Helvetica, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #6ef3d6, #3ec7e0);
        position: relative;
        padding: 20px;
        overflow: hidden;
    }

    /* Curved gradient background shapes */
    .bg-shape {
        position: absolute;
        border-radius: 50%;
        z-index: -1;
    }

    .shape1 { width: 600px; height: 600px; background: linear-gradient(135deg, #a8edea, #fed6e3); top: -150px; right: -150px; }
    .shape2 { width: 500px; height: 500px; background: linear-gradient(135deg, #84fab0, #8fd3f4); top: 50px; right: -100px; }
    .shape3 { width: 400px; height: 400px; background: linear-gradient(135deg, #a1c4fd, #c2e9fb); top: 200px; right: -50px; }

    /* Form container */
    .form-container {
        background-color: #fff;
        padding: 40px 50px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 700px;
        position: relative;
        z-index: 1;
    }

    h2 { text-align: center; margin-bottom: 30px; color: #2c3e50; }

    form { display: flex; flex-wrap: wrap; gap: 20px; }
    .form-group { flex: 1 1 45%; display: flex; flex-direction: column; }
    form label { margin-bottom: 5px; font-weight: bold; }
    form input { padding: 12px; border: 1px solid #ccc; border-radius: 8px; transition: 0.3s; }
    form input:focus { border-color: #3498db; box-shadow: 0 0 5px rgba(52, 152, 219, 0.5); outline: none; }
    button {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg, #00c6ff, #00ff9d);
        color: #fff;
        font-size: 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        margin-top: 10px;
        font-weight: bold;
    }
    button:hover { opacity: 0.9; }
    p { text-align: center; font-weight: bold; color: red; margin-bottom: 15px; }
    .success-msg { color: green; text-align: center; font-weight: bold; margin-bottom: 15px; }
    .back-link { display: block; text-align: center; margin-top: 20px; font-size: 15px; color: #3498db; text-decoration: none; }
    .back-link:hover { text-decoration: underline; }

    @media (max-width: 600px) { .form-group { flex: 1 1 100%; } }
    </style>
</head>
<body>

    <!-- Background shapes -->
    <div class="bg-shape shape1"></div>
    <div class="bg-shape shape2"></div>
    <div class="bg-shape shape3"></div>

    <!-- Form -->
    <div class="form-container">
        <h2>Add Employee</h2>

        <!-- Success Message -->
        <c:if test="${param.success != null}">
            <div class="success-msg">Employee Added Successfully!</div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <p>${error}</p>
        </c:if>

        <form action="admin" method="post">
            <input type="hidden" name="action" value="addEmployee">

            <div class="form-group">
                <label>Username:</label>
                <input type="text" name="username" required>
            </div>

            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="fullName" required>
            </div>

            <div class="form-group">
                <label>Phone:</label>
                <input type="text" name="phone" required>
            </div>

            <div class="form-group">
                <label>Department:</label>
                <input type="text" name="department" required>
            </div>

            <div class="form-group">
                <label>Designation:</label>
                <input type="text" name="designation" required>
            </div>

            <div class="form-group">
                <label>Base Salary:</label>
                <input type="number" name="baseSalary" step="0.01" required>
            </div>

            <div style="flex-basis: 100%;">
                <button type="submit">Add Employee</button>
            </div>
        </form>

        <a class="back-link" href="admin">Back to Dashboard</a>
    </div>

</body>
</html>


