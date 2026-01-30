package com.company.payroll.util;

import java.io.FileOutputStream;
import java.io.OutputStream;

import com.company.payroll.model.Employee;
import com.company.payroll.model.Payroll;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFGenerator {

    // ================= BROWSER DOWNLOAD =================
    public static void generateSalarySlip(Payroll payroll, OutputStream out) {

        Document document = new Document();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
            Font textFont = new Font(Font.FontFamily.HELVETICA, 12);

            document.add(new Paragraph("SALARY SLIP", titleFont));
            document.add(new Paragraph("--------------------------------------------------"));
            document.add(new Paragraph("Employee ID : " + payroll.getEmpId(), textFont));
            document.add(new Paragraph("Month       : " + payroll.getMonth(), textFont));
            document.add(new Paragraph("Net Salary  : ₹" + payroll.getNetSalary(), textFont));
            document.add(new Paragraph("Generated On: " + payroll.getGeneratedOn(), textFont));

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            document.close(); // ✅ close document only
        }
    }

    // ================= FILE SYSTEM PDF =================
    public static void generateSalarySlip(Employee emp, Payroll payroll, String filePath) {

        Document document = new Document();

        try {
            PdfWriter.getInstance(document, new FileOutputStream(filePath));
            document.open();

            Font titleFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
            Font textFont = new Font(Font.FontFamily.HELVETICA, 12);

            document.add(new Paragraph("SALARY SLIP", titleFont));
            document.add(new Paragraph(" "));
            document.add(new Paragraph("Employee Details", titleFont));
            document.add(new Paragraph("--------------------------------------------------"));

            document.add(new Paragraph("Employee ID   : " + emp.getEmpId(), textFont));
            document.add(new Paragraph("Employee Name : " + emp.getFullName(), textFont));
            document.add(new Paragraph("Department    : " + emp.getDepartment(), textFont));
            document.add(new Paragraph("Designation   : " + emp.getDesignation(), textFont));

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Salary Details", titleFont));
            document.add(new Paragraph("--------------------------------------------------"));

            document.add(new Paragraph("Month        : " + payroll.getMonth(), textFont));
            document.add(new Paragraph("Net Salary   : ₹" + payroll.getNetSalary(), textFont));
            document.add(new Paragraph("Generated On : " + payroll.getGeneratedOn(), textFont));

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            document.close(); // ✅ safe close
        }
    }
}
