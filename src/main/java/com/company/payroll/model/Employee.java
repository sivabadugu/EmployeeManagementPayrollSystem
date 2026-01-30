package com.company.payroll.model;

public class Employee {
    private int empId;
    private int userId; // Link to User table
    private String fullName;
    private String phone;
    private String department;
    private String designation;
    private double baseSalary;

    // Default constructor
    public Employee() {}

    // Constructor with all fields
    public Employee(int empId, int userId, String fullName, String phone, String department, String designation, double baseSalary) {
        this.empId = empId;
        this.userId = userId;
        this.fullName = fullName;
        this.phone = phone;
        this.department = department;
        this.designation = designation;
        this.baseSalary = baseSalary;
    }

    // Constructor for insert without empId
    public Employee(int userId, String fullName, String phone, String department, String designation, double baseSalary) {
        this.userId = userId;
        this.fullName = fullName;
        this.phone = phone;
        this.department = department;
        this.designation = designation;
        this.baseSalary = baseSalary;
    }

    // Getters and setters
    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public double getBaseSalary() { return baseSalary; }
    public void setBaseSalary(double baseSalary) { this.baseSalary = baseSalary; }
}
