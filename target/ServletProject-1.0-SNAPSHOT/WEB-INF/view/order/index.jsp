<%-- 
    Document   : index
    Created on : Dec 4, 2025, 2:18:57 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-4">
    <c:if test="${message != null}">
        <div class="alert alert-danger">${message}</div>
    </c:if>
    <!-- PAGE TITLE -->
    <h2>Order Management</h2>
    <hr />

    <!-- ===================== -->
    <!-- ORDER LIST SECTION    -->
    <!-- ===================== -->
    <h4>Orders</h4>

    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>Order ID</th>
                <th>User</th>
                <th>Date</th>
                <th>Status</th>
                <th>Total Price</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.id}</td>
                    <td>${order.user.username}</td>
                    <td>${order.orderDate}</td>
                    <td>${order.status}</td>
                    <td>
                        <fmt:formatNumber value="${order.total}" type="currency"/>
                    </td>

                    <td>
                        <!-- View details button -->
                        <button class="btn btn-sm btn-primary" 
                                data-bs-toggle="modal" 
                                data-bs-target="#orderModal${order.id}">
                            View
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- ========================== -->
    <!-- ORDER DETAIL MODALS        -->
    <!-- ========================== -->
    <c:forEach var="order" items="${orders}">
        <div class="modal fade" id="orderModal${order.id}">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title">Order #${order.id} Details</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <p><strong>User:</strong> ${order.user.username}</p>
                        <p><strong>Date:</strong> ${order.orderDate}</p>

                        <h6>Items:</h6>

                        <table class="table table-sm table-bordered">
                            <thead class="table-secondary">
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
                                        <td><fmt:formatNumber value="${item.unitPrice}" type="currency"/></td>
                                        <td><fmt:formatNumber value="${item.total}" type="currency"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Update status -->
                        <h6 class="mt-3">Update Status:</h6>

                        <form action="<c:url value='/order/edit.do' />" method="post">
                            <input type="hidden" name="id" value="${order.id}" />

                            <select name="status" class="form-select mb-3">
                                <option value="New"           ${order.status == 'New' ? 'selected' : ''}>New</option>
                                <option value="Shipped"       ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                <option value="Paid"          ${order.status == 'Paid' ? 'selected' : ''}>Paid</option>
                            </select>

                            <button type="submit" class="btn btn-success">Update</button>
                        </form>

                    </div>

                </div>
            </div>
        </div>
    </c:forEach>

    <hr class="mt-5" />

    <!-- ===================== -->
    <!-- REVENUE REPORT        -->
    <!-- ===================== -->
    <h4>Revenue Report</h4>

    <form action="<c:url value='/order/revenue.do' />" method="get" class="row g-3 mt-2">

        <div class="col-md-3">
            <label class="form-label">Filter By</label>
            <select name="type" class="form-select">
                <option value="day" ${currentType == 'day' ? 'selected' : ''}>Day</option>
                <option value="week" ${currentType == 'week' ? 'selected' : ''}>Week</option>
                <option value="month" ${currentType == 'month' ? 'selected' : ''}>Month</option>
                <option value="year" ${currentType == 'year' ? 'selected' : ''}>Year</option>
            </select>
        </div>

        <div class="col-md-3 align-self-end">
            <button type="submit" class="btn btn-primary">View Revenue</button>
        </div>
    </form>

    <!-- Revenue result if available -->
    <c:if test="${not empty revenue}">
        <div class="alert alert-info mt-4">
            <h5>Total Revenue: <fmt:formatNumber value="${revenue}" type="currency"/></h5>
        </div>
    </c:if>

</div>

