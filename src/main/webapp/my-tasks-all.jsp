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
    <h3 class="mb-4">All Assigned Tasks</h3>
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
                    String sql = "SELECT t.*, u.full_name FROM tasks t JOIN users u ON t.employee_id = u.id WHERE t.employee_id = ?";
                    ps = con.prepareStatement(sql);
                    ps.setInt(1, userId);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String status = rs.getString("status");
                        int percent = 25;
                        String color = "bg-secondary";
                        if ("In Progress".equals(status)) {
                            percent = 60;
                            color = "bg-warning";
                        } else if ("Completed".equals(status)) {
                            percent = 100;
                            color = "bg-success";
                        }
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getString("full_name") %></td>
                <td>
    <form action="UpdateTaskStatusServlet" method="post" class="d-flex">
        <input type="hidden" name="taskId" value="<%= rs.getInt("id") %>">
        <select name="status" class="form-select form-select-sm me-2">
            <option value="Pending" <%= "Pending".equals(rs.getString("status")) ? "selected" : "" %>>Pending</option>
            <option value="In Progress" <%= "In Progress".equals(rs.getString("status")) ? "selected" : "" %>>In Progress</option>
            <option value="Completed" <%= "Completed".equals(rs.getString("status")) ? "selected" : "" %>>Completed</option>
        </select>
        <button type="submit" class="btn btn-sm btn-primary">Update</button>
    </form>
</td>

                <td>
                    <div class="progress" style="height: 20px;">
                        <div class="progress-bar <%= color %>" style="width: <%= percent %>%"> <%= percent %>% </div>
                    </div>
                </td>
                <td><%= rs.getTimestamp("created_at") %></td>
                <td><%= rs.getTimestamp("completed_at") != null ? rs.getTimestamp("completed_at") : "--" %></td>
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
