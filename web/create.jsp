<%-- 
    Document   : create
    Created on : Aug 20, 2023, 8:33:32 AM
    Author     : LAPTOP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create    Page</title>
        <style>
            /* Form Container */
            .form-container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f7f7f7;
                border: 1px solid #e5e5e5;
                border-radius: 5px;
                font-family: Arial, sans-serif;
                box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
            }
            .form-title {
                margin-bottom: 20px;
                font-size: 20px;
                font-weight: bold;
                text-align: center;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-label {
                display: block;
                font-size: 14px;
                font-weight: bold;
                margin-bottom: 5px;
            }
            .form-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .error-message {
                color: red;
                font-size: 14px;
                margin-top: 5px;
            }
            .form-button-container {
                text-align: center;
            }
            .submit-button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
            }
            .reset-button {
                padding: 10px 20px;
                background-color: #e5e5e5;
                color: #333;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                margin-left: 10px;
            }
        </style>


    <div class="form-container">
        <div class="form-title">User Registration</div>
        <form action="MainController" method="POST" onsubmit="return handleRegistration(event)">
            <div class="form-group">
                <label class="form-label" for="userID">UserID</label>
                <input class="form-input" type="text" id="userID" name="userID" required="">
                <span class="error-message">${requestScope.USER_ERROR.userIDError}</span>
            </div>

            <div class="form-group">
                <label class="form-label" for="fullName">Full Name</label>
                <input class="form-input" type="text" id="fullName" name="fullName" required="">
                <span class="error-message">${requestScope.USER_ERROR.fullNameError}</span>
            </div>

            <div class="form-group">
                <label class="form-label" for="roleID">RoleID</label>
                <input class="form-input" type="text" id="roleID" name="roleID" value="US" required="">
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input class="form-input" type="text" id="password" name="password" required="">
                <span class="error-message">${requestScope.USER_ERROR.passwordError}</span>
            </div>

            <div class="form-group">
                <label class="form-label" for="confirm">Confirm Password</label>
                <input class="form-input" type="text" id="confirm" name="confirm" required="">
                <span class="error-message">${requestScope.USER_ERROR.confirmError}</span>
            </div>

            <div class="form-button-container">
                <input class="submit-button" type="submit" name="action" value="Create">
                <input class="reset-button" type="reset" value="Reset">
            </div>
            <span class="error-message">${requestScope.USER_ERROR.error}</span>
        </form>
    </div>
    <script>
        function handleRegistration(event) {
            var registrationSuccessful = true;
            if (registrationSuccessful) {
                event.preventDefault();
                alert("Registration successful!");
                setTimeout(function () {
                    window.location.href = "login.jsp";
                });
            }
        }
    </script>




</body>
</html>
