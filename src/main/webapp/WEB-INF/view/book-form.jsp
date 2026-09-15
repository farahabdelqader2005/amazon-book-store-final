<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${empty book.id ? 'Add Book' : 'Edit Book'} | Amazon Book Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <c:url var="appCss" value="/resources/css/app.css"/>
    <link rel="stylesheet" href="${appCss}">
</head>
<body>

<c:url var="booksUrl" value="/books/list"/>
<c:url var="categoriesUrl" value="/categories/list"/>
<c:url var="authorsUrl" value="/authors/list"/>
<c:url var="saveUrl" value="/books/save"/>

<aside class="sidebar">
    <div class="brand">amazon<span> books</span></div>
    <div class="brand-subtitle">Library Management</div>
    <p class="menu-label">LIBRARY</p>
    <a href="${booksUrl}" class="nav-item-custom active"><span class="nav-icon">📚</span>Books</a>
    <a href="${categoriesUrl}" class="nav-item-custom"><span class="nav-icon">🏷️</span>Categories</a>
    <a href="${authorsUrl}" class="nav-item-custom"><span class="nav-icon">✍</span>Authors</a>
</aside>

<div class="main-content">
    <div class="top-bar"><p class="top-bar-title">Amazon Book Store / ${empty book.id ? 'Add Book' : 'Edit Book'}</p></div>

    <main class="page-content">
        <div class="page-heading">
            <p class="section-label">BOOK MANAGEMENT</p>
            <h1 class="h2 page-title">${empty book.id ? 'Add New Book' : 'Edit Book'}</h1>
            <p class="text-muted">Enter the book information and connect it with categories and authors.</p>
        </div>

        <div class="form-card">
            <form:form action="${saveUrl}" method="post" modelAttribute="book">
                <form:hidden path="id"/>

                <div class="form-group">
                    <label for="title">Book Title</label>
                    <form:input path="title" id="title" cssClass="form-control" maxlength="255" placeholder="e.g. Clean Code"/>
                    <form:errors path="title" cssClass="text-danger small"/>
                </div>

                <div class="form-group">
                    <label for="price">Price</label>
                    <form:input path="price" id="price" type="number" step="0.01" min="0.01" cssClass="form-control" placeholder="e.g. 45.00"/>
                    <form:errors path="price" cssClass="text-danger small"/>
                </div>

                <div class="form-group">
                    <label>Categories</label>
                    <div class="selection-box">
                        <c:choose>
                            <c:when test="${empty categories}"><p class="text-muted mb-0">No categories available.</p></c:when>
                            <c:otherwise>
                                <c:forEach var="category" items="${categories}">
                                    <c:set var="categorySelected" value="false"/>
                                    <c:forEach var="selectedCategory" items="${book.categories}">
                                        <c:if test="${selectedCategory.id == category.id}"><c:set var="categorySelected" value="true"/></c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input type="checkbox" name="categoryIds" value="${category.id}" class="form-check-input" id="category-${category.id}" <c:if test="${categorySelected}">checked</c:if>>
                                        <label class="form-check-label" for="category-${category.id}"><c:out value="${category.name}"/></label>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="form-group">
                    <label>Authors</label>
                    <div class="selection-box">
                        <c:choose>
                            <c:when test="${empty authors}"><p class="text-muted mb-0">No authors available.</p></c:when>
                            <c:otherwise>
                                <c:forEach var="author" items="${authors}">
                                    <c:set var="authorSelected" value="false"/>
                                    <c:forEach var="selectedAuthor" items="${book.authors}">
                                        <c:if test="${selectedAuthor.id == author.id}"><c:set var="authorSelected" value="true"/></c:if>
                                    </c:forEach>
                                    <div class="form-check">
                                        <input type="checkbox" name="authorIds" value="${author.id}" class="form-check-input" id="author-${author.id}" <c:if test="${authorSelected}">checked</c:if>>
                                        <label class="form-check-label" for="author-${author.id}"><c:out value="${author.name}"/></label>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <hr class="my-4">
                <p class="section-label">BOOK DETAILS</p>

                <div class="form-group">
                    <label for="isbn">ISBN</label>
                    <form:input path="bookDetails.isbn" id="isbn" cssClass="form-control" placeholder="e.g. 9780132350884"/>
                </div>

                <div class="form-group">
                    <label for="publisher">Publisher</label>
                    <form:input path="bookDetails.publisher" id="publisher" cssClass="form-control" placeholder="e.g. Prentice Hall"/>
                </div>

                <div class="form-group">
                    <label for="numberOfPages">Number Of Pages</label>
                    <form:input path="bookDetails.numberOfPages" id="numberOfPages" type="number" min="1" cssClass="form-control" placeholder="e.g. 464"/>
                </div>

                <div class="form-group">
                    <label for="language">Language</label>
                    <form:input path="bookDetails.language" id="language" cssClass="form-control" placeholder="e.g. English"/>
                </div>

                <button type="submit" class="btn btn-brand px-4">${empty book.id ? 'Create Book' : 'Save Changes'}</button>
                <a href="${booksUrl}" class="btn btn-secondary px-4 ml-2">Cancel</a>
            </form:form>
        </div>
    </main>
</div>
</body>
</html>
