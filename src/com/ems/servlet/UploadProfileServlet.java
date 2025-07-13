package com.ems.servlet;

import com.ems.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;

@MultipartConfig
public class UploadProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("profilePic");
        HttpSession session = request.getSession(false);

        if (session == null || filePart == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/") + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        File file = new File(uploadDir, fileName);
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, file.toPath());
        }

        String filePath = "uploads/" + fileName;

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement("UPDATE users SET profile_pic = ? WHERE id = ?");
            ps.setString(1, filePath);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new ServletException(e);
        }

        // ✅ Redirect to dashboard based on role
        String role = (String) session.getAttribute("role");
        if ("admin".equals(role)) {
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            response.sendRedirect("employee-dashboard.jsp");
        }
    }
}
