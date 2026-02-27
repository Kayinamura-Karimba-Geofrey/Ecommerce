<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>Manage Orders</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">

            <div class="container mt-5">

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3>Manage Orders</h3>

                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
                        Back to Dashboard
                    </a>
                </div>

                <div class="card shadow">
                    <div class="card-body p-0">

                        <table class="table table-striped table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Customer</th>
                                    <th>Date</th>
                                    <th>Total</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>

                            <tbody>

                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>#${order.id}</td>
                                        <td>${order.user.fullname}</td>
                                        <td>${order.orderDate}</td>
                                        <td>$${order.totalAmount}</td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/admin/manage-orders"
                                                method="post" style="display:inline;">
                                                <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">
                                                <input type="hidden" name="orderId" value="${order.id}">
                                                <select name="status" onchange="this.form.submit()"
                                                    class="form-select form-select-sm"
                                                    style="width: 130px; background-color: transparent; border-color: rgba(255,255,255,0.1); color: var(--text-dark);">
                                                    <option value="PENDING" ${order.status=='PENDING' ? 'selected' : ''
                                                        }>PENDING</option>
                                                    <option value="SHIPPED" ${order.status=='SHIPPED' ? 'selected' : ''
                                                        }>SHIPPED</option>
                                                    <option value="DELIVERED" ${order.status=='DELIVERED' ? 'selected'
                                                        : '' }>DELIVERED</option>
                                                    <option value="CANCELLED" ${order.status=='CANCELLED' ? 'selected'
                                                        : '' }>CANCELLED</option>
                                                </select>
                                            </form>
                                        </td>

                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/order-details?id=${order.id}"
                                                class="btn btn-sm btn-info">
                                                View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty orders}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4 text-muted">
                                            No orders found.
                                        </td>
                                    </tr>
                                </c:if>

                            </tbody>
                        </table>

                    </div>
                </div>

            </div>

        </body>

        </html>