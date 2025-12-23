<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<main class="container catalog-page">
    <nav class="breadcrumbs">
        <a href="<c:url value='/home/index.do'/>">Home</a> <i class="fa-solid fa-chevron-right"></i> <span>Shop</span>
    </nav>

    <form id="filterForm" method="get" action="<c:url value='/product/index.do'/>">

        <input type="hidden" name="page" value="1"/>
        <input type="hidden" name="category" value="${category}"/>

        <div class="catalog-toolbar">

            <!-- SEARCH -->
            <div class="search-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input
                    type="text"
                    name="search"
                    id="search-input"
                    placeholder="Search keyboard, switch, keycap..."
                    value="${search}">
            </div>

            <!-- SORT -->
            <div class="sort-wrapper">
                <label for="sort-select">Sort by:</label>
                <select name="sort" id="sort-select" class="custom-select"
                        onchange="document.getElementById('filterForm').submit()">
                    <option value="" ${empty sort ? 'selected' : ''}>Default</option>
                    <option value="asc" ${sort == 'asc' ? 'selected' : ''}>Price: Low to high</option>
                    <option value="desc" ${sort == 'desc' ? 'selected' : ''}>Price: High to low</option>
                </select>
            </div>

        </div>
    </form>


    <nav class="category-nav">

        <a href="#"
           class="cat-link ${category == 0 || empty category ? 'active' : ''}"
           onclick="submitCategory('0')">
            All
        </a>

        <c:forEach var="cat" items="${categories}">
            <a href="#"
               class="cat-link ${cat.id == category ? 'active' : ''}"
               onclick="submitCategory('${cat.id}')">
                ${cat.name}
            </a>
        </c:forEach>

    </nav>



    <div class="product-grid catalog-grid">

        <c:forEach var="product" items="${products}">
            <a href="<c:url value='/product/detail.do?id=${product.id}'/>">  
                <div class="product-card">

                    <div class="card-thumb">

                        <c:if test="${product.discount > 0}">
                            <span class="badge badge-sale">SALE</span>
                            <span class="discount-tag">-<fmt:formatNumber value="${product.discount}" type="percent"/></span>
                        </c:if>

                        <img src="<c:url value='${product.imagePath}'/>"
                             alt="${product.name}">
                    </div>

                    <div class="card-info">
                        <h3>${product.name}</h3>

                        <p class="product-description">
                            ${product.description}
                        </p>

                        <div class="price-box">
                            <c:choose>
                                <c:when test="${product.discount > 0}">
                                    <span class="old-price">
                                        <fmt:formatNumber value="${product.price}" type="currency"/>
                                    </span>

                                    <span class="current-price discount">
                                        <fmt:formatNumber value="${product.priceAfterDiscount}" type="currency"/>
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="price">
                                        $<fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2"/>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </div>
            </a>  
        </c:forEach>
    </div>

    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="<c:url value='/product/index.do'>
                   <c:param name='page' value='${i}'/>
                   <c:param name='search' value='${search}'/>
                   <c:param name='category' value='${category}'/>
                   <c:param name='sort' value='${sort}'/>
               </c:url>"
               class="page-link ${i == currentPage ? 'active' : ''}">
                ${i}
            </a>
        </c:forEach>
    </div>

</main>
