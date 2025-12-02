<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-4">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-5">
            <img src="<c:url value='${product.imagePath}'/>" class="img-fluid rounded" alt="${product.name}">
        </div>

        <!-- Product Info -->
        <div class="col-md-7">
            <h2>${product.name}</h2>
            <p class="text-muted">Category: <c:out value="${product.category.name}"/></p>
            <p>${product.description}</p>
            <p class="fw-bold h4">$<fmt:formatNumber value="${product.price}" type="currency"/></p>
            <p>Available Quantity: <c:out value="${product.quantity}"/></p>

            <!-- Stats -->
            <div class="mt-4">
                <h5>Product Stats</h5>
                <ul>
                    <li>Popularity: 87%</li>
                    <li>Rating: 4.5 / 5</li>
                    <li>Sold: 230 units</li>
                    <li>Shipping: Free for orders over $50</li>
                </ul>
            </div>

            <!-- Gifts / Promotions -->
            <div class="mt-3">
                <h5>Special Offers</h5>
                <ul>
                    <li>Buy 2 get 1 free</li>
                    <li>Free gift wrap for this product</li>
                    <li>10% off if you buy more than 3 units</li>
                </ul>
            </div>

            <!-- Add to Cart Form -->
            <form action="<c:url value='/cart'/>" method="get" class="mt-3">
                <input type="hidden" name="action" value="add"/>
                <input type="hidden" name="productId" value="${product.id}"/>
                <div class="mb-3">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <input type="number" name="quantity" id="quantity" value="1" min="1" max="${product.quantity}" class="form-control w-25">
                </div>
                <button type="submit" class="btn btn-success btn-lg">Add to Cart</button>
                <a href="<c:url value='/product/index.do?page=1'/>" class="btn btn-secondary btn-lg ms-2">Back to Products</a>
            </form>
        </div>
    </div>

    <!-- Customer Reviews -->
    <div class="row mt-5">
        <div class="col-12">
            <h4>Customer Reviews</h4>
            <div class="card p-3 mb-3">
                <p><strong>Jane D.</strong> - ★★★★★</p>
                <p>Great product! Highly recommend.</p>
            </div>
            <div class="card p-3 mb-3">
                <p><strong>John S.</strong> - ★★★★☆</p>
                <p>Good quality but shipping was a bit slow.</p>
            </div>
            <div class="card p-3 mb-3">
                <p><strong>Mary K.</strong> - ★★★★★</p>
                <p>Exactly what I expected. Will buy again.</p>
            </div>
        </div>
    </div>
</div>
