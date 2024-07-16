<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    String userName = (String) session.getAttribute("userName");

    if (userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/homePage.css">
    <title>Entry Vault - Home</title>
    <link rel="icon" type="image/x-icon" href="images/Layer 2.png">
</head>	
<body>
    <div class="navbar">
        <div class="left">
            <img src="images/Layer 2.png" alt="Icon">
        </div>
        <div class="middle">
            <a href="homePage.jsp">Home Page</a>
            <a href="notepads.jsp">Task</a>
                       <a href="NotepadServlet?action=history">History</a>
        </div>
        <div class="right">
            <a href="login.jsp">Log Out</a>
        </div>
    </div>
    <div class="container">
        <div class="card">
            <div class="card__content">
                <h1>Welcome to Entry Vault</h1>
                <p>Plan your day on this website</p>
                <p>Organize your workday in no time</p>
                <div class="button-container">
                    <button class="animated-button" onclick="scrollToCanvas()">
                        <svg viewBox="0 0 24 24" class="arr-2" xmlns="http://www.w3.org/2000/svg">
                            <path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path>
                        </svg>
                        <span class="text">Start Now</span>
                        <span class="circle"></span>
                        <svg viewBox="0 0 24 24" class="arr-1" xmlns="http://www.w3.org/2000/svg">
                            <path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path>
                        </svg>
                    </button>
                </div>
                <p>In a rush? Visualize your thoughts in this free canvas!</p>
                <div class="button-container">
                    <button class="animated-button" onclick="scrollToCanvas()">
                        <svg viewBox="0 0 24 24" class="arr-2" xmlns="http://www.w3.org/2000/svg">
                            <path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path>
                        </svg>
                        <span class="text">Draw Now</span>
                        <span class="circle"></span>
                        <svg viewBox="0 0 24 24" class="arr-1" xmlns="http://www.w3.org/2000/svg">
                            <path d="M16.1716 10.9999L10.8076 5.63589L12.2218 4.22168L20 11.9999L12.2218 19.778L10.8076 18.3638L16.1716 12.9999H4V10.9999H16.1716Z"></path>
                        </svg>
                    </button>
                </div>	
            </div>
        </div>
    </div>
    <form id="drawingForm">
        <canvas id="drawingCanvas"></canvas>
        <div id="popup">Right-click to clear all drawings</div>
    </form>
    <script type="text/javascript" src="js/homePage.js"></script>
</body>
</html>
