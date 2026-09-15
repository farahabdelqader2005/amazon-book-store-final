<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Authors | Amazon Book Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <c:url var="appCss" value="/resources/css/app.css"/>
    <link rel="stylesheet" href="${appCss}">
</head>
<body class="author-page">

<c:url var="booksUrl" value="/books/list"/>
<c:url var="categoriesUrl" value="/categories/list"/>
<c:url var="authorsUrl" value="/authors/list"/>
<c:url var="addUrl" value="/authors/add"/>
<c:url var="deleteUrl" value="/authors/delete"/>

<aside class="sidebar">
    <div class="brand">amazon<span> books</span></div>
    <div class="brand-subtitle">Library Management</div>
    <p class="menu-label">LIBRARY</p>
    <a href="${booksUrl}" class="nav-item-custom"><span class="nav-icon">📚</span>Books</a>
    <a href="${categoriesUrl}" class="nav-item-custom"><span class="nav-icon">🏷️</span>Categories</a>
    <a href="${authorsUrl}" class="nav-item-custom active"><span class="nav-icon">✍</span>Authors</a>
</aside>

<div class="main-content">
    <div class="top-bar">
        <p class="top-bar-title">Amazon Book Store / Authors</p>
        <div class="top-user-pill">Library Manager</div>
    </div>

    <main class="page-content">
        <section class="library-hero">
            <div class="hero-copy">
                <p class="hero-label">THE PEOPLE BEHIND THE BOOKS</p>
                <h1 class="hero-title">Celebrate the authors behind every story.</h1>
                <p class="hero-text">Manage the writers connected to your collection and keep every book linked to its authors.</p>
                <a href="${addUrl}" class="btn btn-brand">+ Add New Author</a>
            </div>

            <div class="hero-art">
                <div class="author-visual">
                    <div class="author-avatar"></div>
                    <div class="author-book"></div>
                    <div class="author-total">
                        <span class="author-total-title">TOTAL AUTHORS</span>
                        <span class="author-total-number">${fn:length(authors)}</span>
                    </div>
                </div>
            </div>
        </section>

        <c:if test="${param.success == 'saved'}">
            <div class="alert alert-success">Author saved successfully.</div>
        </c:if>
        <c:if test="${param.success == 'deleted'}">
            <div class="alert alert-success">Author deleted successfully.</div>
        </c:if>
        <c:if test="${param.error == 'notFound'}">
            <div class="alert alert-danger">Author not found.</div>
        </c:if>

        <section class="content-card">
            <div class="card-header-custom">
                <div>
                    <h2>My Authors</h2>
                    <p class="mb-0">Manage the authors connected to your books.</p>
                </div>
                <a href="${addUrl}" class="btn btn-brand">+ Add Author</a>
            </div>

            <c:choose>
                <c:when test="${empty authors}">
                    <div class="empty-state">
                        <div class="empty-icon">✍️</div>
                        <h2 class="h4 font-weight-bold">No authors yet</h2>
                        <p class="text-muted">Add your first author to start connecting writers with books.</p>
                        <a href="${addUrl}" class="btn btn-brand">Add First Author</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="author-grid">
                        <c:forEach var="author" items="${authors}">
                            <c:url var="editUrl" value="/authors/edit">
                                <c:param name="id" value="${author.id}"/>
                            </c:url>

                            <article class="author-card">
                                <div class="card-decoration"></div>
                                <div class="author-card-icon">✍️</div>
                                <div class="management-card-id">AUTHOR #${author.id}</div>
                                <h3 class="management-card-title"><c:out value="${author.name}"/></h3>
                                <div class="management-actions">
                                    <a href="${editUrl}" class="btn btn-edit btn-sm">Edit</a>
                                    <form action="${deleteUrl}" method="post" class="d-inline-block"
                                          onsubmit="return confirm('Are you sure you want to delete this author? Books written by this author will remain in the system.');">
                                        <input type="hidden" name="id" value="${author.id}">
                                        <button type="submit" class="btn btn-delete btn-sm">Delete</button>
                                    </form>
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
