<%-- 
    Document   : product
    Created on : Dec 23, 2025, 10:12:32 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>


<main class="admin-main">
    <header class="admin-header">
        <h1>Product Management</h1>
        <button class="btn btn-primary" onclick="openProductModal()">
            + Add New Product
        </button>
    </header>

    <div class="admin-stats">
        <div class="stat-card">
            <p>Total Products</p>
            <h3>${total}</h3>
        </div>
        <div class="stat-card">
            <p>Out of Stock</p>
            <h3 class="text-danger">${outStock}</h3>
        </div>
    </div>

    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Discount</th>
                    <th>Description</th>
                    <th>Created At</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            <tbody id="productTableBody">
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>
                            <div class="product-cell">
                                <div class="img-mini">
                                    <img  src="<c:url value='/${product.imagePath}'/>" alt="Product">
                                </div>
                                <span>${product.name}</span>
                            </div>
                        </td>
                        <td><span class="badge-cat">${product.category.name}</span></td>
                        <td>
                            <fmt:formatNumber value="${product.price}" type="currency"/>
                        </td>
                        <td>${product.quantity}</td>
                        <td>
                            <fmt:formatNumber value="${product.discount}" type="percent"/>
                        </td>
                        <td>
                            ${product.description}                                
                        </td>
                        <td>
                            ${product.createdAt}                                
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${product.quantity > 0}">
                                    <span class="status-pill available">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-pill out">Out of Stock</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="actions">
                            <button class="btn-icon edit"
                                    onclick="openEditProductModal(
                                                    '${product.id}',
                                                    '${product.name}',
                                                    '${product.price}',
                                                    '${product.quantity}',
                                                    '${product.discount}',
                                                    '${product.category.id}',
                                                    '${product.imagePath}',
                                                    '${product.description}'
                                                    )">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-icon delete"><i class="fas fa-trash"></i></button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>


<!-- MODAL -->
<div id="productModal" class="modal-overlay">
    <div class="modal-box">

        <div class="modal-header">
            <h2>Add New Product</h2>
            <span class="modal-close" onclick="closeProductModal()">&times;</span>
        </div>

        <!-- 🔽 YOUR EXISTING FORM GOES HERE 🔽 -->
        <form method="post" class="row g-3">

            <input type="hidden" name="id" id="productId">

            <!-- Product Name -->
            <div class="col-md-6 mb-30">
                <label class="form-label">Product Name</label>
                <input type="text" name="name" id="productName" class="form-control" required>
            </div>

            <!-- Price -->
            <div class="col-md-3 mb-30">
                <label class="form-label">Price</label>
                <input type="number" step="0.01" name="price" id="productPrice" class="form-control" required>
            </div>

            <!-- Discount -->
            <div class="col-md-3 mb-30">
                <label class="form-label">Discount</label>
                <input type="number" step="0.01" name="discount" id="productDiscount" class="form-control" value="0" max="1" min="0">
            </div>

            <!-- Quantity -->
            <div class="col-md-3 mb-30">
                <label class="form-label">Quantity</label>
                <input type="number" name="quantity" class="form-control" id="productQuantity" required>
            </div>

            <!-- Category -->
            <div class="col-md-6 mb-30">
                <label class="form-label">Category</label>
                <select name="categoryId" class="form-select" id="productCategory" >
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Image Upload -->          
            <div class="col-md-6 mb-30">
                <label class="form-label">Product Image</label>
                <input type="text" name="image" id="productImagePath" class="form-control" placeholder="example.jpg">
            </div>

            <!-- Description -->
            <div class="form-group full mb-30">
                <label class="form-label">Description</label>
                <textarea name="description" id="productDescription"></textarea>
            </div>


            <!-- Submit -->
            <div class="col-12 mt-3 mb-30">
                <button type="submit" class="btn btn-primary">Save Product</button>
            </div>

        </form>

    </div>

