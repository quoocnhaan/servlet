<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-4">

    <h2 class="mb-4">Your Shopping Cart</h2>

    <c:if test="${empty cartItems}">
        <div class="alert alert-info">Your cart is empty.</div>
    </c:if>

    <c:if test="${not empty cartItems}">
        <form action="<c:url value='/cart/update'/>" method="post">

            <table class="table table-bordered align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Product</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th width="120">Quantity</th>
                        <th>Total</th>
                        <th>Remove</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="item" items="${cartItems}">
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

                            <!-- Price -->
                            <td>
                                $<fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2"/>
                    </td>

                    <!-- Quantity -->
                    <td>
                        <input type="number"
                               name="qty_${item.product.id}"
                               value="${item.quantity}"
                               min="1"
                               class="form-control text-center">
                    </td>

                    <!-- Row Total -->
                    <td>
                        $<fmt:formatNumber value="${item.product.price * item.quantity}"
                                       type="number"
                                       minFractionDigits="2"/>
                    </td>

                    <!-- Remove Button -->
                    <td>
                        <a href="<c:url value='/cart/remove?productId=${item.product.id}'/>"
                           class="btn btn-danger btn-sm">
                            X
                        </a>
                    </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Update Cart -->
            <div class="d-flex justify-content-between">

                <button type="submit" class="btn btn-primary">
                    Update Cart
                </button>

                <h4>Total:
                    $<fmt:formatNumber value="${grandTotal}" type="number" minFractionDigits="2"/>
                </h4>

            </div>

        </form>

        <div class="mt-4 d-flex justify-content-end">
            <a href="<c:url value='/checkout'/>" class="btn btn-success btn-lg">
                Proceed to Checkout
            </a>
        </div>

    </c:if>
</div>
