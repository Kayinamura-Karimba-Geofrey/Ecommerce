<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <style>
            .navbar {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                height: 70px;
                background: rgba(15, 23, 42, 0.9);
                backdrop-filter: blur(12px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                display: flex;
                align-items: center;
                z-index: 1000;
                padding: 0 40px;
            }

            .nav-container {
                width: 100%;
                max-width: 1400px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .nav-logo {
                font-size: 1.5rem;
                font-weight: 800;
                background: linear-gradient(to right, #6366f1, #10b981);
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
                text-decoration: none;
                letter-spacing: -0.5px;
                z-index: 1001;
            }

            .menu-toggle {
                display: none;
                flex-direction: column;
                gap: 5px;
                cursor: pointer;
                z-index: 1001;
            }

            .menu-toggle span {
                width: 25px;
                height: 2px;
                background: white;
                border-radius: 2px;
                transition: 0.3s;
            }

            .nav-content {
                display: flex;
                gap: 30px;
                align-items: center;
            }

            .nav-links {
                display: flex;
                gap: 25px;
                align-items: center;
            }

            .nav-link {
                color: #f8fafc;
                text-decoration: none;
                font-weight: 600;
                font-size: 0.9rem;
                transition: 0.3s;
                opacity: 0.7;
            }

            .nav-link:hover,
            .nav-link.active {
                opacity: 1;
                color: #6366f1;
            }

            .nav-auth {
                display: flex;
                gap: 15px;
                align-items: center;
            }

            .search-bar {
                display: flex;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                padding: 4px 12px;
                transition: 0.3s;
            }

            .search-bar:focus-within {
                border-color: #6366f1;
                background: rgba(255, 255, 255, 0.1);
            }

            .search-bar input {
                background: transparent;
                border: none;
                color: white;
                padding: 6px;
                font-size: 0.85rem;
                width: 150px;
                outline: none;
            }

            @media (max-width: 1024px) {
                .navbar {
                    padding: 0 20px;
                }

                .nav-content {
                    position: fixed;
                    top: 0;
                    right: -100%;
                    width: 280px;
                    height: 100vh;
                    background: #0f172a;
                    flex-direction: column;
                    padding: 100px 30px;
                    transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                    border-left: 1px solid rgba(255, 255, 255, 0.1);
                    box-shadow: -20px 0 40px rgba(0, 0, 0, 0.5);
                    align-items: flex-start;
                    gap: 40px;
                }

                .nav-content.active {
                    right: 0;
                }

                .menu-toggle {
                    display: flex;
                }

                .nav-links,
                .nav-auth {
                    flex-direction: column;
                    align-items: flex-start;
                    width: 100%;
                }

                .search-bar {
                    width: 100%;
                }

                .search-bar input {
                    width: 100%;
                }

                /* Burger Animation */
                .menu-toggle.active span:nth-child(1) {
                    transform: rotate(45deg) translate(5px, 5px);
                }

                .menu-toggle.active span:nth-child(2) {
                    opacity: 0;
                }

                .menu-toggle.active span:nth-child(3) {
                    transform: rotate(-45deg) translate(5px, -5px);
                }
            }
        </style>

        <nav class="navbar">
            <div class="nav-container">
                <a href="${pageContext.request.contextPath}/products" class="nav-logo">⚡ PREMIUM</a>

                <div class="menu-toggle" id="mobile-menu">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>

                <div class="nav-content" id="nav-content">
                    <div class="nav-links">
                        <a href="${pageContext.request.contextPath}/products" class="nav-link">Store</a>
                        <c:if test="${not empty loggedUser}">
                            <a href="${pageContext.request.contextPath}/orders" class="nav-link">Orders</a>
                            <a href="${pageContext.request.contextPath}/wishlist" class="nav-link">Wishlist</a>
                        </c:if>
                        <c:if test="${loggedUser.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link"
                                style="color: #fbbf24; opacity: 1;">Admin Panel</a>
                        </c:if>
                    </div>

                    <form action="${pageContext.request.contextPath}/products" method="get" class="search-bar">
                        <input type="text" name="search" placeholder="Search..." value="${param.search}">
                        <button type="submit" style="background:none; border:none; cursor:pointer;">🔍</button>
                    </form>

                    <div class="nav-auth">
                        <c:choose>
                            <c:when test="${not empty loggedUser}">
                                <a href="${pageContext.request.contextPath}/cart" class="nav-link">🛒 Cart</a>
                                <a href="${pageContext.request.contextPath}/profile" class="nav-link">👤 Profile</a>
                                <a href="${pageContext.request.contextPath}/logout" class="nav-link"
                                    style="color: #ef4444; opacity: 1;">Sign Out</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login.jsp" class="nav-link">Login</a>
                                <a href="${pageContext.request.contextPath}/register.jsp"
                                    style="background: #6366f1; color: white; padding: 10px 20px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 0.9rem;">Join
                                    Now</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>

        <script>
            const menuToggle = document.getElementById('mobile-menu');
            const navContent = document.getElementById('nav-content');

            menuToggle.addEventListener('click', () => {
                menuToggle.classList.toggle('active');
                navContent.classList.toggle('active');

                // Prevent scrolling when menu is open
                document.body.style.overflow = navContent.classList.contains('active') ? 'hidden' : 'auto';
            });
        </script>