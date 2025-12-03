<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-4">

    <h2 class="mb-4">Your Shopping Cart</h2>

    <c:if test="${empty cartItems}">
        <div class="alert alert-info">Your cart is empty.</div>
        <a href="<c:url value='/product/index.do?page=1'/>" class="btn btn-primary mt-3">
            Continue Shopping
        </a>
    </c:if>

    <c:if test="${not empty cartItems}">

        <table class="table table-bordered align-middle">
            <thead class="table-light">
                <tr>
                    <th>Product</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th width="120">Quantity</th>
                    <th>Total</th>
                    <th>Update</th>
                    <th>Remove</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="item" items="${cartItems}">
                    <!-- FORM must wrap the entire <tr> -->
                <form id="form-${item.product.id}" action="<c:url value='/cart/update.do'/>" method="post">
                    <tr>

                        <!-- Product Image -->
                        <td width="120">
                            <img src="<c:url value='/${item.product.imagePath}'/>"
                                 class="img-fluid rounded"
                                 style="max-height: 80px;">
                        </td>

                        <!-- Name -->
                        <td>
                            <strong>${item.product.name}</strong>
                        </td>

                        <!-- Price with Discount -->
                        <td>
                            <c:choose>
                                <c:when test="${item.product.discount > 0}">
                                    <!-- Original price struck-through -->
                                    <span class="text-muted">
                                        <s><fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2"/></s>
                                    </span><br/>
                                    <!-- Discounted price -->
                                    $<fmt:formatNumber value="${item.product.priceAfterDiscount}" type="number" minFractionDigits="2"/>
                                </c:when>
                                <c:otherwise>
                                    $<fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2"/>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <!-- Quantity -->
                        <td>
                            <input type="number"
                                   name="qty"
                                   value="${item.quantity}"
                                   min="1"
                                   class="form-control text-center">

                            <!-- Hidden ID -->
                            <input type="hidden" name="id" value="${item.product.id}">
                        </td>

                        <!-- Row Total with Discount -->
                        <td>
                            $<fmt:formatNumber value="${item.product.priceAfterDiscount * item.quantity}" type="number" minFractionDigits="2"/>
                        </td>

                        <!-- Update Button -->
                        <td>
                            <a class="btn btn-primary btn-sm"
                               href="javascript:void(0);"
                               onclick="document.getElementById('form-${item.product.id}').submit();">
                                Update
                            </a>
                        </td>

                        <!-- Remove -->
                        <td>
                            <a href="<c:url value='/cart/remove.do?id=${item.product.id}'/>"
                               class="btn btn-danger btn-sm">
                                X
                            </a>
                        </td>

                    </tr>
                </form>
            </c:forEach>

            </tbody>
        </table>

        <!-- Cart Actions: Total + Empty Cart -->
        <div class="d-flex justify-content-between">

            <h4>
                Total:
                $<fmt:formatNumber value="${grandTotal}" type="number" minFractionDigits="2"/>
            </h4>

            <!-- EMPTY CART -->
            <a href="<c:url value='/cart/empty.do'/>"
               class="btn btn-outline-danger btn-lg"
               onclick="return confirm('Are you sure you want to empty the cart?');">
                Empty Cart
            </a>

        </div>

        <div class="mt-4 d-flex justify-content-end">
            <a href="<c:url value='/order/checkout.do'/>" class="btn btn-success btn-lg">
                Proceed to Checkout
            </a>
        </div>

    </c:if>
</div>
