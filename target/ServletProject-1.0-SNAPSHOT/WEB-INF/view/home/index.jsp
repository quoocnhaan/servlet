<%-- 
    Document   : index
    Created on : Dec 1, 2025, 9:59:34 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Search & Filter Form -->
<form method="get" action="<c:url value='/product'/>" class="row g-3 mb-4">
    <div class="col-md-4">
        <input type="text" name="search" class="form-control" placeholder="Search products..." 
               value="${search}">
    </div>
    <div class="col-md-3">
        <select name="category" class="form-select">
            <option value="0">All Categories</option>
            <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}" 
                        <c:if test="${cat.id == category}">selected</c:if>>
                    ${cat.name}
                </option>
            </c:forEach>
        </select>
    </div>
    <div class="col-md-3">
        <select name="sort" class="form-select">
            <option value="asc" <c:if test="${sort == 'asc'}">selected</c:if>>Price: Low to High</option>
            <option value="desc" <c:if test="${sort == 'desc'}">selected</c:if>>Price: High to Low</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Apply</button>
        </div>
    </form>

    <!-- Product Cards -->
    <div class="row">
    <c:forEach var="product" items="${products}">
        <div class="col-md-3 mb-4">
            <div class="card h-100">
                <img src="<c:url value='${product.imagePath}'/>" class="card-img-top" alt="${product.name}">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">${product.name}</h5>
                    <p class="card-text text-truncate">${product.description}</p>
                    <p class="card-text fw-bold mt-auto">$<fmt:formatNumber value="${product.price}" type="currency"/></p>
                    <a href="<c:url value='/cart?action=add&productId=${product.id}'/>" class="btn btn-success mt-2">Add to Cart</a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<!-- Pagination -->
<nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                <a class="page-link" href="<c:url value='/product?page=${i}&search=${search}&category=${category}&sort=${sort}'/>">
                    ${i}
                </a>
            </li>
        </c:forEach>
    </ul>
</nav>



