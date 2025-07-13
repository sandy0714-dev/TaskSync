package com.ems.servlet;

import com.ems.util.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AssignTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int employeeId = Integer.parseInt(request.getParameter("employee_id"));
        String deadline = request.getParameter("deadline");


        try (Connection con = DBUtil.getConnection()) {
        	PreparedStatement ps = con.prepareStatement(
        		    "INSERT INTO tasks (title, description, employee_id, deadline) VALUES (?, ?, ?, ?)");
        		ps.setString(1, title);
        		ps.setString(2, description);
        		ps.setInt(3, employeeId);
        		ps.setString(4, deadline);


            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.getWriter().println("Failed to assign task.");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
