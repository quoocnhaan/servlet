<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-4">
    <div class="row">
        <!-- Product Image -->
        <div class="col-md-5 position-relative">
            <img src="<c:url value='${product.imagePath}'/>" class="img-fluid rounded" alt="${product.name}">

            <!-- Discount Badge -->
            <c:if test="${product.discount > 0}">
                <span class="badge bg-danger position-absolute top-0 start-0 m-2">
                    ${product.discount * 100}% OFF
                </span>
            </c:if>
        </div>

        <!-- Product Info -->
        <div class="col-md-7">
            <h2>${product.name}</h2>
            <p class="text-muted">Category: <c:out value="${product.category.name}"/></p>
            <p>${product.description}</p>

            <!-- Price with discount -->
            <c:choose>
                <c:when test="${product.discount > 0}">
                    <!-- Original price struck-through -->
                    <p class="text-muted mb-1">
                        <s><fmt:formatNumber value="${product.price}" type="currency"/></s>
                    </p>
                    <!-- Discounted price -->
                    <p class="fw-bold h4 mb-3">
                        <fmt:formatNumber value="${product.priceAfterDiscount}" type="currency"/>
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="fw-bold h4 mb-3">
                        <fmt:formatNumber value="${product.price}" type="currency"/>
                    </p>
                </c:otherwise>
            </c:choose>

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
            <form action="<c:url value='/cart/add.do'/>" method="get" class="mt-3">
                <input type="hidden" name="action" value="add"/>
                <input type="hidden" name="id" value="${product.id}"/>
                <div class="mb-3">
                    <label for="quantity" class="form-label">Quantity:</label>
                    <input type="number" name="qty" id="quantity" value="1" min="1" max="${product.quantity}" class="form-control w-25">
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
