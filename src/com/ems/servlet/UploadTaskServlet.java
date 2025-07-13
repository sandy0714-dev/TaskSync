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

//@WebServlet("/UploadTaskServlet")
@MultipartConfig
public class UploadTaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // ✅ Get taskId safely
            String taskIdStr = request.getParameter("taskId");

            if (taskIdStr == null || taskIdStr.trim().isEmpty()) {
                response.getWriter().println("❌ Task ID is missing.");
                return;
            }

            int taskId = Integer.parseInt(taskIdStr);

            // ✅ Get uploaded file
            Part filePart = request.getPart("reportFile");
            if (filePart == null || filePart.getSize() == 0) {
                response.getWriter().println("❌ No file selected for upload.");
                return;
            }

            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDirPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // ✅ Save file
            String savedFileName = System.currentTimeMillis() + "_" + fileName;
            String savedPath = uploadDirPath + File.separator + savedFileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(savedPath), StandardCopyOption.REPLACE_EXISTING);
            }

            // ✅ Save relative path to DB
            String dbFilePath = "uploads/" + savedFileName;

            try (Connection con = DBUtil.getConnection()) {
                PreparedStatement ps = con.prepareStatement("UPDATE tasks SET file_path = ? WHERE id = ?");
                ps.setString(1, dbFilePath);
                ps.setInt(2, taskId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    String referer = request.getHeader("referer");
                    response.sendRedirect(referer);  // ✅ Go back to same page (pending, inprogress, or completed)
                } else {
                    response.getWriter().println("❌ Failed to update database.");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Error: " + e.getMessage());
        }
    }
}
