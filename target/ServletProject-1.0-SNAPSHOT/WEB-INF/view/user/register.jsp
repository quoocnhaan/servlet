<%-- 
    Document   : register
    Created on : Dec 3, 2025, 9:05:45 PM
    Author     : PC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Register Modal -->
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-5">

            <h3 class="text-center mb-3">Register</h3>

            <!-- Error Message -->
            <c:if test="${message != null}">
                <div class="alert alert-danger">${message}</div>
            </c:if>

            <form action="<c:url value='/user/register.do' />" method="post">

                <div class="mb-3">
                    <label for="regUsername" class="form-label">Username</label>
                    <input type="text"
                           class="form-control"
                           id="regUsername"
                           name="username"
                           placeholder="Enter username"
                           required>
                </div>


                <div class="mb-3">
                    <label for="regFullName" class="form-label">Full Name</label>
                    <input type="text"
                           class="form-control"
                           id="regFullName"
                           name="fullName"
                           placeholder="Enter full name"
                           required>
                </div>

                <div class="mb-3">
                    <label for="regEmail" class="form-label">Email</label>
                    <input type="email"
                           class="form-control"
                           id="regEmail"
                           name="email"
                           placeholder="Enter email"
                           required>
                </div>

                <div class="mb-3">
                    <label for="regPassword" class="form-label">Password</label>
                    <input type="password"
                           class="form-control"
                           id="regPassword"
                           name="password"
                           placeholder="Enter password"
                           required>
                </div>

                <div class="mb-3">
                    <label for="regConfirmPassword" class="form-label">Confirm Password</label>
                    <input type="password"
                           class="form-control"
                           id="regConfirmPassword"
                           name="confirmPassword"
                           placeholder="Confirm password"
                           required>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Register</button>
                    <a href="<c:url value='/user/login.do'/>" class="nav-link">Back to Login</a>
                </div>

            </form>

        </div>
    </div>
</div>


