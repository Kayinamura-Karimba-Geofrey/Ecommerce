<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <style>
            .navbar {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: 70px;
                background: rgba(15, 23, 42, 0.8);
                backdrop-filter: blur(12px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                z-index: 1000;
                padding: 0 40px;
            }

            .nav-container {
                width: 100%;
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .nav-logo {
                font-size: 1.5rem;
                font-weight: 700;
                background: linear-gradient(to right, #6366f1, #10b981);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                text-decoration: none;
            }

            .nav-links {
                display: flex;
                gap: 30px;
                align-items: center;
            }

            .nav-link {
                color: #f8fafc;
                text-decoration: none;
                font-weight: 500;
                font-size: 0.95rem;
                transition: color 0.3s;
                opacity: 0.8;
            }

            .nav-link:hover {
                color: #6366f1;
                opacity: 1;
            }

            .nav-link.active {
                color: #6366f1;
                opacity: 1;
            }

            .nav-auth {
                display: flex;
                gap: 15px;
            }

            .btn-nav {
                padding: 8px 20px;
                border-radius: 10px;
                font-weight: 600;
                font-size: 0.9rem;
                text-decoration: none;
                transition: all 0.3s;
            }

            .btn-login {
                color: #f8fafc;
                border: 1px solid rgba(255, 255, 255, 0.1);
            }

            .btn-login:hover {
                background: rgba(255, 255, 255, 0.05);
            }

            .btn-logout {
                background: rgba(239, 68, 68, 0.1);
                color: #ef4444;
                border: 1px solid rgba(239, 68, 68, 0.2);
            }

            .btn-logout:hover {
                background: rgba(239, 68, 68, 0.2);
            }

            /* Adjust page content for fixed navbar */
            body {
                padding-top: 70px;
            }

            /* Debug Overlay */
            .debug-overlay {
                position: fixed;
                top: 75px;
                right: 20px;
                background: rgba(239, 68, 68, 0.9);
                color: white;
                padding: 10px 20px;
                border-radius: 12px;
                font-size: 0.8rem;
                font-weight: 700;
                z-index: 9999;
                pointer-events: none;
                border: 2px solid white;
            }
        </style>

        <nav class="navbar">
            <div class="nav-container">
                <a href="${pageContext.request.contextPath}/products" class="nav-logo">PREMIUM STORE</a>

                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/products" class="nav-link">Store</a>
                    <a href="${pageContext.request.contextPath}/cart" class="nav-link">Cart</a>
                    <c:if test="${not empty loggedUser}">
                        <a href="${pageContext.request.contextPath}/wishlist" class="nav-link">Wishlist</a>
                        <a href="${pageContext.request.contextPath}/orders" class="nav-link">My Orders</a>
                    </c:if>

                    <!-- Integrated Search Bar -->
                    <form action="${pageContext.request.contextPath}/products" method="get"
                        style="display: flex; background: rgba(255,255,255,0.05); border: 1px solid var(--border); border-radius: 20px; padding: 2px 12px; margin: 0 10px;">
                        <input type="text" name="search" placeholder="Search products..." value="${param.search}"
                            style="background: transparent; border: none; color: white; padding: 6px; font-size: 0.85rem; width: 140px; outline: none;">
                        <button type="submit"
                            style="background: transparent; border: none; color: var(--text-muted); cursor: pointer; padding: 4px;">🔍</button>
                    </form>

                    <c:if test="${loggedUser.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Admin</a>
                    </c:if>

                    <c:choose>
                        <c:when test="${not empty loggedUser}">
                            <div class="nav-auth">
                                <span
                                    style="color: var(--text-muted); font-size: 0.9rem; align-self: center; display: flex; align-items: center; gap: 8px;">
                                    👤 ${loggedUser.fullname}
                                    <a href="${pageContext.request.contextPath}/profile" class="nav-link"
                                        style="font-size: 0.8rem; border-left: 1px solid var(--border); padding-left: 8px;">Profile</a>
                                    <a href="${pageContext.request.contextPath}/support" class="nav-link"
                                        style="font-size: 0.8rem; border-left: 1px solid var(--border); padding-left: 8px;">Support</a>
                                </span>
                                <a href="${pageContext.request.contextPath}/logout"
                                    class="btn-nav btn-logout">Logout</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="nav-auth">
                                <a href="${pageContext.request.contextPath}/register.jsp"
                                    class="btn-nav btn-login">Register</a>
                                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-nav"
                                    style="background: var(--primary); color: white; border-radius: 10px; padding: 8px 20px; font-weight: 600; font-size: 0.9rem; text-decoration: none; transition: all 0.3s;">Login</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>