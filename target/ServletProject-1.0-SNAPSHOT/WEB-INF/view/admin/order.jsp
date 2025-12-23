<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<!-- MAIN -->
<main class="admin-main">

    <header class="admin-header">
        <h1>Order Management</h1>
    </header>

    <!-- ORDERS TABLE -->
    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>#${order.id}</td>
                        <td>${order.user.username}</td>
                        <td>${order.orderDate}</td>
                        <td>
                            <span class="status-pill ${order.status}">
                                ${order.status}
                            </span>
                        </td>
                        <td>
                            <fmt:formatNumber value="${order.total}" type="currency"/>
                        </td>
                        <td class="actions">
                            <button class="btn-icon edit"
                                    onclick="openOrderModal('orderModal${order.id}')">
                                <i class="fas fa-eye"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- ORDER MODALS -->
    <c:forEach var="order" items="${orders}">
        <div class="order-modal" id="orderModal${order.id}">
            <div class="order-modal-dialog">
                <div class="order-modal-content">

                    <div class="order-modal-header">
                        <h3>Order #${order.id}</h3>
                        <span class="modal-close"
                              onclick="closeOrderModal('orderModal${order.id}')">
                            &times;
                        </span>
                    </div>

                    <div class="order-modal-body">
                        <p><strong>User:</strong> ${order.user.username}</p>
                        <p><strong>Date:</strong> ${order.orderDate}</p>

                        <h4>Items</h4>
                        <table class="admin-table small">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Qty</th>
                                    <th>Unit Price</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.items}">
                                    <tr>
                                        <td>${item.product.name}</td>
                                        <td>${item.quantity}</td>
                                        <td>
                                            <fmt:formatNumber value="${item.unitPrice}" type="currency"/>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${item.total}" type="currency"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <h4 class="mt-20">Update Status</h4>

                        <form action="<c:url value='/order/edit.do'/>" method="post">
                            <input type="hidden" name="id" value="${order.id}" />

                            <select name="status" class="form-select mt-10">
                                <option value="New"     ${order.status == 'New' ? 'selected' : ''}>New</option>
                                <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                <option value="Paid"    ${order.status == 'Paid' ? 'selected' : ''}>Paid</option>
                            </select>

                            <button class="btn btn-primary mt-20" type="submit">
                                Update Status
                            </button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </c:forEach>

    <!-- REVENUE -->
    <div class="admin-section mt-50">
        <h2>Revenue Report</h2>

        <form action="<c:url value='/order/revenue.do'/>" method="get" class="filter-row mt-10">
            <select name="type" class="form-select ">
                <option value="day"   ${currentType == 'day' ? 'selected' : ''}>Day</option>
                <option value="week"  ${currentType == 'week' ? 'selected' : ''}>Week</option>
                <option value="month" ${currentType == 'month' ? 'selected' : ''}>Month</option>
                <option value="year"  ${currentType == 'year' ? 'selected' : ''}>Year</option>
            </select>

            <button class="btn btn-primary mt-20">View</button>
        </form>

        <c:if test="${not empty revenue}">
            <div class="stat-card mt-20">
                <p>Total Revenue</p>
                <h3>
                    <fmt:formatNumber value="${revenue}" type="currency"/>
                </h3>
            </div>
        </c:if>
    </div>
</main>

