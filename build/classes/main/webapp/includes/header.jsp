<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<%
    // Prevent Back Button After Logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    HttpSession s = request.getSession(false); // Don't create session
    String username = null;
    String role = null;

    if (s != null) {
        username = (String) s.getAttribute("username");
        role = (String) s.getAttribute("role");
    }
%>

<!-- ✅ Head Section (if not already present in layout) -->
<head>
    <meta charset="UTF-8">
    <title>TaskSync</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- ✅ Bootstrap 5 CSS (without integrity) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ✅ Font Awesome (without integrity) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<!-- ✅ Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark py-3">
    <div class="container-fluid">
        <!-- Brand -->
        <a class="navbar-brand" href="index.jsp">
            <div style="line-height: 1.2;">
                <strong style="font-size: 20px;">TaskSync</strong><br>
                <span style="font-size: 13px; font-weight: 300;">Track. Assign. Thrive.</span>
            </div>
        </a>

        <!-- Hamburger Toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Links -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="index.jsp#about-section">About</a></li>
                <li class="nav-item"><a class="nav-link" href="index.jsp#contact-section">Contact Us</a></li>

                <% if (username == null) { %>
                    <li class="nav-item"><a class="nav-link" href="login-choice.jsp">Login</a></li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= "admin".equals(role) ? "admin-dashboard.jsp" : "employee-dashboard.jsp" %>">
                            <i class="fas fa-tachometer-alt me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">
                            <i class="fas fa-user-circle me-1"></i> Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp">
                            <i class="fas fa-sign-out-alt me-1"></i> Logout
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
