<%-- 
    Document   : index
    Created on : Dec 1, 2025, 9:59:34 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Home" />

<!-- Hero Carousel -->
<div id="homeCarousel" class="carousel slide mb-5" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="<c:url value='/images/banners/banner1.jpg'/>" class="d-block w-100" alt="Banner 1">
        </div>
        <div class="carousel-item">
            <img src="<c:url value='/images/banners/banner2.jpg'/>" class="d-block w-100" alt="Banner 2">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<!-- Three Promotional Sections -->
<div class="container my-5">
    <div class="row text-center">
        <div class="col-md-4 mb-4">
            <div class="p-4 border rounded shadow-sm h-100">
                <i class="bi bi-truck fs-1 mb-3"></i>
                <h4>Fast Delivery</h4>
                <p>Get your orders delivered quickly and safely, anywhere.</p>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="p-4 border rounded shadow-sm h-100">
                <i class="bi bi-tags fs-1 mb-3"></i>
                <h4>Best Prices</h4>
                <p>We offer competitive pricing on all our top-quality products.</p>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="p-4 border rounded shadow-sm h-100">
                <i class="bi bi-shield-check fs-1 mb-3"></i>
                <h4>Secure Payments</h4>
                <p>Your payment information is safe and secure with us.</p>
            </div>
        </div>
    </div>
</div>

<!-- About / Info Section -->
<div class="bg-light py-5">
    <div class="container text-center">
        <h2>About WebShop</h2>
        <p class="lead mb-4">WebShop is your one-stop online shop for a wide range of high-quality products at great prices. Enjoy fast delivery, secure payments, and excellent customer service.</p>
        <a href="<c:url value='/product/index.do?page=1'/>" class="btn btn-lg btn-primary">Browse All Products</a>
    </div>
</div>

<!-- Optional Small Featured Products Section -->
<div class="container my-5">
    <h2 class="mb-4 text-center">New Arrivals</h2>
    <div class="row g-4">
        <c:forEach var="product" items="${newProducts}" begin="0" end="3">
            <div class="col-md-3">
                <div class="card h-100 shadow-sm">
                    <img src="<c:url value='${product.imagePath}'/>" class="card-img-top" alt="${product.name}">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${product.name}</h5>
                        <p class="card-text fw-bold mt-auto">$${product.price}</p>
                        <a href="<c:url value='/cart?action=add&productId=${product.id}'/>" class="btn btn-success mt-2">Add to Cart</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Call-to-Action Section -->
<div class="text-center my-5">
    <h3>Start Shopping Today!</h3>
    <a href="<c:url value='/product/index.do?page=1'/>" class="btn btn-lg btn-primary mt-3">Shop Now</a>
</div>



