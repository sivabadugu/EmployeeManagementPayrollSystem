package com.company.payroll.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.company.payroll.model.Employee;
import com.company.payroll.util.DBUtil;

public class EmployeeDAO {

    // Add a new employee
    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees(user_id, full_name, phone, department, designation, base_salary) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, emp.getUserId());
            ps.setString(2, emp.getFullName());
            ps.setString(3, emp.getPhone());
            ps.setString(4, emp.getDepartment());
            ps.setString(5, emp.getDesignation());
            ps.setDouble(6, emp.getBaseSalary());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get employee by employee ID
    public Employee getEmployeeById(int empId) {
        String sql = "SELECT * FROM employees WHERE emp_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Employee(
                    rs.getInt("emp_id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("department"),
                    rs.getString("designation"),
                    rs.getDouble("base_salary")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get employee by user ID
    public Employee getEmployeeByUserId(int userId) {
        String sql = "SELECT * FROM employees WHERE user_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Employee(
                    rs.getInt("emp_id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("department"),
                    rs.getString("designation"),
                    rs.getDouble("base_salary")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get all employees (for admin dashboard)
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM employees";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Employee emp = new Employee(
                    rs.getInt("emp_id"),
                    rs.getInt("user_id"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("department"),
                    rs.getString("designation"),
                    rs.getDouble("base_salary")
                );
                list.add(emp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
