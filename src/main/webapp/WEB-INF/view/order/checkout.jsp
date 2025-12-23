<%-- 
    Document   : checkout
    Created on : Dec 3, 2025, 11:03:51 PM
    Author     : PC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<main class="container checkout-page">
    <nav class="breadcrumbs">
        <a href="<c:url value='/cart/index.do'/>">Cart</a> <i class="fa-solid fa-chevron-right"></i> <span>Checkout</span>
    </nav>

    <div class="checkout-layout">
        <div class="checkout-forms">

            <section class="checkout-section">
                <div class="section-header">
                    <span class="step-number">1</span>
                    <h2>Shipping Information</h2>
                </div>
                <div class="form-grid">
                    <div class="form-group full">
                        <label>Full Name</label>
                        <input type="text" placeholder="John Enthusiast">
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" placeholder="john@example.com">
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" placeholder="+1 (555) 000-0000">
                    </div>
                    <div class="form-group full">
                        <label>Street Address</label>
                        <input type="text" placeholder="123 Keyset Lane">
                    </div>
                    <div class="form-group">
                        <label>City</label>
                        <input type="text" placeholder="Mechanical City">
                    </div>
                    <div class="form-group">
                        <label>Postal Code</label>
                        <input type="text" placeholder="12345">
                    </div>
                </div>
            </section>

            <section class="checkout-section">
                <div class="section-header">
                    <span class="step-number">2</span>
                    <h2>Payment Method</h2>
                </div>
                <div class="payment-options">
                    <label class="payment-card active">
                        <input type="radio" name="payment" checked>
                        <div class="card-content">
                            <i class="fa-solid fa-credit-card"></i>
                            <span>Credit Card</span>
                        </div>
                    </label>
                    <label class="payment-card">
                        <input type="radio" name="payment">
                        <div class="card-content">
                            <i class="fa-brands fa-paypal"></i>
                            <span>PayPal</span>
                        </div>
                    </label>
                </div>

                <div class="credit-card-form">
                    <div class="form-group full">
                        <label>Card Number</label>
                        <div class="input-with-icon">
<!--                            <i class="fa-solid fa-credit-card"></i>-->
                            <input type="text" placeholder="0000 0000 0000 0000">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="text" placeholder="MM/YY">
                    </div>
                    <div class="form-group">
                        <label>CVV</label>
                        <input type="text" placeholder="123">
                    </div>
                </div>
            </section>
        </div>

        <aside class="order-review-sidebar">
            <form action="<c:url value='/order/checkout.do' />" method="post">
                <div class="review-card">
                    <h3>Order Review</h3>
                    <div class="review-items-list">
                        <c:forEach items="${cartItems}" var="item">
                            <div class="mini-item">
                                <img src="<c:url value='/${item.product.imagePath}'/>" alt="Product">
                                <div class="mini-details">
                                    <p class="mini-name">${item.product.name}</p>
                                    <div class="mini-price-row">
                                        <div class="mini-qty-info">
                                            <span class="mini-qty">Qty: ${item.quantity}</span>
                                            <span class="mini-unit-price"><fmt:formatNumber value="${item.price}" type="currency" /></span>
                                        </div>
                                        <span class="mini-item-total"><fmt:formatNumber value="${item.total}" type="currency" /></span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="summary-totals">
                            <div class="summary-row">
                                <span>Subtotal</span>
                                <span><fmt:formatNumber value="${cart.total}" type="currency" /></span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping</span>
                                <span class="free-text">FREE</span>
                            </div>
                            <div class="summary-row total">
                                <span>Total</span>
                                <span><fmt:formatNumber value="${cart.total}" type="currency" /></span>
                            </div>
                        </div>

                        <button class="place-order-btn">
                            <i class="fa-solid fa-circle-check"></i> Complete Purchase
                        </button>
                        <p class="secure-note"><i class="fa-solid fa-shield-halved"></i> 256-bit SSL Encrypted</p>
                    </div>
                </div>
            </form>
        </aside>
    </div>
</main>


