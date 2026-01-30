package com.company.payroll.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.company.payroll.dao.AttendanceDAO;
import com.company.payroll.model.Attendance;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AttendanceDAO attendanceDAO;

    public void init() {
        attendanceDAO = new AttendanceDAO();
    }
    
    // GET -> View/Search
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // -------- Session Validation --------
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("username") == null 
           || !"Admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp");  // Redirect to existing login page
            return;
        }
        // -----------------------------------

        String empIdParam = request.getParameter("empId");
        String month = request.getParameter("month");
        List<Attendance> list = new ArrayList<>();

        if (empIdParam != null && month != null &&
            !empIdParam.isEmpty() && !month.isEmpty()) {
            try {
                int empId = Integer.parseInt(empIdParam);
                Attendance att = attendanceDAO.getAttendance(empId, month);
                if (att != null) list.add(att);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else {
            list = attendanceDAO.getAllAttendance();
        }

        request.setAttribute("attendanceList", list);
        request.getRequestDispatcher("attendanceList.jsp").forward(request, response);
    }

    // POST -> Add Attendance
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // -------- Session Validation --------
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("username") == null 
           || !"Admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp");  // Redirect to existing login page
            return;
        }
        // -----------------------------------

        try {
            int empId = Integer.parseInt(request.getParameter("empId"));
            String month = request.getParameter("month");
            int presentDays = Integer.parseInt(request.getParameter("presentDays"));
            int workingDays = Integer.parseInt(request.getParameter("workingDays"));

            Attendance att = new Attendance(empId, month, presentDays, workingDays);
            boolean status = attendanceDAO.addAttendance(att);

            // Redirect back to addAttendance.jsp with status
            response.sendRedirect("addAttendance.jsp?status=" + (status ? "success" : "error"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addAttendance.jsp?status=error");
        }
    }
}
