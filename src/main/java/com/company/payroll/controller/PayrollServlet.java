package com.company.payroll.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.company.payroll.dao.PayrollDAO;
import com.company.payroll.dao.AttendanceDAO;
import com.company.payroll.dao.EmployeeDAO;
import com.company.payroll.model.Payroll;
import com.company.payroll.model.Attendance;
import com.company.payroll.model.Employee;
import com.company.payroll.util.PDFGenerator;

@WebServlet("/payroll")
public class PayrollServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String ADMIN_ROLE = "Admin";

    private PayrollDAO payrollDAO;
    private AttendanceDAO attendanceDAO;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        payrollDAO = new PayrollDAO();
        attendanceDAO = new AttendanceDAO();
        employeeDAO = new EmployeeDAO();
    }

    // ===== GENERATE PAYROLL =====
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !ADMIN_ROLE.equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Unauthorized");
            return;
        }

        String successMsg = null;
        String errorMsg = null;

        try {
            int empId = Integer.parseInt(request.getParameter("empId"));
            String month = request.getParameter("month");

            Employee emp = employeeDAO.getEmployeeById(empId);
            if (emp == null) {
                errorMsg = "Employee not found.";
            } else {
                Attendance att = attendanceDAO.getAttendance(empId, month);
                if (att == null || att.getWorkingDays() <= 0) {
                    errorMsg = "Attendance data missing.";
                } else {
                    double perDaySalary = emp.getBaseSalary() / att.getWorkingDays();
                    double netSalary = perDaySalary * att.getPresentDays();

                    Payroll payroll = new Payroll(empId, month, netSalary);
                    int payrollId = payrollDAO.addPayroll(payroll);

                    if (payrollId > 0) {
                        Payroll savedPayroll = payrollDAO.getPayrollById(payrollId);

                        String folderPath = getServletContext().getRealPath("/") + File.separator + "salary_slips";
                        File dir = new File(folderPath);
                        if (!dir.exists()) dir.mkdirs();

                        String filePath = folderPath + File.separator + "SalarySlip_" + empId + "_" + month + ".pdf";
                        PDFGenerator.generateSalarySlip(emp, savedPayroll, filePath);

                        successMsg = "Payroll generated successfully for Emp ID: " + empId;
                    } else {
                        errorMsg = "Payroll generation failed.";
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            errorMsg = "Exception occurred: " + e.getMessage();
        }

        // Fetch updated payroll list and forward to JSP
        try {
            List<Payroll> payrolls = payrollDAO.getAllPayrolls();
            request.setAttribute("payrollList", payrolls);
            request.setAttribute("success", successMsg);
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("/viewPayrolls.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp?error=ViewFailed");
        }
    }

    // ===== VIEW PAYROLLS =====
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !ADMIN_ROLE.equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<Payroll> payrolls = payrollDAO.getAllPayrolls();
            request.setAttribute("payrollList", payrolls);
            request.getRequestDispatcher("/viewPayrolls.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp?error=ViewFailed");
        }
    }
}
