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
    <title>Pending Tasks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>Pending Tasks</h3>
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
                <th>Completed On</th>
                <th>Report</th>
            </tr>
        </thead>
        <tbody>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_java", "root", "");
        String sql = "SELECT t.id, t.title, t.description, t.status, t.created_at, t.completed_at, t.file_path, u.full_name FROM tasks t JOIN users u ON t.employee_id = u.id WHERE t.status = 'Pending'";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

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
                <div class="progress-bar bg-secondary" style="width: 25%;">25%</div>
            </div>
        </td>
        <td><%= rs.getTimestamp("created_at") %></td>
        <td><%= rs.getTimestamp("completed_at") != null ? rs.getTimestamp("completed_at") : "-" %></td>
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
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
    }
%>
        </tbody>
    </table>
    </div>
    <a href="admin-dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
