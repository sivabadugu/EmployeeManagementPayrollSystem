package com.company.payroll.model;

import java.sql.Timestamp;

public class Payroll {
    private int id;
    private int empId;
    private String month;
    private double netSalary;
    private Timestamp generatedOn;

    public Payroll() {}

    public Payroll(int id, int empId, String month, double netSalary, Timestamp generatedOn) {
        this.id = id;
        this.empId = empId;
        this.month = month;
        this.netSalary = netSalary;
        this.generatedOn = generatedOn;
    }

    public Payroll(int empId, String month, double netSalary) {
        this.empId = empId;
        this.month = month;
        this.netSalary = netSalary;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmpId() { return empId; }
    public void setEmpId(int empId) { this.empId = empId; }

    public String getMonth() { return month; }
    public void setMonth(String month) { this.month = month; }

    public double getNetSalary() { return netSalary; }
    public void setNetSalary(double netSalary) { this.netSalary = netSalary; }

    public Timestamp getGeneratedOn() { return generatedOn; }
    public void setGeneratedOn(Timestamp generatedOn) { this.generatedOn = generatedOn; }
}
