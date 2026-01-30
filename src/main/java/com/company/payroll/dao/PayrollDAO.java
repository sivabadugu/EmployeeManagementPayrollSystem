package com.company.payroll.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.company.payroll.model.Payroll;
import com.company.payroll.util.DBUtil;

public class PayrollDAO {

    // Add payroll and return generated ID
    public int addPayroll(Payroll payroll) {
        String sql = "INSERT INTO payroll(emp_id, month, net_salary) VALUES (?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, payroll.getEmpId());
            ps.setString(2, payroll.getMonth());
            ps.setDouble(3, payroll.getNetSalary());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // failed
    }

    // Get payroll by ID
    public static Payroll getPayrollById(int id) {
        String sql = "SELECT * FROM payroll WHERE id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Payroll(
                        rs.getInt("id"),
                        rs.getInt("emp_id"),
                        rs.getString("month"),
                        rs.getDouble("net_salary"),
                        rs.getTimestamp("generated_on")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all payrolls
    public List<Payroll> getAllPayrolls() {
        List<Payroll> list = new ArrayList<>();
        String sql = "SELECT * FROM payroll ORDER BY generated_on DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Payroll p = new Payroll(
                    rs.getInt("id"),
                    rs.getInt("emp_id"),
                    rs.getString("month"),
                    rs.getDouble("net_salary"),
                    rs.getTimestamp("generated_on")
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Optional: update payroll
    public boolean updatePayroll(Payroll payroll) {
        String sql = "UPDATE payroll SET emp_id=?, month=?, net_salary=? WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, payroll.getEmpId());
            ps.setString(2, payroll.getMonth());
            ps.setDouble(3, payroll.getNetSalary());
            ps.setInt(4, payroll.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Optional: delete payroll
    public boolean deletePayroll(int id) {
        String sql = "DELETE FROM payroll WHERE id=?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public Payroll getLatestPayrollByEmpId(int empId) {
        String sql = "SELECT * FROM payroll WHERE emp_id=? ORDER BY generated_on DESC LIMIT 1";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Payroll(
                        rs.getInt("id"),
                        rs.getInt("emp_id"),
                        rs.getString("month"),
                        rs.getDouble("net_salary"),
                        rs.getTimestamp("generated_on")
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Payroll> getPayrollByEmpId(int empId) {
        List<Payroll> list = new ArrayList<>();
        String sql = "SELECT * FROM payroll WHERE emp_id=? ORDER BY generated_on DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Payroll p = new Payroll(
                    rs.getInt("id"),
                    rs.getInt("emp_id"),
                    rs.getString("month"),
                    rs.getDouble("net_salary"),
                    rs.getTimestamp("generated_on")
                );
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
