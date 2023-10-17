<%-- 
    Document   : login2
    Created on : Aug 14, 2023, 10:22:02 PM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 40px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #ccc;
            }

            h2 {
                text-align: center;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-size: 14px;
                font-weight: bold;
            }

            .form-group input {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            .form-group input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
                
            }

            .form-group input[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Login</h2>
            <form action="MainController" method="post">
                <div class="form-group">
                    Username:
                    <input type="text" value="" name="userID" required="">
                </div>
                <div class="form-group">
                    Password:
                    <input type="password" value=""name="password" required="">
                </div>
                <div class="form-group">                   
                    <input type="submit" value="Login" name="action" style="background-color:  #148102"/>
                    <a href="create.jsp" style="text-decoration: none; color: black">Create User</a>
                </div>
            </form>
            <p style="color: red" >${requestScope.ERROR}</p>
        </div>
        
    </body>
</html>
