<%-- 
    Document   : edit
    Created on : Dec 4, 2025, 12:56:20 AM
    Author     : PC
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<h2>Edit Product</h2>

<form method="post" action="<c:url value='/product/edit.do'/>">
    <input type="hidden" name="id" value="${product.id}" />

    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" name="name" class="form-control" value="${product.name}" required />
    </div>

    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="number" name="quantity" class="form-control" value="${product.quantity}" min="0" required />
    </div>

    <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
    </div>

    <div class="mb-3">
        <label class="form-label">Category</label>
        <select name="categoryId" class="form-select">
            <c:forEach var="cat" items="${categories}">
                <option value="${cat.id}" <c:if test="${cat.id == product.category.id}">selected</c:if>>
                    ${cat.name}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-3">
        <label class="form-label">Price</label>
        <input type="number" name="price" class="form-control" value="${product.price}" required />
    </div>

    <div class="mb-3">
        <label class="form-label">Discount (%)</label>
        <input type="number" name="discount" class="form-control" value="${product.discount}" min="0" max="1" step="0.01" />
    </div>

    <div class="mb-3">
        <label class="form-label">Current Image</label><br/>
        <img src="<c:url value='${product.imagePath}'/>" alt="${product.name}" width="150" />
    </div>

    <div class="mb-3">
        <label class="form-label">Upload New Image</label>
        <input type="file" name="image" class="form-control" />
    </div>

    <button type="submit" class="btn btn-primary">Update Product</button>
    <a href="<c:url value='${returnUrl}'/>" class="btn btn-secondary">Cancel</a>
</form>

