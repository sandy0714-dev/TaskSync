package com.ems.servlet;

import com.ems.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        // Upload directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = null;

        try {
            Part filePart = request.getPart("profilePic");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePath = "uploads/" + System.currentTimeMillis() + "_" + fileName;

                File file = new File(uploadPath + File.separator + filePath.substring(filePath.lastIndexOf("/") + 1));
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            }

            try (Connection con = DBUtil.getConnection()) {
                String sql;
                PreparedStatement ps;

                if (filePath != null) {
                    sql = "UPDATE users SET full_name = ?, username = ?, email = ?, profile_pic = ? WHERE id = ?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, username);
                    ps.setString(3, email);
                    ps.setString(4, filePath);
                    ps.setInt(5, userId);
                } else {
                    sql = "UPDATE users SET full_name = ?, username = ?, email = ? WHERE id = ?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, username);
                    ps.setString(3, email);
                    ps.setInt(4, userId);
                }

                int updated = ps.executeUpdate();

                if (updated > 0) {
                    session.setAttribute("username", username); // Update session name
                    
                    String role = (String) session.getAttribute("role");
                    if ("admin".equals(role)) {
                        response.sendRedirect("admin-dashboard.jsp");
                    } else {
                        response.sendRedirect("employee-dashboard.jsp");
                    }
                } else {
                    response.getWriter().println("Failed to update profile.");
                }

            }

        } catch (Exception e) {
            throw new ServletException("Error updating profile", e);
        }
    }
}
