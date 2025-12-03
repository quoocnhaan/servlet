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
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/cart'/>">Cart</a>
                        </li>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="<c:url value='/admin/dashboard'/>">Admin Dashboard</a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/auth?action=logout'/>">
                                Logout (${sessionScope.user.username})
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal" class="nav-link">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<c:url value='/auth?action=register'/>">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
