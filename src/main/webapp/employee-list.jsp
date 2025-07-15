<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <title>All Employees</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3 class="mb-4">All Registered Employees</h3>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Username</th>
            <th>Email</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
            	Class.forName("org.postgresql.Driver");
            	Connection con = DriverManager.getConnection(
            		    "jdbc:postgresql://dpg-d1pr6nvfte5s73cldcc0-a.oregon-postgres.render.com:5432/ems_java",
            		    "ems_user",
            		    "CShu7tAkPBkcYBIdzmoPpq4RQbY7J6jO"
            		);
                PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE role = 'employee'");
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("full_name") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("email") %></td>
        </tr>
        <%
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
    <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
