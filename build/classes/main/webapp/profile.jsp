<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // 🔒 Prevent browser back after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("userId");
    String fullName = "", username = "", email = "", profilePic = "";

    try {
    	Class.forName("org.postgresql.Driver");
        Connection con = DriverManager.getConnection(
    		    "jdbc:postgresql://dpg-d1pr6nvfte5s73cldcc0-a.oregon-postgres.render.com:5432/ems_java",
    		    "ems_user",
    		    "CShu7tAkPBkcYBIdzmoPpq4RQbY7J6jO"
    		);
        PreparedStatement ps = con.prepareStatement("SELECT full_name, username, email, profile_pic FROM users WHERE id = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            fullName = rs.getString("full_name");
            username = rs.getString("username");
            email = rs.getString("email");
            profilePic = rs.getString("profile_pic");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    }
%>

<jsp:include page="includes/header.jsp"/>

<div class="container py-5" style="min-height: 80vh;">
    <div class="row justify-content-center">
        <div class="col-md-6 bg-white p-4 shadow rounded">
            <h3 class="text-center mb-4">Profile</h3>

            <div class="text-center mb-3">
                <img src="<%= (profilePic != null && !profilePic.isEmpty()) ? profilePic : "https://via.placeholder.com/100" %>"
                     class="rounded-circle shadow" width="100" height="100" style="object-fit: cover;">
            </div>

            <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" value="<%= fullName %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" value="<%= username %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="<%= email %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Change Profile Picture</label>
                    <input type="file" name="profilePic" class="form-control">
                </div>

                <button type="submit" class="btn btn-primary w-100">Update Profile</button>

                <!-- Change Password + Dashboard -->
                <div class="text-center mt-3">
                    <a href="change-password.jsp" class="btn btn-outline-secondary btn-sm me-2">Change Password</a>
                    <a href="<%= session.getAttribute("role").equals("admin") ? "admin-dashboard.jsp" : "employee-dashboard.jsp" %>" 
                       class="btn btn-outline-dark btn-sm">Back to Dashboard</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
