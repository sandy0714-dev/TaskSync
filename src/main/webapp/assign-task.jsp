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
    <title>Assign Task</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>Assign Task to Employee</h3>
    <form action="AssignTaskServlet" method="post">
        <div class="mb-3">
            <label>Task Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Task Description</label>
            <textarea name="description" class="form-control" rows="4" required></textarea>
        </div>
        <div class="mb-3">
             <label>Deadline</label>
             <input type="date" name="deadline" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label>Assign To</label>
            <select name="employee_id" class="form-select" required>
                <option value="">-- Select Employee --</option>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems_java", "root", "");
                        ps = con.prepareStatement("SELECT id, full_name FROM users WHERE role = 'employee'");
                        rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("full_name") %></option>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<option>Error loading employees</option>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Assign Task</button>
        <a href="admin-dashboard.jsp" class="btn btn-secondary ms-2">Back to Dashboard</a>
    </form>
</div>
</body>
</html>
<jsp:include page="includes/footer.jsp"/>