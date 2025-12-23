<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<main class="container detail-view">
    <nav class="breadcrumbs">
        <a href="<c:url value='/home/index.do'/>">Home</a>
        <i class="fa-solid fa-chevron-right"></i> <a href="<c:url value='/product/index.do?page=1'/>">Shop</a>
        <i class="fa-solid fa-chevron-right"></i> <span>${product.name}</span>
    </nav>

    <section class="product-main">
        <div class="product-gallery">
            <div class="main-image">
                <img src="<c:url value='${product.imagePath}'/>" alt="Main View"
                     id="featured">
            </div>
            <div class="thumbnail-list">
                <img src="<c:url value='${product.imagePath}'/>" class="active-thumb"
                     alt="Thumbnail 1">
                <img src="<c:url value='${product.imagePath}'/>" alt="Thumbnail 2">
                <img src="<c:url value='${product.imagePath}'/>" alt="Thumbnail 3">
            </div>
        </div>




        <div class="product-info-panel">
            <c:if test="${product.newArrival}">
                <span class="badge badge-new">New Release</span>
            </c:if> 
            <h1 class="product-title">Phantom 80% TKL Mechanical Keyboard</h1>

            <div class="price-section">
                <div class="price-wrapper">
                    <c:choose>
                        <c:when test="${product.discount > 0}">
                            <span class="current-price">
                                <fmt:formatNumber value="${product.priceAfterDiscount}" type="currency"/>
                            </span>
                            <span class="old-price">
                                <fmt:formatNumber value="${product.price}" type="currency"/>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="price">
                                <fmt:formatNumber value="${product.price}" type="currency"/>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${product.discount > 0}">
                    <span class="save-badge">
                        Save <fmt:formatNumber value="${product.discount}" type="percent"/>
                    </span>
                </c:if>                
                <span class="stock-status"><i class="fa-solid fa-circle-check"></i> In Stock</span>
            </div>

            <p class="short-description">
                The Phantom 80% TKL is a masterpiece of engineering. Featuring a gasket-mount design,
                hotswappable PCB, and premium aluminum housing for the ultimate thocky sound profile.
            </p>

            <div class="options-group">
                <h4>Select Switch Type</h4>
                <div class="switch-picker">
                    <label class="switch-opt">
                        <input type="radio" name="switch" checked>
                        <span>Gateron Yellow (Linear)</span>
                    </label>
                    <label class="switch-opt">
                        <input type="radio" name="switch">
                        <span>Bobas U4T (Tactile)</span>
                    </label>
                    <label class="switch-opt">
                        <input type="radio" name="switch">
                        <span>Cherry Blue (Clicky)</span>
                    </label>
                </div>
            </div>
            
            <form action="<c:url value='/cart/add.do'/>" method="get">
                <div class="purchase-actions">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="id" value="${product.id}"/>
                    <div class="quantity-control">
                        <button type="button" class="qty-btn minus">
                            <i class="fa-solid fa-minus"></i>
                        </button>
                        <input type="number" class="quantity-input" name="qty" value="1" min="1">
                        <button type="button" class="qty-btn plus">
                            <i class="fa-solid fa-plus"></i>
                        </button>
                    </div>

                    <button type="submit" class="add-to-cart">
                        <i class="fa-solid fa-cart-shopping"></i>
                        Add to Cart
                    </button>
                </div>
            </form>

            <div class="product-meta">
                <p><strong>SKU:</strong> CC-PHANTOM-80</p>
                <p><strong>Category:</strong> ${product.category.name}</p>
            </div>
        </div>
    </section>

    <section class="product-details-tab">
        <h3>Technical Specifications</h3>
        <table class="specs-table">
            <tr>
                <td>Layout</td>
                <td>80% Tenkeyless (TKL)</td>
            </tr>
            <tr>
                <td>Mounting Style</td>
                <td>Gasket Mount</td>
            </tr>
            <tr>
                <td>Case Material</td>
                <td>CNC Aluminum</td>
            </tr>
            <tr>
                <td>Connectivity</td>
                <td>USB-C, Bluetooth 5.0, 2.4GHz</td>
            </tr>
            <tr>
                <td>Keycaps</td>
                <td>Double-shot PBT Cherry Profile</td>
            </tr>
        </table>
    </section>
</main>


