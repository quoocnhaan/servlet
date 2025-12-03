<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title><c:out value="${pageTitle}"/></title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    </head>
    <body>

        <!-- Header -->
        <header class="bg-primary text-white p-3 mb-4">
            <div class="container">
                <h1 class="m-0">WebShop</h1>
            </div>
        </header>

        <!-- Navbar -->
        <jsp:include page="/WEB-INF/view/shared/nav.jsp" />


        <!-- Main Content -->
        <main class="container mt-4">
            <jsp:include page="/WEB-INF/view/${controller}/${action}.jsp" />

        </main>

        <!-- Footer -->
        <footer class="bg-dark text-white p-3 mt-4">
            <div class="container text-center">
                &copy; 2025 WebShop. All rights reserved.
            </div>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

<div class="modal" id="loginModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="<c:url value='/user/login.do' />" method="post">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">

                    <div class="mb-3 mt-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               placeholder="Enter email" 
                               name="email" 
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="pwd" class="form-label">Password:</label>
                        <input type="password" 
                               class="form-control" 
                               id="pwd" 
                               placeholder="Enter password" 
                               name="password" 
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

                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-sm btn-outline-primary">
                        Login
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-danger" data-bs-dismiss="modal">
                        Cancel
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>