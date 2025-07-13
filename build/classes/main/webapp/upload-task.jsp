<jsp:include page="includes/header.jsp"/>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || !"employee".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Task Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h3>Upload Report for Task ID: <%= request.getParameter("task_id") %></h3>
    <form action="UploadTaskServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="task_id" value="<%= request.getParameter("task_id") %>">
        <div class="mb-3">
            <label>Select File (PDF, DOC, ZIP)</label>
            <input type="file" name="report" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Upload</button>
        <a href="my-tasks.jsp" class="btn btn-secondary ms-2">Cancel</a>
    </form>
</div>
</body>
</html>
<jsp:include page="includes/footer.jsp"/>