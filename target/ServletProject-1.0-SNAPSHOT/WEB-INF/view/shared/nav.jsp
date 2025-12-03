<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value='/home/index.do'/>">WebShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/home/index.do'/>">Home</a>
                </li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/order/index.do'/>">Orders Tracking</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/product/index.do?page=1'/>">Products</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.role == 'customer'}">
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/cart/index.do'/>">Cart (${cart.size}) </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/product/index.do?page=1'/>">Shopping</a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/user/logout.do'/>">
                                Logout (${sessionScope.user.username})
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a href="<c:url value='/user/login.do'/>" class="nav-link">Login</a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/user/register.do'/>" class="nav-link">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
