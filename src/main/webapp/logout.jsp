<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 🔒 Prevent caching so back button doesn't work after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 🔐 Invalidate session
    session.invalidate();

    // 🚀 Redirect to home page
    response.sendRedirect("index.jsp");
%>
