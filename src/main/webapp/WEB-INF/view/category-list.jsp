<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Categories | Amazon Book Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <c:url var="appCss" value="/resources/css/app.css"/>
    <link rel="stylesheet" href="${appCss}">
</head>
<body class="category-page">

<c:url var="booksUrl" value="/books/list"/>
<c:url var="categoriesUrl" value="/categories/list"/>
<c:url var="authorsUrl" value="/authors/list"/>
<c:url var="addUrl" value="/categories/add"/>
<c:url var="deleteUrl" value="/categories/delete"/>

<aside class="sidebar">
    <div class="brand">amazon<span> books</span></div>
    <div class="brand-subtitle">Library Management</div>
    <p class="menu-label">LIBRARY</p>
    <a href="${booksUrl}" class="nav-item-custom"><span class="nav-icon">📚</span>Books</a>
    <a href="${categoriesUrl}" class="nav-item-custom active"><span class="nav-icon">🏷️</span>Categories</a>
    <a href="${authorsUrl}" class="nav-item-custom"><span class="nav-icon">✍</span>Authors</a>
</aside>

<div class="main-content">
    <div class="top-bar">
        <p class="top-bar-title">Amazon Book Store / Categories</p>
        <div class="top-user-pill">Library Manager</div>
    </div>

    <main class="page-content">
        <section class="library-hero">
            <div class="hero-copy">
                <p class="hero-label">ORGANIZE YOUR COLLECTION</p>
                <h1 class="hero-title">Every great library starts with organization.</h1>
                <p class="hero-text">Create and manage categories that keep your books easy to browse and beautifully organized.</p>
                <a href="${addUrl}" class="btn btn-brand">+ Add New Category</a>
            </div>

            <div class="hero-art">
                <div class="category-visual">
                    <div class="folder-shape folder-one"></div>
                    <div class="folder-shape folder-two"></div>
                    <div class="folder-shape folder-three"></div>
                    <div class="category-total">
                        <span class="category-total-title">TOTAL CATEGORIES</span>
                        <span class="category-total-number">${totalCategories}</span>
                    </div>
                </div>
            </div>
        </section>

        <c:if test="${param.success == 'saved'}">
            <div class="alert alert-success">Category saved successfully.</div>
        </c:if>
        <c:if test="${param.success == 'deleted'}">
            <div class="alert alert-success">Category deleted successfully.</div>
        </c:if>
        <c:if test="${param.error == 'notFound'}">
            <div class="alert alert-danger">Category not found.</div>
        </c:if>

        <section class="content-card">
            <div class="card-header-custom">
                <div>
                    <h2>My Categories</h2>
                    <p class="mb-0">Manage the categories used across your library.</p>
                </div>
                <a href="${addUrl}" class="btn btn-brand">+ Add Category</a>
            </div>

            <c:choose>
                <c:when test="${empty categories}">
                    <div class="empty-state">
                        <div class="empty-icon">🏷️</div>
                        <h2 class="h4 font-weight-bold">No categories yet</h2>
                        <p class="text-muted">Create your first category to organize your books.</p>
                        <a href="${addUrl}" class="btn btn-brand">Create First Category</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="category-grid">
                        <c:forEach var="category" items="${categories}">
                            <c:url var="editUrl" value="/categories/edit">
                                <c:param name="id" value="${category.id}"/>
                            </c:url>

                            <article class="category-card">
                                <div class="card-decoration"></div>
                                <div class="category-card-icon">🏷️</div>
                                <div class="management-card-id">CATEGORY #${category.id}</div>
                                <h3 class="management-card-title"><c:out value="${category.name}"/></h3>
                                <div class="management-actions">
                                    <a href="${editUrl}" class="btn btn-edit btn-sm">Edit</a>
                                    <form action="${deleteUrl}" method="post" class="d-inline-block"
                                          onsubmit="return confirm('Are you sure you want to delete this category? Books linked to this category will remain in the system.');">
                                        <input type="hidden" name="id" value="${category.id}">
                                        <button type="submit" class="btn btn-delete btn-sm">Delete</button>
                                    </form>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <c:if test="${totalPages > 1}">
                <div class="pagination-area d-flex justify-content-between align-items-center flex-wrap">
                    <div class="page-info">Page ${currentPage} of ${totalPages}</div>
                    <nav>
                        <ul class="pagination mb-0">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${categoriesUrl}?page=${currentPage - 1}">Previous</a>
                            </li>
                            <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                                <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${categoriesUrl}?page=${pageNumber}">${pageNumber}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${categoriesUrl}?page=${currentPage + 1}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </section>
    </main>
</div>
</body>
</html>
