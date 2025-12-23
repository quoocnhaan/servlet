<%-- 
    Document   : login
    Created on : Dec 3, 2025, 9:05:38 PM
    Author     : PC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- The Login Modal -->
<div class="auth-body">

    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <div class="logo">
                    Click<span>&</span>Clack
                </div>
                <h1>Welcome Back</h1>
                <p>Log in to manage your orders and profile.</p>
            </div>

            <form action="<c:url value='/user/login.do' />" method="post" class="auth-form">
                <div class="form-group">
                    <label>Username</label>
                    <div class="input-with-icon">
<!--                        <i class="fa-solid fa-envelope"></i>-->
                        <input id="username" name="username" type="text" placeholder="Enter Username" required>
                    </div>
                </div>

                <div class="form-group">
                    <div class="label-row">
                        <label>Password</label>
                    </div>
                    <div class="input-with-icon">
<!--                        <i class="fa-solid fa-lock"></i>-->
                        <input id="password" name="password" type="password" placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn-auth">Login to Account</button>
            </form>

            <div class="auth-footer">
                <p>Don't have an account? <a href="<c:url value='/user/register.do'/>">Create one</a></p>
            </div>
        </div>
        <a href="<c:url value='/home/index.do'/>" class="back-home"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
    </div>
</div>


