<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payroll Records</title>
    <style>
        body { font-family: 'Arial', sans-serif; background: #f4f6f8; margin: 0; padding: 0; }
        h2 { text-align: center; margin: 30px 0; color: #333; }
        table { border-collapse: collapse; width: 90%; max-width: 1000px; margin: 20px auto; box-shadow: 0 5px 15px rgba(0,0,0,0.1); border-radius: 10px; overflow: hidden; }
        th { background: linear-gradient(135deg, #6a11cb, #2575fc); color: #fff; font-weight: 600; padding: 12px 15px; text-align: center; }
        td { padding: 12px 15px; text-align: center; border-bottom: 1px solid #ddd; color: #333; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        tr:hover { background-color: #e0e0e0; transition: 0.3s; }
        td[colspan="6"] { text-align: center; font-style: italic; color: #666; }
        @media screen and (max-width: 768px) { table, th, td { font-size: 14px; } }
        @media screen and (max-width: 480px) { table { width: 100%; } th, td { padding: 10px 5px; } }
        .btn-download { background-color: #2575fc; color: #fff; padding: 5px 10px; text-decoration: none; border-radius: 5px; transition: 0.3s; }
        .btn-download:hover { background-color: #6a11cb; }
    </style>
</head>
<body>

<h2>Payroll List</h2>

<c:if test="${not empty success}">
    <p style="text-align:center; color:green;">${success}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="text-align:center; color:red;">${error}</p>
</c:if>

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

</body>
</html>

