<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard | ${employee.fullName}</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 50%, #dbeafe 100%);
            color: #1e293b;
            position: relative;
            overflow-x: hidden;
        }

        /* Floating background shape */
        .bg-shape {
            position: absolute;
            width: 720px;
            height: 720px;
            background: radial-gradient(circle at 40% 30%, rgba(59,130,246,0.24), rgba(99,102,241,0.11) 70%, transparent 85%);
            border-radius: 48% 52% 51% 49% / 45% 48% 52% 55%;
            top: -220px;
            right: -250px;
            z-index: -1;
            filter: blur(50px);
            opacity: 0.68;
            animation: float 18s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            50%      { transform: translate(60px, 40px) rotate(8deg); }
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 30px 20px;
            position: relative;
            z-index: 1;
        }

        h2 {
            color: #1e40af;
            font-size: 2.4rem;
            text-align: center;
            margin: 30px 0 40px;
            font-weight: 700;
        }

        h3 {
            color: #1e40af;
            font-size: 1.6rem;
            margin: 45px 0 20px;
            padding-left: 14px;
            border-left: 5px solid #3b82f6;
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            padding: 28px;
            margin-bottom: 35px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 160px 1fr;
            gap: 14px 20px;
            font-size: 1.05rem;
        }

        .info-grid strong {
            color: #1e293b;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            margin: 20px 0;
        }

        th, td {
            padding: 14px 16px;
            text-align: center;
        }

        th {
            background: #1e40af;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.92rem;
            letter-spacing: 0.4px;
        }

        td {
            border-bottom: 1px solid #e2e8f0;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:nth-child(even) {
            background-color: #f8fafc;
        }

        tr:hover {
            background-color: #eff6ff;
            transition: background-color 0.15s;
        }

        a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        a:hover {
            color: #1d4ed8;
            text-decoration: underline;
        }

        .download-btn {
            display: inline-block;
            background: #3b82f6;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.95rem;
            transition: all 0.2s;
        }

        .download-btn:hover {
            background: #2563eb;
            text-decoration: none;
        }

        .logout {
            text-align: center;
            margin: 50px 0 30px;
        }

        .logout a {
            color: #dc2626;
            font-weight: 600;
            font-size: 1.15rem;
            padding: 12px 32px;
            border: 2px solid #dc2626;
            border-radius: 8px;
            transition: all 0.25s;
        }

        .logout a:hover {
            background: #dc2626;
            color: white;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            h2 { font-size: 2rem; }
            .info-grid {
                grid-template-columns: 1fr;
                gap: 10px;
            }
            th, td { padding: 12px 10px; font-size: 0.95rem; }
        }
    </style>
</head>
<body>

    <div class="bg-shape"></div>

    <div class="container">

        <h2>Welcome, ${employee.fullName}!</h2>

        <div class="card">
            <h3>My Details</h3>
            <div class="info-grid">
                <strong>Employee ID:</strong> <span>${employee.empId}</span>
                <strong>Department:</strong> <span>${employee.department}</span>
                <strong>Designation:</strong> <span>${employee.designation}</span>
                <strong>Phone:</strong>      <span>${employee.phone}</span>
                <strong>Base Salary:</strong> <span>Rs. ${employee.baseSalary}</span>
            </div>
        </div>

        <div class="card">
            <h3>My Attendance</h3>
            <table>
                <thead>
                    <tr>
                        <th>Month</th>
                        <th>Present Days</th>
                        <th>Working Days</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty attendanceList}">
                            <c:forEach var="att" items="${attendanceList}">
                                <tr>
                                    <td>${att.month}</td>
                                    <td>${att.presentDays}</td>
                                    <td>${att.workingDays}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="3" style="padding: 30px; color: #64748b;">No attendance data found.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="card">
            <h3>My Payroll</h3>
            <table>
                <thead>
                    <tr>
                        <th>Month</th>
                        <th>Net Salary</th>
                        <th>Generated On</th>
                        <th>Slip</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty payrollList}">
                            <c:forEach var="p" items="${payrollList}">
                                <tr>
                                    <td>${p.month}</td>
                                    <td>Rs. ${p.netSalary}</td>
                                    <td><fmt:formatDate value="${p.generatedOn}" pattern="dd-MM-yyyy HH:mm"/></td>
                                    <td>
                                        <a href="downloadSalarySlip?file=SalarySlip_${employee.empId}_${p.month}.pdf"
                                           class="download-btn">Download PDF</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="4" style="padding: 30px; color: #64748b;">No payroll data found.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="logout">
            <a href="logout">Logout</a>
        </div>

    </div>

</body>
</html>