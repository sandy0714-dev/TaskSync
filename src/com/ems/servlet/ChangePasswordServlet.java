package com.ems.servlet;

import com.ems.util.DBUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("change-password.jsp?msg=Passwords+do+not+match");
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT password FROM users WHERE id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String currentPassword = rs.getString("password");

                if (!currentPassword.equals(oldPassword)) {
                    response.sendRedirect("change-password.jsp?msg=Incorrect+old+password");
                    return;
                }

                ps.close();
                PreparedStatement updatePs = con.prepareStatement("UPDATE users SET password = ? WHERE id = ?");
                updatePs.setString(1, newPassword);
                updatePs.setInt(2, userId);
                int updated = updatePs.executeUpdate();

                if (updated > 0) {
                    response.sendRedirect("change-password.jsp?msg=Password+updated+successfully");
                } else {
                    response.sendRedirect("change-password.jsp?msg=Update+failed.+Try+again");
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
