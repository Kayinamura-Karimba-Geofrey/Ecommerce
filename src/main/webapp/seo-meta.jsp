<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!-- SEO Meta Tags -->
        <title>${not empty seoTitle ? seoTitle : 'Premium Store | Your Luxury E-commerce'}</title>
        <meta name="description"
            content="${not empty seoDescription ? seoDescription : 'Shop the latest in premium gadgets, fashion, and lifestyle at Premium Store. Quality guaranteed.'}">
        <meta name="keywords" content="e-commerce, premium, luxury, shop, online store">
        <meta name="author" content="Premium Store Team">

        <!-- Open Graph / Facebook -->
        <meta property="og:type" content="website">
        <meta property="og:url" content="${pageContext.request.requestURL}">
        <meta property="og:title" content="${not empty seoTitle ? seoTitle : 'Premium Store | Luxury E-commerce'}">
        <meta property="og:description"
            content="${not empty seoDescription ? seoDescription : 'Shop premium quality products online.'}">
        <meta property="og:image"
            content="${not empty seoImage ? (seoImage.startsWith('http') ? seoImage : pageContext.request.contextPath.concat('/').concat(seoImage)) : 'https://example.com/default-og.jpg'}">

        <!-- Twitter -->
        <meta property="twitter:card" content="summary_large_image">
        <meta property="twitter:url" content="${pageContext.request.requestURL}">
        <meta property="twitter:title" content="${not empty seoTitle ? seoTitle : 'Premium Store'}">
        <meta property="twitter:description"
            content="${not empty seoDescription ? seoDescription : 'Shop premium quality products online.'}">
        <meta property="twitter:image"
            content="${not empty seoImage ? (seoImage.startsWith('http') ? seoImage : pageContext.request.contextPath.concat('/').concat(seoImage)) : 'https://example.com/default-og.jpg'}">

        <!-- Additional Meta -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <link rel="canonical" href="${pageContext.request.requestURL}">