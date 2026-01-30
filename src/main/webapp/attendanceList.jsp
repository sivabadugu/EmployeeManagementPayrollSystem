<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
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
    <title>Attendance Records | Admin Panel</title>

    <style>
        :root {
            --bg: #0b0e17;
            --surface: #111827;
            --card: rgba(17, 24, 39, 0.75);
            --border: rgba(99, 102, 241, 0.18);
            --primary: #6366f1;
            --accent: #818cf8;
            --text: #e2e8f0;
            --text-muted: #9ca3af;
            --error: #f87171;
            --success: #10b981;
            --radius: 14px;
            --shadow: 0 10px 30px rgba(0,0,0,0.45);
            --transition: all 0.25s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, var(--bg) 0%, #131828 100%);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.6;
        }

        /* Navbar */
        .navbar {
            background: rgba(15, 23, 42, 0.92);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border);
            padding: 1rem 2rem;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            position: relative;
        }

        .nav-links a:hover,
        .nav-links a.active {
            color: #fff;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -4px;
            left: 0;
            background: var(--accent);
            transition: width 0.3s ease;
        }

        .nav-links a:hover::after,
        .nav-links a.active::after {
            width: 100%;
        }

        .logout-btn {
            background: #ef4444;
            color: white;
            padding: 0.7rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }

        .logout-btn:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }

        /* Main content */
        .container {
            max-width: 1100px;
            margin: 6rem auto 4rem;
            padding: 0 1.5rem;
        }

        .card {
            background: var(--card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 2.5rem;
            box-shadow: var(--shadow);
        }

        h1 {
            font-size: 2.2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 1.5rem 0;
            font-size: 0.95rem;
        }

        th, td {
            padding: 1rem 1.2rem;
            text-align: center;
            border-bottom: 1px solid rgba(99, 102, 241, 0.12);
        }

        th {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background: rgba(31, 41, 55, 0.3);
        }

        tr:hover {
            background: rgba(99, 102, 241, 0.15);
            transition: var(--transition);
        }

        .no-records {
            text-align: center;
            padding: 3rem;
            color: var(--text-muted);
            font-style: italic;
            font-size: 1.1rem;
        }

        .add-btn {
            display: inline-block;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            color: white;
            padding: 0.9rem 1.8rem;
            border-radius: var(--radius);
            text-decoration: none;
            font-weight: 600;
            margin-top: 1.5rem;
            transition: var(--transition);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.25);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.35);
        }

        @media (max-width: 768px) {
            .nav-links { gap: 1.2rem; font-size: 0.95rem; }
            .container { margin: 5rem 1rem 3rem; }
            .card { padding: 2rem 1.5rem; }
            table, th, td { font-size: 0.9rem; padding: 0.8rem; }
        }

        @media (max-width: 480px) {
            .navbar { flex-direction: column; gap: 1rem; padding: 1.2rem; }
            h1 { font-size: 1.9rem; }
            table { font-size: 0.85rem; }
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <div class="logo">Admin Panel</div>
        <div class="nav-links">
            <a href="admin?action=addEmployeePage">Add Employee</a>
            <a href="admin?action=viewEmployees">View Employees</a>
            <a href="addAttendance.jsp">Add Attendance</a>
            <a href="attendance" class="active">View Attendance</a>
            <a href="admin?action=viewPayrolls">View Payrolls</a>
            <a href="admin?action=logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <h1>Attendance Records</h1>

            <c:choose>
                <c:when test="${not empty attendanceList}">
                    <table>
                        <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Month</th>
                                <th>Present Days</th>
                                <th>Working Days</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${attendanceList}">
                                <tr>
                                    <td>${a.empId}</td>
                                    <td>${a.month}</td>
                                    <td>${a.presentDays}</td>
                                    <td>${a.workingDays}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-records">No attendance records found.</div>
                </c:otherwise>
            </c:choose>

            <a href="addAttendance.jsp" class="add-btn">+ Add New Attendance</a>
        </div>
    </div>

</body>
</html>
