<%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Manage Products</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">

        <div class="container mt-5">
            <h2>Manage Products</h2>

            <!-- Search -->
            <form method="get" class="mb-3">
                <input type="text" name="search" value="${search}" placeholder="Search product..."
                    class="form-control w-25 d-inline" />
                <button class="btn btn-primary">Search</button>
            </form>

            <table class="table table-bordered shadow">
                <thead class="table-dark">
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty p.imagePath && p.imagePath.startsWith('http')}">
                                        <img src="${p.imagePath}" width="60" />
                                    </c:when>
                                    <c:when test="${not empty p.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${p.imagePath}" width="60" />
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">No Image</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${p.name}</td>
                            <td>${p.category.name}</td>
                            <td>$${p.price}</td>
                            <td>${p.stock}</td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>

            <!-- Pagination -->
            <nav>
                <ul class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="products?page=${i}&search=${search}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>

        </div>

    </body>

    </html>