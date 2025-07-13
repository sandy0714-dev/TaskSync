package com.ems.servlet;

import com.ems.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateTaskStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String status = request.getParameter("status");
        String taskIdStr = request.getParameter("taskId");

        if (taskIdStr == null || taskIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Task ID missing");
            return;
        }

        try {
            int taskId = Integer.parseInt(taskIdStr);

            try (Connection con = DBUtil.getConnection()) {
                String sql;
                if ("Completed".equalsIgnoreCase(status)) {
                    sql = "UPDATE tasks SET status = ?, completed_at = NOW() WHERE id = ?";
                } else {
                    sql = "UPDATE tasks SET status = ?, completed_at = NULL WHERE id = ?";
                }

                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, status);
                ps.setInt(2, taskId);

                int updated = ps.executeUpdate();
                if (updated > 0) {
                    response.sendRedirect(request.getHeader("Referer")); // redirect back to the same page
                } else {
                    response.getWriter().write("Task not found.");
                }
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid task ID");
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}
