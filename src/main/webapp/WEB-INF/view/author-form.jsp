<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${empty author.id ? 'Add Author' : 'Edit Author'} | Amazon Book Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <c:url var="appCss" value="/resources/css/app.css"/>
    <link rel="stylesheet" href="${appCss}">
</head>
<body class="author-page">

<c:url var="booksUrl" value="/books/list"/>
<c:url var="categoriesUrl" value="/categories/list"/>
<c:url var="authorsUrl" value="/authors/list"/>
<c:url var="saveUrl" value="/authors/save"/>

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
        <p class="top-bar-title">Amazon Book Store / ${empty author.id ? 'Add Author' : 'Edit Author'}</p>
    </div>

    <main class="page-content">
        <div class="page-heading">
            <p class="section-label">AUTHOR MANAGEMENT</p>
            <h1 class="h2 page-title">${empty author.id ? 'Add New Author' : 'Edit Author'}</h1>
            <p class="text-muted">Enter the author name below.</p>
        </div>

        <div class="form-card">
            <form:form action="${saveUrl}" method="post" modelAttribute="author">
                <form:hidden path="id"/>

                <div class="form-group">
                    <label for="name">Author Name</label>
                    <form:input path="name" id="name" cssClass="form-control" maxlength="255" placeholder="e.g. Robert C. Martin"/>
                    <form:errors path="name" cssClass="text-danger small"/>
                </div>

                <button type="submit" class="btn btn-brand px-4">${empty author.id ? 'Create Author' : 'Save Changes'}</button>
                <a href="${authorsUrl}" class="btn btn-secondary px-4 ml-2">Cancel</a>
            </form:form>
        </div>
    </main>
</div>
</body>
</html>
