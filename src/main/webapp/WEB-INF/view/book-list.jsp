<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Books | Amazon Book Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <c:url var="appCss" value="/resources/css/app.css"/>
    <link rel="stylesheet" href="${appCss}">
</head>
<body>

<c:url var="booksUrl" value="/books/list"/>
<c:url var="categoriesUrl" value="/categories/list"/>
<c:url var="authorsUrl" value="/authors/list"/>
<c:url var="addUrl" value="/books/add"/>
<c:url var="deleteUrl" value="/books/delete"/>

<aside class="sidebar">
    <div class="brand">amazon<span> books</span></div>
    <div class="brand-subtitle">Library Management</div>
    <p class="menu-label">LIBRARY</p>
    <a href="${booksUrl}" class="nav-item-custom active"><span class="nav-icon">📚</span>Books</a>
    <a href="${categoriesUrl}" class="nav-item-custom"><span class="nav-icon">🏷️</span>Categories</a>
    <a href="${authorsUrl}" class="nav-item-custom"><span class="nav-icon">✍</span>Authors</a>
</aside>

<div class="main-content">
    <div class="top-bar">
        <p class="top-bar-title">Amazon Book Store / Books</p>
        <div class="top-user-pill">Library Manager</div>
    </div>

    <main class="page-content">
        <section class="library-hero">
            <div class="hero-copy">
                <p class="hero-label">YOUR PERSONAL LIBRARY</p>
                <h1 class="hero-title">Discover, organize and enjoy your books.</h1>
                <p class="hero-text">Keep your collection beautifully organized. Manage book information, categories and authors from one simple place.</p>
                <a href="${addUrl}" class="btn btn-brand">+ Add New Book</a>
            </div>
            <div class="hero-art">
                <div class="book-stack">
                    <div class="book-shape book-one">STORIES</div>
                    <div class="book-shape book-two">KNOWLEDGE</div>
                    <div class="book-shape book-three">LIBRARY</div>
                </div>
            </div>
        </section>

        <section class="stat-row">
            <div class="stat-card peach"><div class="stat-icon">📖</div><div><div class="stat-label">Total Books</div><div class="stat-value">${fn:length(books)}</div></div></div>
            <div class="stat-card sage"><div class="stat-icon">🏷️</div><div><div class="stat-label">Categories</div><div class="stat-value">Organized</div></div></div>
            <div class="stat-card blue"><div class="stat-icon">✍</div><div><div class="stat-label">Authors</div><div class="stat-value">Connected</div></div></div>
        </section>

        <c:if test="${param.success == 'saved'}"><div class="alert alert-success">Book saved successfully.</div></c:if>
        <c:if test="${param.success == 'deleted'}"><div class="alert alert-success">Book deleted successfully.</div></c:if>
        <c:if test="${param.error == 'notFound'}"><div class="alert alert-danger">Book not found.</div></c:if>

        <section class="content-card">
            <div class="card-header-custom">
                <div><h2>My Book Collection</h2><p class="mb-0">Browse and manage all books in your library.</p></div>
                <a href="${addUrl}" class="btn btn-brand">+ Add Book</a>
            </div>

            <c:choose>
                <c:when test="${empty books}">
                    <div class="empty-state"><div class="empty-icon">📚</div><h2 class="h4 font-weight-bold">Your shelf is empty</h2><p class="text-muted">Add your first book and start building your collection.</p><a href="${addUrl}" class="btn btn-brand">Add First Book</a></div>
                </c:when>
                <c:otherwise>
                    <div class="book-grid">
                        <c:forEach var="book" items="${books}">
                            <c:url var="detailsUrl" value="/books/details"><c:param name="id" value="${book.id}"/></c:url>
                            <c:url var="editUrl" value="/books/edit"><c:param name="id" value="${book.id}"/></c:url>

                            <article class="book-card">
                                <div class="book-cover-zone">
                                    <c:choose>
                                        <c:when test="${not empty book.bookDetails and not empty book.bookDetails.isbn}">
                                            <img class="book-cover"
                                                 src="https://covers.openlibrary.org/b/isbn/${book.bookDetails.isbn}-M.jpg?default=false"
                                                 alt="${book.title} cover"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                            <div class="cover-placeholder" style="display:none;"><span>AMAZON BOOKS</span><strong><c:out value="${book.title}"/></strong></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="cover-placeholder"><span>AMAZON BOOKS</span><strong><c:out value="${book.title}"/></strong></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="book-card-body">
                                    <h3 class="book-card-title"><c:out value="${book.title}"/></h3>
                                    <div class="book-price">$<c:out value="${book.price}"/></div>

                                    <div class="tags-row">
                                        <c:choose>
                                            <c:when test="${empty book.categories}"><span class="text-muted">No category</span></c:when>
                                            <c:otherwise><c:forEach var="category" items="${book.categories}"><span class="category-tag"><c:out value="${category.name}"/></span></c:forEach></c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="tags-row">
                                        <c:choose>
                                            <c:when test="${empty book.authors}"><span class="text-muted">No author</span></c:when>
                                            <c:otherwise><c:forEach var="author" items="${book.authors}"><span class="author-tag"><c:out value="${author.name}"/></span></c:forEach></c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="book-actions">
                                        <a href="${detailsUrl}" class="btn btn-details btn-sm">Details</a>
                                        <a href="${editUrl}" class="btn btn-edit btn-sm">Edit</a>
                                        <form action="${deleteUrl}" method="post" class="d-inline-block" onsubmit="return confirm('Are you sure you want to delete this book? Categories and authors will remain.');">
                                            <input type="hidden" name="id" value="${book.id}">
                                            <button type="submit" class="btn btn-delete btn-sm">Delete</button>
                                        </form>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
    </main>
</div>
</body>
</html>
