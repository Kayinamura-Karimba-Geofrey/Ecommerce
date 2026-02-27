<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Order Confirmed | Premium Store</title>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --primary: #6366f1;
                    --bg-dark: #0f172a;
                    --card-bg: rgba(30, 41, 59, 0.7);
                    --text-main: #f8fafc;
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
                    color: var(--text-main);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    min-height: 100vh;
                    padding: 20px;
                }

                .success-card {
                    background: var(--card-bg);
                    backdrop-filter: blur(12px);
                    border: 1px solid var(--glass-border);
                    border-radius: 30px;
                    padding: 50px;
                    max-width: 600px;
                    width: 100%;
                    text-align: center;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                    animation: slideUp 0.6s ease-out;
                }

                @keyframes slideUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .check-icon {
                    width: 80px;
                    height: 80px;
                    background: var(--accent);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 40px;
                    margin: 0 auto 30px;
                    box-shadow: 0 0 30px rgba(16, 185, 129, 0.4);
                }

                h1 {
                    font-size: 2.2rem;
                    margin-bottom: 15px;
                }

                p {
                    color: #94a3b8;
                    line-height: 1.6;
                    margin-bottom: 30px;
                }

                .order-id {
                    background: rgba(255, 255, 255, 0.05);
                    border: 1px dashed var(--glass-border);
                    padding: 15px;
                    border-radius: 12px;
                    font-family: monospace;
                    font-size: 1.2rem;
                    color: var(--primary);
                    margin-bottom: 30px;
                }

                .btn-home {
                    display: inline-block;
                    background: var(--primary);
                    color: white;
                    padding: 15px 40px;
                    border-radius: 12px;
                    text-decoration: none;
                    font-weight: 700;
                    transition: 0.3s;
                }

                .btn-home:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
                }
            </style>
        </head>

        <body>
            <div class="success-card">
                <div class="check-icon">✓</div>
                <h1>Order Placed!</h1>
                <p>Thank you for your purchase. We've received your order and are processing it for shipment.</p>

                <div class="order-id">
                    ORDER ID: #${order.id}
                </div>

                <p style="font-size: 0.9rem;">
                    Total Paid: <strong>$${order.totalAmount}</strong><br>
                    Delivering to: ${order.shippingAddress}
                </p>

                <a href="products" class="btn-home">Continue Shopping</a>
            </div>
        </body>

        </html>