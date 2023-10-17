<%-- 
    Document   : shopping2
    Created on : Aug 14, 2023, 10:22:54 PM
    Author     : LAPTOP
--%>

<%@page import="java.util.List"%>
<%@page import="sample.user.UserDAO"%>
<%@page import="sample.shopping.Product"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            header{
                background-color: #148102;
                padding:  10px;
            }
            nav {
                display: flex;
                justify-content: flex-end;
            }
            nav ul{
                
                list-style-type:  none;
                margin:0;
                padding: 0;
            }
            nav ul li{
                display: inline-block;
                padding: 5px 10px;   
            }

            nav ul li a{
                color: #fff;
                text-decoration: none;
            }
            nav ul li a:hover{
                background-color: #ddd;
                color: #333;
            }
            .container {
                
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }
            h1 {
                text-align: center;
            }
            .catchy-heading {
                text-align: center;
                font-size: 48px;
                color: #333;
                margin-bottom: 30px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 1.3);
            }

            .highlight {
                color: #ff6600;
                font-weight: bold;
                font-style: italic;
                letter-spacing: 1px;
            }
            .search-form {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
                margin-right: 5px;
            }
            .search-button {
                padding: 8px 12px;
                background-color: #148102;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .search-input {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 10px;
                margin-right: 5px;
            }


            .product-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            .product {
                width: 300px;
                margin-bottom: 20px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                background-color: #fff;
            }
            .product-item{
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            .product-image {
                width: 200px;
                height: auto;
                margin-bottom: 10px;
            }
            .product-details {
                margin-bottom: 10px;
            }

            .product-details span {
                display: block;
            }
            .input-wrapper {
                display: flex;
            }

            .product-quantity-input {
                width: 50px;
                padding: 5px;
                border: 1px solid #ccc;
            }

            .add-to-cart-button {
                background-color:#148102;
                color: #fff;
                border: none;
                padding: 8px 16px;
                cursor: pointer;
            }

            .add-to-cart-button:hover {
                background-color: #00b74a;
            }
        </style>
    </head>
    <body>
        <header>
            <nav>
                <ul>                  
                    <li><a href="MainController?action=home"><i class="fas fa-home"></i> HOME</a></li>
                    <li><a href="MainController?action=view"><i class="fas fa-shopping-cart"></i> YOUR CART</a></li>
                    <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> LOGIN</a></li>
                    <li style="color: #4de8da ">
                        <c:choose>
                            <c:when test="${not empty sessionScope.LOGIN_USER}">
                                ${sessionScope.LOGIN_USER.fullName}
                                <c:url var="logoutLink" value="MainController">
                                    <c:param name="action" value="Logout" />
                                </c:url>
                                <a href="${logoutLink}"><i class="fas fa-sign-out-alt"></i> LOGOUT</a>
                            </c:when>
                            <c:otherwise>
                                GUEST
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ul>
            </nav>
        </header>

        <div class="container">
            <h1 class="catchy-heading" style="color: red">
                <span style="color: black" class="highlight">Welcome to</span> Iphone World Store
            </h1>
            <form action="MainController" method="get" class="search-form">
                <input type="text" name="search" value="${param.search}" class="search-input" placeholder="Search product..." />
                
                <button type="submit" name="action" value="Search" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </form>

           
            <div class="product-container">
                <c:if test="${not empty requestScope.LIST_PRODUCT}">
                    <c:forEach var="p" items="${requestScope.LIST_PRODUCT}">
                        <div class="product">                       
                            <div class="product-item">
                                <img src="${p.img}" alt="Product_image" class="product-image">
                                <div class="product-details">
                                    <span><strong>ID:</strong> ${p.id}</span>
                                    <span><strong>Name:</strong> ${p.name}</span>
                                    <span><strong>Quantity:</strong> ${p.quantity}</span>
                                    <span><strong>Price:</strong> ${p.price}</span>

                                </div>
                                <form action="MainController" method="get" class="add-to-cart-form">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <input type="hidden" name="name" value="${p.name}">
                                    <input type="hidden" name="img" value="${p.img}"/>
                                    <div class="input-wrapper">
                                        <input type="number" min="1" name="num" value="1" class="product-quantity-input">
                                        <input type="hidden" name="price" value="${p.price}">
                                        <input type="submit" value="Add to Cart" name="action" class="add-to-cart-button">
                                    </div>
                                </form>                                    
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>           
        </div>


    </body>
</html>
