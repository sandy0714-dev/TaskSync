package com.ems.servlet;

import com.ems.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AddEmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (username, password, role, full_name, email) VALUES (?, ?, 'employee', ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, fullName);
            ps.setString(4, email);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.getWriter().println("Failed to add employee.");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
