# Employee Management & Payroll System  
**Modern • Secure • Efficient**  
Java | Servlets | JSP | MySQL | MVC | PDF Generation

<p align="center">
  <img src="https://img.shields.io/badge/Java-17+-007396?style=for-the-badge&logo=java&logoColor=whit" alt="Java"/>
  <img src="https://img.shields.io/badge/Servlets-4.0+-FF6600?style=for-the-badge" alt="Servlets"/>
  <img src="https://img.shields.io/badge/JSP-2.3+-007396?style=for-the-badge" alt="JSP"/>
  <img src="https://img.shields.io/badge/MySQL-8.0+-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Apache%20Tomcat-9+-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black" alt="Tomcat"/>
  <img src="https://img.shields.io/badge/MVC-Architecture-blueviolet?style=for-the-badge" alt="MVC"/>
  <img src="https://img.shields.io/badge/PDF-iText-orange?style=for-the-badge" alt="PDF"/>
</p>

<p align="center">
  <strong>A clean, role-based, production-ready Employee Management & Payroll web application built with pure Java EE technologies</strong><br>
  Ideal showcase project for interviews — demonstrates solid backend architecture, security practices, and clean separation of concerns.
</p>

---

## ✨ Highlights

- **Complete MVC architecture** with clear separation (Servlets → DAO → Model)
- **Role-based access control** — Admin vs Employee
- **Monthly payroll automation** with attendance-linked calculation
- **Professional PDF salary slip generation** (downloadable)
- **Session-based authentication** + unauthorized access protection
- **DAO pattern** + JDBC + Connection pooling readiness
- **Clean, modern-looking UI** (minimal CSS + responsive design)
- **Production-grade project structure**

---

## 🚀 Features

| Category              | Features                                                                 |
|-----------------------|--------------------------------------------------------------------------|
| **Authentication**    | Login / Logout, Session Management, Role-based Redirection              |
| **Admin Privileges**  | Add/View/Edit Employees, Record Attendance, Generate Payroll, View All Records |
| **Employee Privileges** | View own payroll history, Download own salary slip (PDF)               |
| **Payroll Engine**    | Basic salary + Attendance days calculation + Deductions support        |
| **Document Generation** | Professional PDF salary slip using iText / OpenPDF                     |
| **Security**          | Servlet filters (optional), role checks, no direct JSP access          |
| **Architecture**      | Strict MVC + DAO pattern + Utility classes                             |

---

## 🛠️ Tech Stack

| Layer           | Technology                                 | Version     |
|-----------------|--------------------------------------------|-------------|
| Language        | Java                                       | 8 / 11 / 17 |
| Web             | Servlets, JSP, JSTL                        | 4.0+ / 2.3+ |
| Database        | MySQL                                      | 8.0+        |
| Connectivity    | JDBC                                       | —           |
| PDF Generation  | iText / OpenPDF                            | 5.x / 1.x   |
| Server          | Apache Tomcat                              | 9 / 10      |
| IDE             | Eclipse / IntelliJ IDEA                    | —           |
| Version Control | Git                                        | —           |
| UI              | HTML5, CSS3 (minimal + responsive)         | —           |

---

## ⚡ Quick Start

```bash
# 1. Clone
https://github.com/sivabadugu/EmployeeManagementPayrollSystem

# 2. Import as Dynamic Web Project in Eclipse / IntelliJ

# 3. Configure Tomcat 9 or 10

# 4. Create MySQL database & import schema
mysql -u root -p < database/schema.sql

# 5. Update credentials in src/util/DBUtil.java

# 6. Run on server

# 7. Open in browser
http://localhost:8080/EmployeeManagementPayrollSystem/

🗄️ Database Schema (Core Tables)


### 1. `users`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `username` | VARCHAR(100) | UNIQUE, NOT NULL |
| `password` | VARCHAR(255) | NOT NULL |
| `role` | ENUM('Admin','HR','Employee') | NOT NULL |

---

### 2. `employees`
| Column | Type | Constraints |
|--------|------|-------------|
| `emp_id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `user_id` | INT | UNIQUE, NOT NULL, FOREIGN KEY REFERENCES `users(id)` |
| `full_name` | VARCHAR(100) | NOT NULL |
| `phone` | VARCHAR(20) | NULL |
| `department` | VARCHAR(50) | NULL |
| `designation` | VARCHAR(50) | NULL |

---

### 3. `attendance`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `employee_id` | INT | NOT NULL, FOREIGN KEY REFERENCES `employees(emp_id)` |
| `date` | DATE | NOT NULL |
| `status` | ENUM('Present','Half-Day','Absent') | NOT NULL |

**Unique Constraint:** `(employee_id, date)`

---

### 4. `payroll`
| Column | Type | Constraints |
|--------|------|-------------|
| `id` | INT | PRIMARY KEY, AUTO_INCREMENT |
| `employee_id` | INT | NOT NULL, FOREIGN KEY REFERENCES `employees(emp_id)` |
| `month` | TINYINT | NOT NULL |
| `year` | YEAR | NOT NULL |
| `basic_salary` | DECIMAL(10,2) | NOT NULL |
| `days_present` | DECIMAL(5,2) | NOT NULL |
| `gross_salary` | DECIMAL(10,2) | NOT NULL |
| `deductions` | DECIMAL(10,2) | NOT NULL |
| `net_salary` | DECIMAL(10,2) | NOT NULL |
| `generated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |



🚀 Future / Enhancement Ideas

BCrypt / Argon2 password hashing
Email delivery of salary slips (JavaMail)
Leave Management Module
Attendance via QR / Biometric stub
REST API layer (Jakarta EE / Spring Boot migration path)
Frontend modernization (React + Vite + Axios)
Docker support
Unit & Integration tests (JUnit + Mockito)
