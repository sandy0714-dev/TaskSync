<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("role") == null || !"employee".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("userId");
%>
<jsp:include page="includes/header.jsp"/>
<div class="container mt-5">
    <h3 class="mb-4">In-Progress Tasks</h3>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th><th>Title</th><th>Description</th><th>Employee</th>
                    <th>Status</th><th>Progress</th><th>Created</th><th>Completed On</th><th>Report</th>
                </tr>
            </thead>
            <tbody>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
    	Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection(
    		    "jdbc:postgresql://dpg-d1pr6nvfte5s73cldcc0-a.oregon-postgres.render.com:5432/ems_java",
    		    "ems_user",
    		    "CShu7tAkPBkcYBIdzmoPpq4RQbY7J6jO"
    		);
        String sql = "SELECT t.*, u.full_name FROM tasks t JOIN users u ON t.employee_id = u.id WHERE t.employee_id = ? AND t.status = 'In Progress'";
        ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        while (rs.next()) {
            int taskId = rs.getInt("id");
            String filePath = rs.getString("file_path");
%>
<tr>
    <td><%= taskId %></td>
    <td><%= rs.getString("title") %></td>
    <td><%= rs.getString("description") %></td>
    <td><%= rs.getString("full_name") %></td>
    <td>
        <form action="UpdateTaskStatusServlet" method="post" class="d-flex">
            <input type="hidden" name="taskId" value="<%= taskId %>">
            <select name="status" class="form-select form-select-sm me-2">
                <option value="Pending" selected>Pending</option>
                <option value="In Progress">In Progress</option>
                <option value="Completed">Completed</option>
            </select>
            <button type="submit" class="btn btn-sm btn-primary">Update</button>
        </form>
    </td>
    <td>
        <div class="progress" style="height: 20px;">
            <div class="progress-bar bg-warning" style="width: 60%;">60%</div>
        </div>
    </td>
    <td><%= rs.getTimestamp("created_at") %></td>
    <td>--</td>
    <td>
        <% if (filePath != null && !filePath.trim().isEmpty()) { %>
            <a href="<%= filePath %>" class="btn btn-sm btn-success mb-2" download>Download</a><br>
            <form action="UploadTaskServlet" method="post" enctype="multipart/form-data" class="d-flex">
                <input type="hidden" name="taskId" value="<%= taskId %>">
                <input type="file" name="reportFile" class="form-control form-control-sm me-2" required>
                <button type="submit" class="btn btn-sm btn-warning">Re-upload</button>
            </form>
        <% } else { %>
            <form action="UploadTaskServlet" method="post" enctype="multipart/form-data" class="d-flex">
                <input type="hidden" name="taskId" value="<%= taskId %>">
                <input type="file" name="reportFile" class="form-control form-control-sm me-2" required>
                <button type="submit" class="btn btn-sm btn-primary">Upload</button>
            </form>
        <% } %>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='9'>Error: " + e.getMessage() + "</td></tr>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
            </tbody>
        </table>
    </div>
    <a href="employee-dashboard.jsp" class="btn btn-secondary mt-3">Back to Dashboard</a>
</div>
<jsp:include page="includes/footer.jsp"/>
