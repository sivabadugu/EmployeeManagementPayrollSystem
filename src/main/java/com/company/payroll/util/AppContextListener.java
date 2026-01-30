package com.company.payroll.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Payroll App Started...");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Payroll App Stopping...");

        // 1. Deregister JDBC Drivers
        try {
            java.sql.DriverManager.deregisterDriver(
                java.sql.DriverManager.getDrivers().nextElement()
            );
            System.out.println("JDBC Driver deregistered.");
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 2. Stop MySQL Abandoned Connection Cleanup Thread
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread stopped.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
