<jsp:include page="includes/header.jsp"/>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Employees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>Employee List</h3>
    <table class="table table-bordered table-striped">
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
                con = DriverManager.getConnection(
            		    "jdbc:postgresql://dpg-d1pr6nvfte5s73cldcc0-a.oregon-postgres.render.com:5432/ems_java",
            		    "ems_user",
            		    "CShu7tAkPBkcYBIdzmoPpq4RQbY7J6jO"
            		);
                ps = con.prepareStatement("SELECT * FROM users WHERE role = 'employee'");
                rs = ps.executeQuery();

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
            } catch(Exception e) {
                out.println("<tr><td colspan='4' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                try { if (rs != null) rs.close(); } catch(Exception e) {}
                try { if (ps != null) ps.close(); } catch(Exception e) {}
                try { if (con != null) con.close(); } catch(Exception e) {}
            }
        %>
        </tbody>
    </table>
    <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
<jsp:include page="includes/footer.jsp"/>