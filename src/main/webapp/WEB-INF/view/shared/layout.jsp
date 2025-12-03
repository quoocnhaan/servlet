
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="en_US" scope="session" />

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



