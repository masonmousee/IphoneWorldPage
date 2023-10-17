<%-- 
    Document   : viewCart
    Created on : Jun 18, 2023, 8:11:11 PM
    Author     : LAPTOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.shopping.Product"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="sample.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <style>
            body{
                font-family: Arial,sans-serif;
                margin: 0;
                padding: 0;
            }
            header{
                background-color: #148102;
                padding: 10px;
            }
            nav{
                display: flex;
                justify-content: flex-end;
            }
            nav ul{
                list-style-type: none;
                margin: 0;
                padding: 0;
            }
            nav ul li {
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


            /*//bodyContainer*/
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
            table{
                border-collapse: collapse;
                width: 100%;
            }

            th,td{
                padding: 10px;
                text-align: center;

            }

            th{
                background-color: #f2f2f2;
            }
            tr:nth-child(even){
                background-color: #f9f9f9;
            }
            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                padding: 8px 16px;
                background-color: #148102;
                color: white;
                border: none;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }
            img {
                max-width: 100px;
                max-height: 100px;
                height: auto;
                display: block;
                margin: 0 auto;
            }
            .total {
                text-align: right;
                font-weight: 900;
                margin-top: 20px;
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
                    <li style="color: #66ffff ">
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
            <h1 class="catchy-heading">
                <span class="highlight" style="color: red">Your View Cart</span> 
            </h1>

            <c:if test="${not empty sessionScope.CART}">
                <table border="1px">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Edit</th>
                            <th>Remove</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" />
                        <c:forEach var="product" items="${sessionScope.CART.cart.values()}" varStatus="counter">
                            <c:set var="subtotal" value="${product.quantity * product.price}" />
                            <c:set var="total" value="${total + subtotal}" />

                        <form action="MainController" method="GET">
                            <tr style="text-align: center">
                                <td>${counter.count}</td>
                                <td>
                                    ${product.id}
                                    <input style="text-align: center; opacity: 0; position: absolute; left: -9999px;" type="text" name="id" value="${product.id}" readonly="" />
                                </td>
                                <td>
                                    <img src="${product.img}" alt="Product Image" />
                                </td>
                                <td>${product.name}</td>
                                <td>${product.price}</td>
                                <td>
                                    <input style="text-align: center" type="number" name="num" value="${product.quantity}" min="1" required="" />
                                </td>
                                <td>
                                    <input type="submit" name="action" value="edit" />
                                </td>
                                <td>
                                    <input type="submit" name="action" value="remove" />
                                </td>
                                <td>${subtotal}</td>
                            </tr>
                        </form>
                    </c:forEach>

                    </tbody>
                </table>
                <h1 class="total">Total: ${total}$</h1>
            </c:if>
            <c:if test="${empty sessionScope.CART }">
                "Nothing Here ! Please Add Product In Your View Cart"
            </c:if>

            <div style="display: block; text-align: right">
                <div style="margin-bottom: 30px;">
                    <a style="text-decoration: none;"  href="MainController?action=home">Add more</a>
                </div>
                <hr/>
                <form action="MainController" method="POST" style="margin-bottom: 30px" onsubmit="return validateCheckout()">
                    <input type="submit" name="action" value="Check out"  />
                </form>
            </div>

        </div>
       
 
        <script><!--
            function validateCheckout(event) {

                var isLoggedIn = ${ not empty sessionScope.LOGIN_USER};

                var cartItemCount = ${not empty sessionScope.CART && not empty CART.cart};
                if (!cartItemCount) {
                    alert("Your cart is currently empty!");
                    event.preventDefault();
                }
                if (!isLoggedIn) {
                    alert("You need to login.");
                    setTimeout(function () {
                        window.location.href = "login.jsp";
                    }, 3000);
                    event.preventDefault();
                } 
//                else {
//                    alert("Thank you for buying products!");
//                    setTimeout(function () {
//                        window.location.href = "CheckoutServlet";
//                    }, 3000);
//
//                }
            }

        </script>-->
    </body>
</html>
