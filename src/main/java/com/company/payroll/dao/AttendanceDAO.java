package com.company.payroll.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.company.payroll.model.Attendance;
import com.company.payroll.util.DBUtil;

public class AttendanceDAO {

    // Add Attendance
    public boolean addAttendance(Attendance att) {
        String checkEmpSql = "SELECT emp_id FROM employees WHERE emp_id = ?";
        String insertSql = "INSERT INTO attendance(emp_id, month, present_days, working_days) VALUES (?, ?, ?, ?)";

        try (Connection con = DBUtil.getConnection()) {
            // Check if employee exists
            try (PreparedStatement checkPs = con.prepareStatement(checkEmpSql)) {
                checkPs.setInt(1, att.getEmpId());
                ResultSet rs = checkPs.executeQuery();
                if (!rs.next()) {
                    System.out.println("Employee with ID " + att.getEmpId() + " does not exist.");
                    return false;
                }
            }

            // Insert attendance
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setInt(1, att.getEmpId());
                ps.setString(2, att.getMonth());
                ps.setInt(3, att.getPresentDays());
                ps.setInt(4, att.getWorkingDays());
                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Attendance by Employee and Month
    public Attendance getAttendance(int empId, String month) {
        String sql = "SELECT * FROM attendance WHERE emp_id = ? AND month = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, empId);
            ps.setString(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Attendance(
                        rs.getInt("id"),
                        rs.getInt("emp_id"),
                        rs.getString("month"),
                        rs.getInt("present_days"),
                        rs.getInt("working_days")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Attendance Records
    public List<Attendance> getAllAttendance() {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Attendance(
                        rs.getInt("id"),
                        rs.getInt("emp_id"),
                        rs.getString("month"),
                        rs.getInt("present_days"),
                        rs.getInt("working_days")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }    
    public List<Attendance> getAttendanceByEmpId(int empId) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE emp_id=? ORDER BY month DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance att = new Attendance(
                    rs.getInt("id"),
                    rs.getInt("emp_id"),
                    rs.getString("month"),
                    rs.getInt("present_days"),
                    rs.getInt("working_days")
                );
                list.add(att);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}


