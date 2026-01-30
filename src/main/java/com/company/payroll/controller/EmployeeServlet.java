package com.company.payroll.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.company.payroll.dao.AttendanceDAO;
import com.company.payroll.dao.EmployeeDAO;
import com.company.payroll.dao.PayrollDAO;
import com.company.payroll.model.Attendance;
import com.company.payroll.model.Employee;
import com.company.payroll.model.Payroll;

@WebServlet("/employeeDashboard")
public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EmployeeDAO employeeDAO;
    private AttendanceDAO attendanceDAO;
    private PayrollDAO payrollDAO;

    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
        attendanceDAO = new AttendanceDAO();
        payrollDAO = new PayrollDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !"Employee".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        Employee emp = employeeDAO.getEmployeeByUserId(userId);

        if (emp == null) {
            response.sendRedirect("index.jsp?error=EmployeeNotFound");
            return;
        }

        List<Attendance> attendanceList = attendanceDAO.getAttendanceByEmpId(emp.getEmpId());
        List<Payroll> payrollList = payrollDAO.getPayrollByEmpId(emp.getEmpId());

        request.setAttribute("employee", emp);
        request.setAttribute("attendanceList", attendanceList);
        request.setAttribute("payrollList", payrollList);

        request.getRequestDispatcher("employeeDashboard.jsp").forward(request, response);
    }
}
