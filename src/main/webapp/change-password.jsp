<%@ page contentType="text/html;charset=UTF-8" %>
<%
    HttpSession s = request.getSession(false);
    if (s == null || s.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String msg = request.getParameter("msg");
%>

<jsp:include page="includes/header.jsp"/>

<div class="container py-5" style="min-height: 80vh;">
    <div class="row justify-content-center">
        <div class="col-md-6 bg-white shadow rounded p-4">
            <h4 class="text-center mb-4">Change Password</h4>

            <% if (msg != null) { %>
                <div class="alert alert-info text-center"><%= msg %></div>
            <% } %>

            <form action="ChangePasswordServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Old Password</label>
                    <input type="password" name="oldPassword" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">New Password</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Confirm New Password</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Update Password</button>
                <a href="<%= session.getAttribute("role").equals("admin") ? "admin-dashboard.jsp" : "employee-dashboard.jsp" %>" class="btn btn-secondary w-100 mt-2">
    Back to Dashboard
</a>
                
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
