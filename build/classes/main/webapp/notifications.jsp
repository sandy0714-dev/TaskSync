<jsp:include page="includes/header.jsp"/>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String role = (String) session.getAttribute("role");
    if (session == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Notifications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3><%= role.substring(0, 1).toUpperCase() + role.substring(1) %> Notifications</h3>
    <div class="alert alert-info">🔔 No new notifications yet.</div>
    <a href="<%= role.equals("admin") ? "admin-dashboard.jsp" : "employee-dashboard.jsp" %>" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
<jsp:include page="includes/footer.jsp"/>