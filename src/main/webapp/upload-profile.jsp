<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Profile Picture</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<jsp:include page="includes/header.jsp"/>

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h3 class="text-center mb-3">Upload Profile Picture</h3>

        <form action="UploadProfileServlet" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <input type="file" name="profilePic" class="form-control" accept="image/*" required>
            </div>
            <button class="btn btn-primary w-100">Upload</button>
        </form>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>

</body>
</html>
