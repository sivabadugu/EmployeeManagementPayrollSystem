<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Attendance | Admin Panel</title>

    <style>
        :root {
            --bg: #0b0e17;
            --surface: #111827;
            --card: rgba(17, 24, 39, 0.75);
            --border: rgba(99, 102, 241, 0.15);
            --primary: #6366f1;       /* indigo main */
            --accent: #818cf8;        /* lighter indigo/purple accent */
            --text: #e2e8f0;
            --text-muted: #9ca3af;
            --error: #f87171;
            --success: #10b981;
            --radius: 14px;
            --shadow: 0 10px 30px rgba(0,0,0,0.4);
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem 1rem;
        }

        /* Navbar - same as admin dashboard */
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
            max-width: 500px;
            width: 100%;
            margin-top: 6rem; /* space for fixed navbar */
        }

        .card {
            background: var(--card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 2.5rem 2rem;
            box-shadow: var(--shadow);
            text-align: center;
        }

        h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-group {
            margin-bottom: 1.6rem;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-muted);
            font-weight: 500;
            font-size: 0.95rem;
        }

        input {
            width: 100%;
            padding: 1rem 1.2rem;
            background: rgba(31, 41, 55, 0.8);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            color: var(--text);
            font-size: 1.05rem;
            transition: var(--transition);
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(129, 140, 248, 0.2);
            background: rgba(31, 41, 55, 1);
        }

        button {
            width: 100%;
            padding: 1.2rem;
            margin-top: 1rem;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border: none;
            border-radius: var(--radius);
            color: white;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.25);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(99, 102, 241, 0.4);
        }

        .message {
            margin: 1.5rem 0;
            padding: 1rem;
            border-radius: var(--radius);
            font-weight: 500;
        }

        .success {
            background: rgba(16, 185, 129, 0.15);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .error {
            background: rgba(248, 113, 113, 0.15);
            color: var(--error);
            border: 1px solid rgba(248, 113, 113, 0.3);
        }

        .link {
            margin-top: 1.5rem;
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .link:hover {
            color: #fff;
            text-decoration: underline;
        }

        @media (max-width: 640px) {
            .card { padding: 2rem 1.5rem; }
            h1 { font-size: 1.9rem; }
        }
    </style>
</head>
<body>

    <!-- Navbar - same as Add Employee / Admin Panel -->
    <nav class="navbar">
        <div class="logo">Admin Panel</div>
        <div class="nav-links">
            <a href="admin?action=addEmployeePage">Add Employee</a>
            <a href="admin?action=viewEmployees">View Employees</a>
            <a href="addAttendance.jsp" class="active">Add Attendance</a>
            <a href="viewPayrolls.jsp">View Payrolls</a>
            <a href="admin?action=logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <h1>Add Attendance</h1>

            <form action="attendance" method="post">
                <div class="form-group">
                    <label for="empId">Employee ID</label>
                    <input type="number" id="empId" name="empId" required>
                </div>

                <div class="form-group">
                    <label for="month">Month (YYYY-MM)</label>
                    <input type="text" id="month" name="month" placeholder="YYYY-MM" required>
                </div>

                <div class="form-group">
                    <label for="presentDays">Present Days</label>
                    <input type="number" id="presentDays" name="presentDays" required>
                </div>

                <div class="form-group">
                    <label for="workingDays">Working Days</label>
                    <input type="number" id="workingDays" name="workingDays" required>
                </div>

                <button type="submit">Add Attendance</button>
            </form>

            <c:if test="${param.status == 'success'}">
                <div class="message success">Attendance added successfully!</div>
            </c:if>

            <c:if test="${param.status == 'error'}">
                <div class="message error">Error occurred while adding attendance.</div>
            </c:if>

            <a href="attendance" class="link">View / Search Attendance</a>
        </div>
    </div>

</body>
</html>