<jsp:include page="includes/header.jsp"/>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
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
    <title>All Tasks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>All Assigned Tasks</h3>
    <div class="table-responsive">
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Description</th>
        <th>Employee</th>
        <th>Status</th>
        <th>Progress</th>
        <th>Created</th>
        <th>Report</th> <!-- ✅ New column for download -->
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
                String sql = "SELECT t.id, t.title, t.description, t.status, t.created_at, t.file_path, u.full_name " +
                        "FROM tasks t JOIN users u ON t.employee_id = u.id";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getString("full_name") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
    <div class="progress" style="height: 20px;">
        <%
            String status = rs.getString("status");
            String progressColor = "bg-secondary";
            int percent = 25;
            if ("In Progress".equals(status)) {
                progressColor = "bg-warning";
                percent = 60;
            } else if ("Completed".equals(status)) {
                progressColor = "bg-success";
                percent = 100;
            }
        %>
        <div class="progress-bar <%= progressColor %>" role="progressbar" style="width: <%= percent %>%;">
            <%= percent %>%
        </div>
    </div>
</td>
                
                <td><%= rs.getTimestamp("created_at") %></td>
                <td>
    
    <% String filePath = rs.getString("file_path"); %>
    <% if (filePath != null && !filePath.trim().isEmpty()) { %>
        <a href="<%= filePath %>" class="btn btn-sm btn-success" download>Download</a>
    <% } else { %>
        <span class="text-muted">No file</span>
    <% } %>


</td>
                
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>
        </tbody>
    </table>
    </div>
    <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
<jsp:include page="includes/footer.jsp"/>