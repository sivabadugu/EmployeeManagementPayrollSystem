<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Add Employee | Admin Panel</title>
    <style>
        :root {
            --bg: #0b0e17;
            --surface: #111827;
            --card: rgba(17, 24, 39, 0.75);
            --border: rgba(99, 102, 241, 0.15);
            --primary: #6366f1;
            --accent: #818cf8;
            --text: #e2e8f0;
            --text-muted: #9ca3af;
            --error: #f87171;
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
        }

        /* Navbar */
        .navbar {
            background: rgba(15, 23, 42, 0.92);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
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

        /* Main */
        .container {
            max-width: 1100px;
            margin: 4rem auto;
            padding: 0 1.5rem;
        }

        .card {
            background: var(--card);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 3rem 3.5rem;
            box-shadow: var(--shadow);
        }

        h1 {
            font-size: 2.4rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2.5rem;
            color: #f1f5f9;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 1.8rem 2.2rem;
        }

        .form-group {
            position: relative;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.3rem;
            color: var(--text-muted);
            pointer-events: none;
            transition: var(--transition);
        }

        input {
            width: 100%;
            padding: 1.3rem 1.2rem 0.6rem 3.5rem;
            background: rgba(31, 41, 55, 0.8);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            color: #fff;
            font-size: 1.05rem;
            transition: var(--transition);
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(129, 140, 248, 0.2);
            background: rgba(31, 41, 55, 1);
        }

        input:focus + .input-icon {
            color: var(--accent);
        }

        label {
            position: absolute;
            top: 1.2rem;
            left: 3.5rem;
            color: var(--text-muted);
            font-size: 1rem;
            pointer-events: none;
            transition: var(--transition);
            transform-origin: left top;
        }

        input:focus + .input-icon + label,
        input:not(:placeholder-shown) + .input-icon + label {
            top: 0.5rem;
            font-size: 0.82rem;
            color: var(--accent);
            transform: scale(0.9);
        }

        .btn {
            grid-column: 1 / -1;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            color: white;
            border: none;
            padding: 1.3rem;
            font-size: 1.15rem;
            font-weight: 600;
            border-radius: var(--radius);
            cursor: pointer;
            margin-top: 1.5rem;
            transition: var(--transition);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.25);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(99, 102, 241, 0.4);
        }

        .error-msg {
            color: var(--error);
            text-align: center;
            margin: 1rem 0 2rem;
            padding: 1rem;
            background: rgba(248, 113, 113, 0.1);
            border: 1px solid rgba(248, 113, 113, 0.2);
            border-radius: var(--radius);
        }

        @media (max-width: 768px) {
            .nav-links { gap: 1.2rem; font-size: 0.95rem; }
            .container { margin: 3rem 1rem; }
            .card { padding: 2.5rem 1.8rem; }
            .form-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 480px) {
            .navbar { flex-direction: column; gap: 1rem; padding: 1.2rem; }
            h1 { font-size: 2rem; }
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <div class="logo">Admin Panel</div>
        <div class="nav-links">
            <a href="admin?action=addEmployeePage" class="active">Add Employee</a>
            <a href="admin?action=viewEmployees">View Employees</a>
            <a href="addAttendance.jsp">Add Attendance</a>
            <a href="attendanceList.jsp">Employee Attendance</a>
            <a href="viewPayrolls.jsp">View Payrolls</a>
            <a href="generatePayroll.jsp">Genrate Payroll</a>
            <a href="admin?action=logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <h1>Add New Employee</h1>

            <c:if test="${not empty error}">
                <div class="error-msg">${error}</div>
            </c:if>

            <form action="admin" method="post">
                <input type="hidden" name="action" value="addEmployee">

                <div class="form-grid">

                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">👤</span>
                            <input type="text" name="username" placeholder=" " required>
                            <label>Username</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">🔐</span>
                            <input type="password" name="password" placeholder=" " required>
                            <label>Password</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">👤</span>
                            <input type="text" name="fullName" placeholder=" " required>
                            <label>Full Name</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">📱</span>
                            <input type="tel" name="phone" placeholder=" " required>
                            <label>Phone Number</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">🏢</span>
                            <input type="text" name="department" placeholder=" " required>
                            <label>Department</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-wrapper">
                            <span class="input-icon">💼</span>
                            <input type="text" name="designation" placeholder=" " required>
                            <label>Designation</label>
                        </div>
                    </div>

                    <div class="form-group full">
                        <div class="input-wrapper">
                            <span class="input-icon">💰</span>
                            <input type="number" name="baseSalary" step="0.01" placeholder=" " required>
                            <label>Base Salary (₹)</label>
                        </div>
                    </div>

                    <button type="submit" class="btn">Add Employee</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>