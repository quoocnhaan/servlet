<%-- 
    Document   : checkout
    Created on : Dec 3, 2025, 11:03:51 PM
    Author     : PC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="container my-4">

    <h3 class="mb-4">Checkout</h3>
    <c:if test="${message != null}">
        <div class="alert alert-danger">${message}</div>
    </c:if>
    <form action="<c:url value='/order/checkout.do' />" method="post">

        <div class="row">

            <!-- LEFT COLUMN: BILLING -->
            <div class="col-md-7">

                <!-- Billing Info -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Billing Information</h5>
                    </div>

                    <div class="card-body">

                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="fullName" class="form-control"
                                   placeholder="Enter full name" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="text" name="phone" class="form-control"
                                   placeholder="Enter phone number" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control"
                                   placeholder="Enter delivery address" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Notes (optional)</label>
                            <textarea name="notes" class="form-control" rows="2"></textarea>
                        </div>

                    </div>
                </div>

                <!-- Payment -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Payment Method</h5>
                    </div>

                    <div class="card-body">

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="payment" value="COD" id="cod" checked>
                            <label class="form-check-label" for="cod">Cash on Delivery (COD)</label>
                        </div>

                        <div class="form-check mt-2">
                            <input class="form-check-input" type="radio" name="payment" value="Card" id="card">
                            <label class="form-check-label" for="card">Credit / Debit Card</label>
                        </div>

                    </div>
                </div>

            </div>

            <!-- RIGHT COLUMN: CART ITEMS -->
            <div class="col-md-5">

                <div class="card shadow-sm">
                    <div class="card-header">
                        <h5 class="mb-0">Cart Summary</h5>
                    </div>

                    <div class="card-body">

                        <c:set var="grandTotal" value="0" />

                        <!-- Loop items -->
                        <c:forEach items="${cartItems}" var="item">
                            <div class="card mb-3 border-0 border-bottom pb-3">

                                <div class="d-flex">

                                    <!-- Product image -->
                                    <img src="<c:url value='/${item.product.imagePath}'/>"
                                         class="img-thumbnail me-3"
                                         style="width: 70px; height: 70px; object-fit: cover;">

                                    <!-- Product info -->
                                    <div class="flex-grow-1">
                                        <strong>${item.product.name}</strong><br>
                                        Price:
                                        <fmt:formatNumber value="${item.price}" type="currency" />
                                        <br>
                                        Qty: ${item.quantity}
                                    </div>

                                    <!-- Subtotal -->
                                    <div class="text-end">
                                        <fmt:formatNumber value="${item.total}" type="currency" />
                                    </div>

                                </div>

                            </div>

                            <!-- Accumulate total -->
                        </c:forEach>

                        <!-- Total -->
                        <hr>
                        <div class="d-flex justify-content-between">
                            <strong>Total:</strong>
                            <strong>
                                <fmt:formatNumber value="${cart.total}" type="currency" />
                            </strong>
                        </div>

                        <!-- Checkout button -->
                        <button type="submit" class="btn btn-primary w-100 mt-3">
                            Confirm & Place Order
                        </button>

                    </div>
                </div>

            </div>
        </div>
    </form>
</div>

