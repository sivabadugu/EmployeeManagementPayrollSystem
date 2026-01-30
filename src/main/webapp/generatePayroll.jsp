<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Session check for Admin
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    if (username == null || !"Admin".equals(role)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payroll Management | Admin Panel</title>
    <style>
        body {
            font-family: system-ui, -apple-system, sans-serif;
            background: #0b0e17;
            color: #e2e8f0;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(17, 24, 39, 0.85);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        h1 {
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
        }
        form {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        label { font-weight: 600; margin-bottom: 0.3rem; }
        input {
            padding: 0.8rem;
            border-radius: 8px;
            border: 1px solid #6366f1;
            font-size: 1rem;
            flex: 1 1 200px;
        }
        button {
            padding: 1rem 2rem;
            background: #6366f1;
            color: white;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            align-self: flex-end;
        }
        button:hover { background: #818cf8; }
        .message {
            text-align: center;
            margin-bottom: 1rem;
            font-weight: 600;
        }
        .success { color: #22c55e; }
        .error { color: #ef4444; }

        /* Payroll table styling */
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 1rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            color: #fff;
            font-weight: 600;
            padding: 12px 15px;
            text-align: center;
        }
        td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
            color: #e2e8f0;
        }
        tr:nth-child(even) { background-color: rgba(255,255,255,0.05); }
        tr:hover { background-color: rgba(255,255,255,0.1); transition: 0.3s; }
        .btn-download {
            background-color: #2575fc;
            color: #fff;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn-download:hover { background-color: #6a11cb; }
    </style>
</head>
<body>

<div class="container">
    <h1>Payroll Management</h1>

    <!-- Success/Error messages -->
    <c:if test="${not empty success}">
        <div class="message success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <!-- Generate Payroll Form -->
    <form action="payroll" method="post">
        <div>
            <label>Employee ID:</label>
            <input type="number" name="empId" required>
        </div>
        <div>
            <label>Month:</label>
            <input type="text" name="month" placeholder="e.g., January 2026" required>
        </div>
        <button type="submit">Generate Payroll</button>
    </form>

    <!-- Payroll Table -->
    <h2 style="text-align:center; margin-bottom:1rem;">All Payrolls</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Emp ID</th>
            <th>Month</th>
            <th>Net Salary</th>
            <th>Generated On</th>
            <th>Actions</th>
        </tr>
        <c:choose>
            <c:when test="${not empty payrollList}">
                <c:forEach var="p" items="${payrollList}">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.empId}</td>
                        <td>${p.month}</td>
                        <td>${p.netSalary}</td>
                        <td><fmt:formatDate value="${p.generatedOn}" pattern="dd-MM-yyyy HH:mm" /></td>
                        <td>
                            <a class="btn-download" href="downloadSalarySlip?file=SalarySlip_${p.empId}_${p.month}.pdf">Download PDF</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6">No payroll records found.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </table>
</div>

</body>
</html>

