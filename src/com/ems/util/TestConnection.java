package com.ems.util;

import java.sql.Connection;
import java.sql.SQLException;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Connection con = DBUtil.getConnection();
            if (con != null) {
                System.out.println("✅ PostgreSQL connection successful!");
                con.close();
            } else {
                System.out.println("❌ Connection failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
