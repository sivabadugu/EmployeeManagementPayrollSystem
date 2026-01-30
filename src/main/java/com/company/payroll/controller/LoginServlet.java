package com.company.payroll.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.company.payroll.dao.UserDAO;
import com.company.payroll.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show login page
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        if (username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("index.jsp?error=MissingCredentials");
            return;
        }

        User user = userDAO.validateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            switch (user.getRole()) {
                case "Admin":
                    response.sendRedirect("admin?action=adminDashboard");
                    break;
                case "HR":
                    response.sendRedirect("hrDashboard");
                    break;
                case "Employee":
                    response.sendRedirect("employeeDashboard");
                    break;
                default:
                    response.sendRedirect("index.jsp?error=InvalidRole");
            }
        } else {
            response.sendRedirect("index.jsp?error=InvalidCredentials");
        }
    }
}


