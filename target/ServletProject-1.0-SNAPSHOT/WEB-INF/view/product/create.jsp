<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-4">

    <h2 class="mb-4">Add New Product</h2>

    <!-- Back to list -->
    <a href="<c:url value='/product/index.do?page=1'/>" class="btn btn-secondary mb-3">
        ← Back to Product List
    </a>
    <c:if test="${message != null}">
        <div class="alert alert-danger">${message}</div>
    </c:if>
    <!-- Product Create Form -->
    <form action="<c:url value='/product/create.do?returnUrl=${returnUrl}'/>" method="post" class="row g-3">

        <!-- Product Name -->
        <div class="col-md-6">
            <label class="form-label">Product Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>

        <!-- Price -->
        <div class="col-md-3">
            <label class="form-label">Price</label>
            <input type="number" step="0.01" name="price" class="form-control" required>
        </div>

        <!-- Discount -->
        <div class="col-md-3">
            <label class="form-label">Discount (%)</label>
            <input type="number" step="0.01" name="discount" class="form-control" value="0">
        </div>

        <!-- Quantity -->
        <div class="col-md-3">
            <label class="form-label">Quantity</label>
            <input type="number" name="quantity" class="form-control" required>
        </div>

        <!-- Category -->
        <div class="col-md-6">
            <label class="form-label">Category</label>
            <select name="categoryId" class="form-select">
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.name}</option>
                </c:forEach>
            </select>
        </div>

        <!-- Image Upload -->
        <div class="col-md-6">
            <label class="form-label">Product Image</label>
            <input type="text" name="image" class="form-control" placeholder="example.jpg">
        </div>

        <!-- Description -->
        <div class="col-md-12">
            <label class="form-label">Description</label>
            <textarea name="description" rows="4" class="form-control"></textarea>
        </div>

        <!-- Submit -->
        <div class="col-12 mt-3">
            <button type="submit" class="btn btn-primary">Save Product</button>
        </div>

    </form>
</div>
