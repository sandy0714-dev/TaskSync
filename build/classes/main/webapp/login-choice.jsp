<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Login Type</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<jsp:include page="includes/header.jsp"/>

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm text-center">
        <h3 class="mb-4">Login As</h3>
        <a href="login.jsp?role=admin" class="btn btn-primary btn-lg w-100 mb-3">Admin Login</a>
        <a href="login.jsp?role=employee" class="btn btn-success btn-lg w-100">Employee Login</a>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>

</body>
</html>
