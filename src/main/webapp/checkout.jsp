<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Secure Checkout | Premium Store</title>
      <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
      <style>
        :root {
          --primary: #6366f1;
          --primary-hover: #4f46e5;
          --bg-dark: #0f172a;
          --card-bg: rgba(30, 41, 59, 0.7);
          --text-main: #f8fafc;
          --text-muted: #94a3b8;
          --accent: #10b981;
          --glass-border: rgba(255, 255, 255, 0.1);
        }

        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
          font-family: 'Outfit', sans-serif;
        }

        body {
          background-color: var(--bg-dark);
          background-image:
            radial-gradient(at 0% 0%, rgba(99, 102, 241, 0.15) 0, transparent 50%),
            radial-gradient(at 100% 100%, rgba(16, 185, 129, 0.1) 0, transparent 50%);
          color: var(--text-main);
          min-height: 100vh;
          padding: 80px 20px;
        }

        .container {
          max-width: 1200px;
          margin: 0 auto;
          display: grid;
          grid-template-columns: 1.5fr 1fr;
          gap: 40px;
        }

        .checkout-header {
          grid-column: 1 / -1;
          margin-bottom: 20px;
        }

        .checkout-header h1 {
          font-size: 2.5rem;
          font-weight: 700;
          background: linear-gradient(to right, #6366f1, #10b981);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
        }

        .card {
          background: var(--card-bg);
          backdrop-filter: blur(12px);
          border: 1px solid var(--glass-border);
          border-radius: 24px;
          padding: 35px;
          box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .section-title {
          font-size: 1.4rem;
          font-weight: 600;
          margin-bottom: 25px;
          display: flex;
          align-items: center;
          gap: 12px;
          color: var(--primary);
        }

        .input-group {
          margin-bottom: 20px;
        }

        .input-group label {
          display: block;
          font-size: 0.9rem;
          color: var(--text-muted);
          margin-bottom: 8px;
          font-weight: 500;
        }

        .input-group textarea,
        .input-group input {
          width: 100%;
          padding: 14px 18px;
          background: rgba(15, 23, 42, 0.5);
          border: 1px solid var(--glass-border);
          border-radius: 12px;
          color: var(--text-main);
          font-size: 1rem;
          transition: all 0.3s;
        }

        .input-group textarea:focus {
          outline: none;
          border-color: var(--primary);
          box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.2);
        }

        .summary-item {
          display: flex;
          justify-content: space-between;
          margin-bottom: 15px;
          font-size: 1rem;
        }

        .summary-item.total {
          margin-top: 20px;
          padding-top: 20px;
          border-top: 1px solid var(--glass-border);
          font-size: 1.5rem;
          font-weight: 700;
          color: var(--accent);
        }

        .order-items-mini {
          max-height: 250px;
          overflow-y: auto;
          margin-bottom: 25px;
          padding-right: 10px;
        }

        .item-mini {
          display: flex;
          gap: 15px;
          margin-bottom: 15px;
          align-items: center;
        }

        .item-mini img {
          width: 50px;
          height: 50px;
          border-radius: 8px;
          object-fit: cover;
        }

        .item-name {
          flex: 1;
          font-size: 0.95rem;
          font-weight: 500;
        }

        .btn-confirm {
          width: 100%;
          background: var(--primary);
          color: white;
          padding: 18px;
          border-radius: 16px;
          border: none;
          font-size: 1.1rem;
          font-weight: 700;
          cursor: pointer;
          transition: all 0.3s;
          margin-top: 15px;
        }

        .btn-confirm:hover {
          background: var(--primary-hover);
          transform: translateY(-2px);
          box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.4);
        }

        @media (max-width: 900px) {
          .container {
            grid-template-columns: 1fr;
          }
        }
      </style>
    </head>

    <body>
      <%@ include file="navbar.jsp" %>

        <div class="container">
          <header class="checkout-header">
            <h1>Secure Checkout</h1>
            <p style="color: var(--text-muted)">Please enter your delivery details to complete your order.</p>
          </header>

          <main>
            <form action="checkout" method="post" id="checkoutForm">
              <div class="card">
                <div class="section-title">
                  <span>📍</span> Delivery Information
                </div>

                <div class="input-group">
                  <label>Shipping Address</label>
                  <textarea name="shippingAddress" rows="3" required
                    placeholder="Enter full address for delivery"></textarea>
                </div>

                <div class="input-group">
                  <label>Billing Address</label>
                  <textarea name="billingAddress" rows="3" required
                    placeholder="Enter billing address (if different)"></textarea>
                  <p style="font-size: 0.8rem; color: var(--text-muted); margin-top: 5px;">
                    <input type="checkbox"
                      onchange="if(this.checked) document.getElementsByName('billingAddress')[0].value = document.getElementsByName('shippingAddress')[0].value">
                    Same as shipping
                  </p>
                </div>

                <div class="section-title" style="margin-top: 30px;">
                  <span>💳</span> Payment Method
                </div>
                <p style="color: var(--text-muted); font-size: 0.9rem; margin-bottom: 20px;">
                  Currently accepting <strong>Cash on Delivery</strong> only for maximum security.
                </p>
              </div>
            </form>
          </main>

          <aside>
            <div class="card">
              <div class="section-title">
                <span>📋</span> Order Summary
              </div>

              <div class="order-items-mini">
                <c:forEach var="item" items="${cartItems}">
                  <div class="item-mini">
                    <c:choose>
                      <c:when test="${item.product.imagePath.startsWith('http')}">
                        <img src="${item.product.imagePath}" alt="${item.product.name}">
                      </c:when>
                      <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${item.product.imagePath}"
                          alt="${item.product.name}">
                      </c:otherwise>
                    </c:choose>
                    <div class="item-name">${item.product.name} (x${item.quantity})</div>
                    <div style="font-weight: 600">$${item.total}</div>
                  </div>
                </c:forEach>
              </div>

              <div class="summary-details">
                <div class="summary-item">
                  <span>Subtotal</span>
                  <span>$${subtotal}</span>
                </div>
                <div class="summary-item">
                  <span>Tax (10%)</span>
                  <span>$${tax}</span>
                </div>
                <div class="summary-item">
                  <span>Shipping</span>
                  <c:choose>
                    <c:when test="${shipping == 0}">
                      <span style="color: var(--accent)">FREE</span>
                    </c:when>
                    <c:otherwise>
                      <span>$${shipping}</span>
                    </c:otherwise>
                  </c:choose>
                </div>
                <div class="summary-item total">
                  <span>Total amount</span>
                  <span>$${total}</span>
                </div>
              </div>

              <button type="submit" form="checkoutForm" class="btn-confirm">Place Order Now</button>
            </div>
          </aside>
        </div>
    </body>

    </html>