<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"Admin".equals(role)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Employees | Admin View</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .container { max-width: 1200px; margin: 40px auto; padding: 20px; }

        h2 { text-align: center; color: #1e40af; margin-bottom: 30px; }

        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 15px; text-align: left; }
        th { background-color: #1e40af; color: white; }
        tr:nth-child(even) { background-color: #f8fafc; }
        tr:hover { background-color: #eff6ff; }

        .btn {
            padding: 6px 12px;
            background: linear-gradient(135deg, #00c6ff, #00ff9d);
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }

        .btn:hover { opacity: 0.9; }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            padding: 10px 24px;
            border: 2px solid #3b82f6;
            border-radius: 8px;
            transition: all 0.25s;
        }
        .back-link:hover { background: #3b82f6; color: white; }
    </style>
</head>
<body>

<div class="container">
    <h2>All Employees</h2>

    <c:choose>
        <c:when test="${not empty employees}">
            <table>
                <thead>
                    <tr>
                        <th>Emp ID</th>
                        <th>Full Name</th>
                        <th>Phone</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Base Salary</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="emp" items="${employees}">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.fullName}</td>
                            <td>${emp.phone}</td>
                            <td>${emp.department}</td>
                            <td>${emp.designation}</td>
                            <td>₹${emp.baseSalary}</td>
                            <td>
                                <form action="payroll" method="post" style="display:inline;">
                                    <input type="hidden" name="empId" value="${emp.empId}">
                                    <input type="hidden" name="month" value="<%= java.time.YearMonth.now() %>">
                                    <button type="submit" class="btn">Generate Payroll</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p style="text-align:center; margin-top:20px; color:#64748b;">No employees found in the system.</p>
        </c:otherwise>
    </c:choose>

    <div style="text-align:center;">
        <a href="adminDashboard.jsp" class="back-link">← Back to Dashboard</a>
    </div>
</div>

</body>
</html>
