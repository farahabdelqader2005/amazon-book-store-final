<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Book Details | Amazon Book Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <c:url var="appCss" value="/resources/css/app.css"/>
    <link rel="stylesheet" href="${appCss}">
</head>
<body>

<c:url var="booksUrl" value="/books/list"/>
<c:url var="categoriesUrl" value="/categories/list"/>
<c:url var="authorsUrl" value="/authors/list"/>
<c:url var="editUrl" value="/books/edit"><c:param name="id" value="${book.id}"/></c:url>

<aside class="sidebar">
    <div class="brand">amazon<span> books</span></div>
    <div class="brand-subtitle">Library Management</div>
    <p class="menu-label">LIBRARY</p>
    <a href="${booksUrl}" class="nav-item-custom active"><span class="nav-icon">📚</span>Books</a>
    <a href="${categoriesUrl}" class="nav-item-custom"><span class="nav-icon">🏷️</span>Categories</a>
    <a href="${authorsUrl}" class="nav-item-custom"><span class="nav-icon">✍</span>Authors</a>
</aside>

<div class="main-content">
    <div class="top-bar"><p class="top-bar-title">Amazon Book Store / Book Details</p></div>

    <main class="page-content">
        <div class="details-card">
            <a href="${booksUrl}" class="btn btn-secondary mb-4">&larr; Back to Books</a>

            <h1 class="details-title"><c:out value="${book.title}"/></h1>
            <div class="book-price mt-2">$<c:out value="${book.price}"/></div>

            <div class="details-section">
                <h5>Categories</h5>
                <c:choose>
                    <c:when test="${empty book.categories}"><span class="text-muted">No category</span></c:when>
                    <c:otherwise><c:forEach var="category" items="${book.categories}"><span class="category-tag"><c:out value="${category.name}"/></span></c:forEach></c:otherwise>
                </c:choose>
            </div>

            <div class="details-section">
                <h5>Authors</h5>
                <c:choose>
                    <c:when test="${empty book.authors}"><span class="text-muted">No author</span></c:when>
                    <c:otherwise><c:forEach var="author" items="${book.authors}"><span class="author-tag"><c:out value="${author.name}"/></span></c:forEach></c:otherwise>
                </c:choose>
            </div>

            <div class="details-section">
                <h5>Book Details</h5>
                <c:choose>
                    <c:when test="${empty book.bookDetails}">
                        <p class="text-muted mb-0">No additional details available.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <div class="col-md-6 mb-3"><strong>ISBN</strong><br><c:out value="${book.bookDetails.isbn}"/></div>
                            <div class="col-md-6 mb-3"><strong>Publisher</strong><br><c:out value="${book.bookDetails.publisher}"/></div>
                            <div class="col-md-6 mb-3"><strong>Number of Pages</strong><br><c:out value="${book.bookDetails.numberOfPages}"/></div>
                            <div class="col-md-6 mb-3"><strong>Language</strong><br><c:out value="${book.bookDetails.language}"/></div>
                            <div class="col-md-6 mb-3"><strong>Publication Date</strong><br><c:out value="${book.bookDetails.publicationDate}"/></div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <a href="${editUrl}" class="btn btn-edit px-4 mt-3">Edit Book</a>
        </div>
    </main>
</div>
</body>
</html>
