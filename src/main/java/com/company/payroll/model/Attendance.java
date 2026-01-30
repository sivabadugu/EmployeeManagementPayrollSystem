package com.company.payroll.model;

public class Attendance {
    private int id;          // Primary key
    private int empId;       // Employee ID
    private String month;    // Month of attendance
    private int presentDays; // Number of days present
    private int workingDays; // Total working days
    
    public Attendance() {
    	
    }
    // Constructor with id (for retrieving from DB)
    public Attendance(int id, int empId, String month, int presentDays, int workingDays) {
        this.id = id;
        this.empId = empId;
        this.month = month;
        this.presentDays = presentDays;
        this.workingDays = workingDays;
    }

    // Constructor without id (for inserting new attendance)
    public Attendance(int empId, String month, int presentDays, int workingDays) {
        this.empId = empId;
        this.month = month;
        this.presentDays = presentDays;
        this.workingDays = workingDays;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getPresentDays() {
        return presentDays;
    }

    public void setPresentDays(int presentDays) {
        this.presentDays = presentDays;
    }

    public int getWorkingDays() {
        return workingDays;
    }

    public void setWorkingDays(int workingDays) {
        this.workingDays = workingDays;
    }
}
