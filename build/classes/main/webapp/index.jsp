
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>TaskSync</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<jsp:include page="includes/header.jsp"/>

<!-- ✅ Bootstrap Carousel -->
<div id="mainCarousel" class="carousel slide mt-3" data-bs-ride="carousel">
    <div class="carousel-inner">

        <div class="carousel-item active">
            <img src="images/carousel1.png" class="d-block w-100" height="400" alt="Carousel 1">
        </div>

        <div class="carousel-item">
            <img src="images/carousel2.png" class="d-block w-100" height="400" alt="Carousel 2">
        </div>

        <div class="carousel-item">
            <img src="images/carousel3.png" class="d-block w-100" height="400" alt="Carousel 3">
        </div>

    </div>

    <!-- ✅ Carousel Controls -->
    <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>


<!-- About Section -->
<div class="container mt-5 text-center">
    <h2>What is this Website?</h2>
    <p>This Employee Task Management System is built to help admins assign, monitor, and manage tasks assigned to employees. Employees can track task progress and report updates.</p>
</div>

<jsp:include page="includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
