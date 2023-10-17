 <%--
    Document   : invoice
    Created on : Aug 23, 2023, 4:04:48 AM
    Author     : LAPTOP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice Page</title>
        <style>
            .invoice-container {
                width: 80%;
                margin: 0 auto;
            }

            h1 {
                text-align: center;
            }

            .customer-info {
                margin-bottom: 20px;
            }

            .order-table {
                width: 100%;
                border-collapse: collapse;
            }

            .order-table th,
            .order-table td {
                border: 1px solid #ccc;
                padding: 8px;
            }

            .order-table th {
                background-color: #f2f2f2;
                text-align: left;
            }

            .product-image {
                width: 50px;
                height: auto;
            }

            .total {
                text-align: right;
                margin-top: 20px;
            }
            .btn-back {
                padding: 8px 16px;
                background-color: #148102;
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
        <div class="invoice-container">
            <h1 style="color: red;text-shadow: 2px 2px 4px rgba(0, 0, 0, 1.3);">Invoice</h1>
            <button class="btn-back" " onclick="goBack()">Back</button>
            <div class="customer-info">
                <h2 style="red">Customer Information:</h2>
                <p><strong>Name:</strong> ${param.userName}</p>
                <p><strong>Phone Number:</strong> ${param.phoneNumber}</p>
                <p><strong>Shipping Address:</strong> ${param.shippingAddress}</p>
                <p><strong>Date:</strong> <%= new java.util.Date()%></p>
            </div>

            <h2>Order Details:</h2>
            <table class="order-table">
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
                    <c:forEach var="product" items="${sessionScope.CART.cart.values()}" varStatus="counter">
                        <c:set var="subtotal" value="${product.quantity * product.price}" />
                        <c:set var="total" value="${total + subtotal}" />
                        <tr>
                            <td>${counter.count}</td>
                            <td>${product.id}</td>
                            <td>
                                <img src="${product.img}" alt="Product Image" class="product-image" />
                            </td>
                            <td>${product.name}</td>
                            <td>${product.price}</td>
                            <td>${product.quantity}</td>
                            <td>${product.quantity * product.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h3>Total: ${total}$</h3>
        </div>
        <script>
            function goBack() {

            <% session.removeAttribute("CART");%>

                window.location.href = "ShowAllServlet";
            }
        </script>
    </body>
</html>
