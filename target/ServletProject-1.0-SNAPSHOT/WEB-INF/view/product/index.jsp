<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Search & Filter Form -->
<form method="get" action="<c:url value='/product/index.do'/>" class="row g-3 mb-4">
    <input type="hidden" name="page" value="1">
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
    <!-- Product Cards -->
    <div class="row">
    <c:forEach var="product" items="${products}">
        <div class="col-md-3 mb-4">
            <div class="card h-100">

                <!-- Product link and image -->
                <a href="<c:url value='/product/detail.do?id=${product.id}'/>">                    
                    <img src="<c:url value='${product.imagePath}'/>" 
                         class="card-img-top" 
                         alt="${product.name}">
                </a>

                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">${product.name}</h5>
                    <p class="card-text text-truncate">${product.description}</p>

                    <!-- Price with discount -->
                    <c:choose>
                        <c:when test="${product.discount > 0}">
                            <p class="card-text text-muted mb-1">
                                <s><fmt:formatNumber value="${product.price}" type="currency"/></s>
                            </p>
                            <p class="card-text fw-bold mb-1">
                                <fmt:formatNumber value="${product.priceAfterDiscount}" type="currency"/>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p class="card-text fw-bold mb-1">
                                <fmt:formatNumber value="${product.price}" type="currency"/>
                            </p>
                        </c:otherwise>
                    </c:choose>

                    <!-- Conditional buttons -->
                    <c:choose>
                        <c:when test="${user.role == 'admin'}">
                            <a href="<c:url value='/product/edit.do?id=${product.id}&returnUrl=${pageUrl}'/>" class="btn btn-primary mb-1">Edit</a>
                            <a href="<c:url value='/product/delete.do?id=${product.id}'/>"
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete ${product.name}?');">
                                Delete
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/cart/add.do?id=${product.id}'/>" 
                               class="btn btn-success mt-auto mb-2">
                                Add to Cart
                            </a>
                        </c:otherwise>
                    </c:choose>

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
                <a class="page-link" href="<c:url value='/product/index.do?page=${i}&search=${search}&category=${category}&sort=${sort}'/>">
                    ${i}
                </a>
            </li>
        </c:forEach>
    </ul>
</nav>