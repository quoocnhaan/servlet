<%-- 
    Document   : login
    Created on : Dec 3, 2025, 9:05:38 PM
    Author     : PC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- The Login Modal -->
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-4">

            <h3 class="text-center mb-3">Login</h3>

            <!-- Display error message -->
            <c:if test="${message != null}">
                <div class="alert alert-danger">${message}</div>
            </c:if>

            <form action="<c:url value='/user/login.do' />" method="post">

                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" 
                           class="form-control" 
                           id="username" 
                           name="username" 
                           placeholder="Enter username" 
                           required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" 
                           class="form-control" 
                           id="password" 
                           name="password" 
                           placeholder="Enter password" 
                           required>
                </div>

                <div class="form-check mb-3">
                    <input class="form-check-input" 
                           type="checkbox" 
                           name="remember" 
                           id="remember">
                    <label class="form-check-label" for="remember">
                        Remember me
                    </label>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Login</button>
                    <a href="<c:url value='/user/register.do'/>" class="nav-link">Don't have account? Register</a>
                </div>
            </form>
        </div>
    </div>
</div>
