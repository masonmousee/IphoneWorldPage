<%-- 
    Document   : invoice
    Created on : Aug 23, 2023, 1:55:55 AM
    Author     : LAPTOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.shopping.Product"%>
<%@page import="sample.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .form-container{
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f7f7f7;
                border: 1px solid #e5e5e5;
                border-radius: 5px;
                box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .form-header {
                display: flex;
                width: 100%;
                margin-bottom: 20px;
                align-items: center;
                flex-direction: column;
            }
            .form-title {
                margin-bottom: 20px;
                font-size: 20px;
                font-weight: bold;
                text-align: center;
                color:  #ff6600;
            }
            .user-form {
                margin-bottom: 20px;
            }

            .form-group {
                display: flex;
                margin-bottom: 10px;
                align-items: center;
            }

            .form-label {
                font-size: 14px;
                font-weight: bold;
                margin-bottom: 5px;
                flex-basis: 20%;
                padding-right: 20px;
            }

            .form-input {
                flex-basis: 70%;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .btn-submit {
                text-align: right;

            }
            .btn-submit input[type="submit"] {
                padding: 8px 16px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn-submit input[type="submit"]:hover {
                background-color: #148102;
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
            }

            .product-table th,
            .product-table td {
                padding: 10px;
                border: 1px solid #ccc;
            }

            .product-image {
                max-width: 100px;
                max-height: 100px;
            }

            tbody {
                text-align: center;
            }

            .total {
                text-align: right;
                margin-top: 20px;
                font-weight: bold;
            }
            .btn-back {
                padding: 8px 16px;
                background-color:#148102;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-bottom: 20px;
                align-self: flex-start;
            }

            .btn-back:hover {
                background-color: #ff5500;
            }
        </style>
    </head>

    <body>
        <div class="form-container">
            <div class="form-header">
                <button class="btn-back" onclick="goBack()">Back</button>
                <div class="form-title" style="color: red">User Information</div>
            </div>
            <form action="MainController" method="POST" class="user-form">
                <div class="form-group">
                    <label class="form-label" for="userID">UserID</label>
                    <input class="form-input" type="text" id="userID" name="userID"
                           value="${sessionScope.LOGIN_USER.userID}" readonly/>
                </div>
                <div class="form-group">
                    <label class="form-label" for="fullName">Name</label>
                    <input class="form-input" type="text" id="userName" name="userName" required/>

                </div>
                <div class="form-group">
                    <label class="form-label" for="phoneNumber">Phone Number</label>
                    <input class="form-input" type="text" id="phoneNumber" name="phoneNumber" required/>
                </div>
                <div class="form-group">
                    <label class="form-label" for="shippingAddress">Shipping Address</label>
                    <input class="form-input" type="text" id="shippingAddress" name="shippingAddress" required/>
                </div>
                <div class="btn-submit">
                    <input type="submit" name="action" value="Confirm" >
                </div>

            </form>


            <h2>Order Product:</h2>
            <c:if test="${not empty sessionScope.CART}">
                <table class="product-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" />
                        <c:forEach var="product" items="${sessionScope.CART.cart.values()}" varStatus="counter">
                            <c:set var="subtotal" value="${product.quantity * product.price}" />
                            <c:set var="total" value="${total + subtotal}" />

                            <tr>
                                <td>${counter.count}</td>
                                <td>
                                    ${product.id}
                                    <input type="hidden" name="id" value="${product.id}" />
                                </td>
                                <td>
                                    <img src="${product.img}" alt="Product Image" class="product-image" />
                                </td>
                                <td>${product.name}</td>
                                <td>${product.price}</td>
                                <td>${product.quantity}</td>
                                <td>${subtotal}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <h1 class="total">Total: ${total}$</h1>
            </c:if>
        </div>
        <script>
            function goBack() {

                window.location.href = "viewCart.jsp";
            }
        </script>
    </body>
</html>
