package com.company.payroll.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.company.payroll.dao.EmployeeDAO;
import com.company.payroll.dao.UserDAO;
import com.company.payroll.model.Employee;
import com.company.payroll.model.User;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private EmployeeDAO employeeDao = new EmployeeDAO();
    private UserDAO userDao = new UserDAO();

    private static final String ROLE_EMPLOYEE = "Employee";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null
                || !"Admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "viewEmployees":
                List<Employee> empList = employeeDao.getAllEmployees();
                request.setAttribute("employees", empList);
                request.getRequestDispatcher("viewEmployees.jsp").forward(request, response);
                break;

            case "addEmployeePage":
                request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
                break;

            case "logout":
                session.invalidate();
                response.sendRedirect("index.jsp");
                break;

            default:
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("addEmployee".equals(action)) {

            try {
                String username = request.getParameter("username").trim();
                String password = request.getParameter("password").trim();
                String fullName = request.getParameter("fullName").trim();
                String phone = request.getParameter("phone").trim();
                String department = request.getParameter("department").trim();
                String designation = request.getParameter("designation").trim();
                String baseSalaryStr = request.getParameter("baseSalary").trim();

                if (username.isEmpty() || password.isEmpty() || fullName.isEmpty()
                        || department.isEmpty() || designation.isEmpty() || baseSalaryStr.isEmpty()) {
                    forwardWithError(request, response, "All fields are required");
                    return;
                }

                if (userDao.getUserByUsername(username) != null) {
                    forwardWithError(request, response, "Username already exists");
                    return;
                }

                User user = new User();
                user.setUsername(username);
                user.setPassword(password); // raw password, hashing is done in UserDAO.addUser()
                user.setRole(ROLE_EMPLOYEE);

                boolean userAdded = userDao.addUser(user);
                if (!userAdded) {
                    forwardWithError(request, response, "Failed to create user");
                    return;
                }

                int userId = user.getId();

                double baseSalary = 0;
                try {
                    baseSalary = Double.parseDouble(baseSalaryStr);
                    if (baseSalary < 0) throw new NumberFormatException();
                } catch (NumberFormatException ex) {
                    forwardWithError(request, response, "Invalid base salary");
                    return;
                }

                Employee emp = new Employee();
                emp.setUserId(userId);
                emp.setFullName(fullName);
                emp.setPhone(phone);
                emp.setDepartment(department);
                emp.setDesignation(designation);
                emp.setBaseSalary(baseSalary);

                boolean empAdded = employeeDao.addEmployee(emp);
                if (empAdded) {
                    response.sendRedirect("admin?action=viewEmployees");
                } else {
                    forwardWithError(request, response, "Failed to create employee profile");
                }

            } catch (Exception e) {
                e.printStackTrace();
                forwardWithError(request, response, "Unexpected error occurred");
            }
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher("addEmployee.jsp").forward(request, response);
    }
}
