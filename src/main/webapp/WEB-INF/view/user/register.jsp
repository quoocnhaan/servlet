<%-- 
    Document   : register
    Created on : Dec 3, 2025, 9:05:45 PM
    Author     : PC
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Register Modal -->
<div class="auth-body">

    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <div class="logo">
                    Click<span>&</span>Clack
                </div>
                <h1>Create Account</h1>
                <p>Join our community of keyboard enthusiasts.</p>
            </div>

            <form action="<c:url value='/user/register.do'/>" method="post" class="auth-form">
                <div class="form-group">
                    <label>Full Name</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-user"></i>
                        <input id="regFullName" name="fullName"  type="text" placeholder="Quoc Nhan" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-user"></i>
                        <input id="regUsername" name="username" type="text" placeholder="quocnhan56" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-envelope"></i>
                        <input id="regEmail" name="email" type="email" placeholder="name@example.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-lock"></i>
                        <input id="regPassword" name="password" type="password" placeholder="Minimum 8 characters" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <div class="input-with-icon">
                        <i class="fa-solid fa-lock"></i>
                        <input id="regConfirmPassword" name="confirmPassword" type="password" placeholder="Minimum 8 characters" required>
                    </div>
                </div>

                <div class="terms-check">
                    <input type="checkbox" id="terms" required>
                    <label for="terms">I agree to the <a href="#">Terms & Conditions</a></label>
                </div>

                <button type="submit" class="btn-auth">Create Account</button>
            </form>

            <div class="auth-footer">
                <p>Already have a account? <a href="<c:url value='/user/login.do'/>">Log in here</a></p>
            </div>
        </div>
        <a href="<c:url value='/home/index.do'/>" class="back-home"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
    </div>

</div>


