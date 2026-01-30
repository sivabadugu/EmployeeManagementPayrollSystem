package com.company.payroll.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/downloadSalarySlip")
public class DownloadSalarySlipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String ADMIN_ROLE = "Admin";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !ADMIN_ROLE.equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Unauthorized");
            return;
        }

        String fileName = request.getParameter("file");
        if (fileName == null || fileName.isEmpty()) {
            response.getWriter().println("Invalid file name.");
            return;
        }

        String filePath = getServletContext().getRealPath("/salary_slips/" + fileName);
        File pdfFile = new File(filePath);

        if (!pdfFile.exists()) {
            response.getWriter().println("File not found.");
            return;
        }

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        try (FileInputStream fis = new FileInputStream(pdfFile)) {
            fis.transferTo(response.getOutputStream());
        } catch (IOException e) {
            response.getWriter().println("Error downloading file.");
            e.printStackTrace();
        }
    }
}

