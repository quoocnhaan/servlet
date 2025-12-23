<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<fmt:setLocale value="en_US" scope="session" />

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Click & Clack | Premium Mechanical Keyboards</title>
        <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>

        <header class="main-header">
            <div class="container header-content">
                <div class="logo">
                    <a href="<c:url value='/home/index.do'/>">Click<span>&</span>Clack</a>
                </div>

                <nav class="nav-bar">
                    <ul class="nav-links">
                        <li>
                            <a href="<c:url value='/home/index.do'/>"
                               class="${nav == 'home' ? 'active' : ''}">
                                Home
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value='/product/index.do?page=1'/>"
                               class="${nav == 'shop' ? 'active' : ''}">
                                Shop
                            </a>
                        </li>
                        <li>
                            <a href="<c:url value='/cart/index.do'/>"
                               class="btn-icon ${nav == 'cart' ? 'active' : ''}">
                                <i class="fa-solid fa-cart-shopping"></i>
                                <span>Cart ${cart.size}</span>
                            </a>
                        </li>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <li class="user-account">
                                    <div class="user-profile">
                                        <img src="<c:url value='/images/user.png'/>" alt="User Avatar" class="avatar">
                                        <div class="user-details">
                                            <span class="user-name">${sessionScope.user.username}</span>
                                            <a href="<c:url value='/user/logout.do'/>" class="logout-link"><i class="fa-solid fa-right-from-bracket"></i>
                                                Logout</a>
                                        </div>
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="user-account">
                                    <div class="auth-guest">
                                        <a href="<c:url value='/user/login.do'/>" class="auth-link login">
                                            <i class="fa-solid fa-right-to-bracket"></i>
                                            <span>Login</span>
                                        </a>
                                        <span class="divider">|</span>
                                        <a href="<c:url value='/user/register.do'/>" class="auth-link register">
                                            <i class="fa-solid fa-user-plus"></i>
                                            <span>Register</span>
                                        </a>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </nav>
            </div>
        </header>

        <c:set var="isAdmin" value="${not empty sessionScope.user and sessionScope.user.role == 'admin'}"/>

        <c:if test="${isAdmin}">
            <div class="admin-body">

                <div class="admin-container">

                    <!-- SIDEBAR -->
                    <aside class="admin-sidebar">
                        <div class="logo"><i class="fas fa-keyboard"></i> KEEBSTATION</div>
                        <nav class="admin-nav">
                            <a href="<c:url value='/admin/product.do'/>" class="${(nav == null || nav == 'product') ? 'active' : ''}">
                                <i class="fas fa-box"></i> Products
                            </a>
                            <a href="<c:url value='/admin/order.do'/>" class="${nav == 'order' ? 'active' : ''}">
                                <i class="fas fa-shopping-cart"></i> Orders
                            </a>
                        </nav>
                    </aside>
                    <jsp:include page="/WEB-INF/view/${controller}/${action}.jsp" />
                </div>
            </div>

        </c:if>

        <c:if test="${not isAdmin}">
            <jsp:include page="/WEB-INF/view/${controller}/${action}.jsp" />
        </c:if>


        <footer class="footer">
            <div class="container">
                <p>&copy; 2025 Click & Clack Mechanical Keyboards. Built for enthusiasts.</p>
            </div>
        </footer>

        <script src="<c:url value='/js/script.js'/>"></script>


        <script>
            function openProductModal() {
                document.querySelector('.modal-header h2').innerText = 'Add New Product';
                document.querySelector('form').action = '<c:url value="/product/create.do"/>';
                document.getElementById('productId').value = '';
                document.getElementById('productName').value = '';
                document.getElementById('productPrice').value = '';
                document.getElementById('productQuantity').value = '';
                document.getElementById('productDescription').value = '';
                document.getElementById('productModal').style.display = 'flex';
            }

            function openEditProductModal(id, name, price, quantity, discount, categoryId, imagePath, description) {
                document.querySelector('.modal-header h2').innerText = 'Edit Product';
                document.querySelector('form').action = '<c:url value="/product/edit.do"/>';
                document.getElementById('productId').value = id;
                document.getElementById('productName').value = name;
                document.getElementById('productPrice').value = price;
                document.getElementById('productDiscount').value = discount;
                document.getElementById('productImagePath').value = imagePath;
                document.getElementById('productQuantity').value = quantity;
                document.getElementById('productDescription').value = description;
                document.getElementById('productCategory').value = categoryId;
                document.getElementById('productModal').style.display = 'flex';
            }
        </script> 


    </body>

</html>



