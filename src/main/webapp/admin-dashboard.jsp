<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // Prevent caching
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String fullName = (String) session.getAttribute("fullName");
    int userId = (Integer) session.getAttribute("userId");
    String profilePic = null;

    try {
    	Class.forName("org.postgresql.Driver");
    	Connection con = DriverManager.getConnection(
    		    "jdbc:postgresql://dpg-d1pr6nvfte5s73cldcc0-a.oregon-postgres.render.com:5432/ems_java",
    		    "ems_user",
    		    "CShu7tAkPBkcYBIdzmoPpq4RQbY7J6jO"
    		);
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
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="bg-light">

<!-- ✅ Header -->
<jsp:include page="includes/header.jsp"/>

<div class="container mt-4">
    <!-- ✅ Profile Section -->
    <div class="d-flex flex-column align-items-center mb-4">
        <img src="<%= (profilePic != null && !profilePic.isEmpty()) ? profilePic : "https://via.placeholder.com/80" %>"
             class="rounded-circle shadow" width="80" height="80" style="object-fit: cover;">
        <h5 class="mt-2 mb-0"><%= fullName != null ? fullName : username %></h5>
        <small class="text-muted">Admin</small>
    </div>

    <h2 class="text-center mb-4">Your Admin Panel</h2>

    <!-- ✅ Dashboard Buttons -->
    <div class="row row-cols-1 row-cols-md-2 g-3">
        <div class="col">
            <a href="add-employee.jsp" class="btn btn-outline-success w-100 py-3">Add Employee</a>
        </div>

        <div class="col">
            <div class="dropdown w-100">
                <button class="btn btn-outline-primary dropdown-toggle w-100 py-3" data-bs-toggle="dropdown">
                    View Tasks
                </button>
                <ul class="dropdown-menu w-100">
                    <li><a class="dropdown-item" href="view-tasks.jsp">View All Tasks</a></li>
                    <li><a class="dropdown-item" href="view-inprogress-tasks.jsp">View In-Progress Tasks</a></li>
                    <li><a class="dropdown-item" href="view-completed-tasks.jsp">View Completed Tasks</a></li>
                    <li><a class="dropdown-item" href="view-pending-tasks.jsp">View Pending Tasks</a></li>
                </ul>
            </div>
        </div>

        <div class="col">
            <a href="assign-task.jsp" class="btn btn-outline-warning w-100 py-3">Assign Task</a>
        </div>

        <div class="col">
            <a href="employee-list.jsp" class="btn btn-outline-info w-100 py-3">View All Employees</a>
        </div>

        <div class="col">
            <a href="notifications.jsp" class="btn btn-outline-secondary w-100 py-3">Notifications</a>
        </div>
    </div>
</div>

<!-- ✅ Footer -->
<jsp:include page="includes/footer.jsp"/>

<!-- ✅ Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
