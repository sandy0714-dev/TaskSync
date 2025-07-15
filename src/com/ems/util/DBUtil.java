package com.ems.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:postgresql://dpg-d1pr6nvfte5s73cldcc0-a.oregon-postgres.render.com:5432/ems_java";
    private static final String USERNAME = "ems_user";
    private static final String PASSWORD = "CShu7tAkPBkcYBIdzmoPpq4RQbY7J6jO";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver"); // Ensure PostgreSQL driver is loaded
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found", e);
        }

        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
