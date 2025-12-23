<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<main class="container cart-page">
    <nav class="breadcrumbs">
        <a href="<c:url value='/home/index.do'/>">Home</a> <i class="fa-solid fa-chevron-right"></i> <span>Shopping Cart</span>
    </nav>

    <h1 class="page-title">Shopping Cart</h1>

    <div class="cart-layout">
        <div class="cart-items">
            <c:forEach var="item" items="${cartItems}">
                <form action="<c:url value='/cart/update.do'/>" method="post">
                    <div class="cart-item">
                        <div class="item-img">
                            <img  src="<c:url value='/${item.product.imagePath}'/>" alt="Product">
                        </div>
                        <div class="item-details">
                            <h3>${item.product.name}</h3>
                            <input type="hidden" name="id" value="${item.product.id}">
                            <p class="item-variant">Color: Electric Blue</p>
                            <a href="<c:url value='/cart/remove.do?id=${item.product.id}'/>" class="remove-btn">
                                <i class="fa-solid fa-trash-can"></i> Remove
                            </a>
                        </div>
                        <div class="item-price-qty">
                            <div class="price-display-group">
                                <div class="unit-price-info">
                                    <span class="price-label">Price:</span>

                                    <div class="price-wrapper">
                                        <c:choose>
                                            <c:when test="${item.product.discount > 0}">
                                                <del>
                                                    <span class="old-price-small">
                                                        <fmt:formatNumber value="${item.product.price}" type="currency"/>
                                                    </span>
                                                </del>
                                                <span class="unit-price">
                                                    <fmt:formatNumber value="${item.product.priceAfterDiscount}" type="currency"/>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="unit-price">
                                                    <fmt:formatNumber value="${item.product.price}" type="currency"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="line-total-info">
                                    <span class="price-label">Subtotal:</span>
                                    <span class="item-total-price"> <fmt:formatNumber value="${item.total}" type="currency"/></span>
                                </div>
                            </div>

                            <div class="item-actions-row">
                                <div class="quantity-wrapper">
                                    <div class="modern-qty-selector">
                                        <button type="button" class="qty-trigger minus"
                                                onclick="this.parentNode.querySelector('input').stepDown()">
                                            <i class="fa-solid fa-minus"></i>
                                        </button>
                                        <input name="qty" type="number" value="${item.quantity}" min="1" class="qty-input-field">
                                        <button type="button" class="qty-trigger plus"
                                                onclick="this.parentNode.querySelector('input').stepUp()">
                                            <i class="fa-solid fa-plus"></i>
                                        </button>
                                    </div>
                                    <button type="submit" class="update-cart-btn">
                                        <i class="fa-solid fa-rotate"></i>
                                        <span>Update</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </c:forEach>
        </div>

        <aside class="cart-summary">
            <h3>Order Summary</h3>

            <div class="summary-row">
                <span>Subtotal</span>
                <span><fmt:formatNumber value="${cart.total}" type="currency"/></span>
            </div>
            <div class="summary-row">
                <span>Shipping</span>
                <span>FREE</span>
            </div>
            <div class="summary-row">
                <span>Estimated Tax</span>
                <span>$0</span>
            </div>

            <div class="summary-row total">
                <span>Total</span>
                <span><fmt:formatNumber value="${cart.total}" type="currency"/></span>
            </div>

            <form action="<c:url value='/order/checkout.do'/>" method="get">
                <button class="btn-checkout">Checkout Now</button>
            </form>

            <a href="<c:url value='/product/index.do?page=1'/>" class="continue-shopping">Continue Shopping</a>
        </aside>
    </div>
</main>


