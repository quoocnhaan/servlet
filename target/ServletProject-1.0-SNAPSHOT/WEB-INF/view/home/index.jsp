<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Home" />

<main>
    <section class="hero">
        <div class="container hero-container">
            <div class="hero-text">
                <h1>The Ultimate Typing Experience</h1>
                <p>Upgrade your setup with our premium selection of hotswappable mechanical keyboards, artisanal
                    keycaps, and ultra-smooth switches.</p>
                <a href="<c:url value='/product/index.do?page=1'/>" class="btn btn-primary">
                    Shop Now <i class="fa-solid fa-chevron-right"></i>
                </a>
            </div>
            <div class="hero-image">
                <img src="https://images.unsplash.com/photo-1618384887929-16ec33fab9ef?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80"
                     alt="Mechanical Keyboard Display">
            </div>
        </div>
    </section>

    <section class="products-section container">
        <h2 class="section-title">New Releases</h2>
        <div class="product-grid">
            <c:forEach var="product" items="${newProducts}" begin="0" end="3">
                <a href="<c:url value='/product/detail.do?id=${product.id}'/>">                    
                    <div class="product-card">
                        <div class="card-thumb">
                            <span class="badge badge-new">NEW</span>
                            <img src="<c:url value='${product.imagePath}'/>" alt="Product">
                        </div>
                        <div class="card-info">
                            <h3>${product.name}</h3>
                            <p class="product-description">
                                ${product.description}
                            </p>
                            <p class="price"><fmt:formatNumber value="${product.price}" type="currency"/></p>
                        </div>
                    </div>
                </a>
            </c:forEach>
    </section>

    <section class="products-section container">
        <h2 class="section-title">Exclusive Deals</h2>
        <div class="product-grid">


            <c:forEach var="product" items="${discountProducts}" begin="0" end="3">
                <a href="<c:url value='/product/detail.do?id=${product.id}'/>">                    
                    <div class="product-card">
                        <div class="card-thumb">
                            <span class="badge badge-sale">SALE</span>
                            <span class="discount-tag">-<fmt:formatNumber value="${product.discount}" type="percent"/></span>                        
                            <img src="<c:url value='${product.imagePath}'/>" alt="Product">
                        </div>
                        <div class="card-info">
                            <h3>${product.name}</h3>
                            <p class="product-description">
                                ${product.description}
                            </p>
                            <div class="price-box">
                                <span class="old-price"><fmt:formatNumber value="${product.price}" type="currency"/></span>
                                <span class="current-price discount"><fmt:formatNumber value="${product.priceAfterDiscount}" type="currency"/></span>
                            </div>                    
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </section>
</main>
