<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="<c:url value='/css/error.css'/>">
</head>

<body>
    <div class="error-page">

        <div class="error-box">
            <div class="error-code">
                ${requestScope['javax.servlet.error.status_code']}
            </div>

            <div class="error-message">
                <c:choose>
                    <c:when test="${not empty message}">
                        ${message}
                    </c:when>
                    <c:when test="${not empty requestScope['javax.servlet.error.message']}">
                        ${requestScope['javax.servlet.error.message']}
                    </c:when>
                    <c:otherwise>
                        Something went wrong. Please try again later.
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="error-actions">
                <a href="<c:url value='/'/>" class="btn-primary">Go Home</a>
                <a href="javascript:history.back()" class="btn-secondary">Go Back</a>
            </div>
        </div>

    </div>
</body>
</html>
