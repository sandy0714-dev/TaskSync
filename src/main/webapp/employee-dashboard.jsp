<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // 🔒 Prevent browser caching to block access after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || !"employee".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String fullName = (String) session.getAttribute("fullName");
    int userId = (Integer) session.getAttribute("userId");
    String profilePic = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_java", "root", "");
        PreparedStatement ps = con.prepareStatement("SELECT profile_pic FROM users WHERE id = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            profilePic = rs.getString("profile_pic");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        profilePic = null;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap + FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-light">

<!-- ✅ Header Include -->
<jsp:include page="includes/header.jsp"/>

<div class="container mt-4">

    <!-- Profile Info -->
    <div class="d-flex flex-column align-items-center mb-4">
        <img src="<%= (profilePic != null && !profilePic.isEmpty()) ? profilePic : "https://via.placeholder.com/80" %>"
             class="rounded-circle shadow" width="80" height="80" style="object-fit: cover;">
        <h5 class="mt-2 mb-0"><%= fullName != null ? fullName : username %></h5>
        <small class="text-muted">Employee</small>
    </div>

    <h2 class="text-center mb-4">Your Task Panel</h2>

    <div class="row row-cols-1 row-cols-md-2 g-3">

        <!-- View Assigned Tasks Dropdown -->
        <div class="col">
            <div class="dropdown w-100">
                <button class="btn btn-outline-primary dropdown-toggle w-100 py-3" type="button" data-bs-toggle="dropdown">
                    View Assigned Tasks
                </button>
                <ul class="dropdown-menu w-100">
                    <li><a class="dropdown-item" href="my-tasks-all.jsp">View All</a></li>
                    <li><a class="dropdown-item" href="my-tasks-pending.jsp">View Pending</a></li>
                    <li><a class="dropdown-item" href="my-tasks-inprogress.jsp">View In Progress</a></li>
                    <li><a class="dropdown-item" href="my-tasks-completed.jsp">View Completed</a></li>
                </ul>
            </div>
        </div>

        <!-- Notifications -->
        <div class="col">
            <a href="notifications.jsp" class="btn btn-outline-success w-100 py-3">View Notifications</a>
        </div>

    </div>
</div>

<!-- ✅ Footer Include -->
<jsp:include page="includes/footer.jsp"/>

<!-- ✅ Bootstrap JS (for dropdowns) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
