<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/loginForm.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/loginForm.js"></script>
<title>Entry Vault - Register</title>
<link rel="icon" type="image/x-icon" href="images/Layer 2.png">

</head>
<body>
	<div class="container">
		<div class="form-container">
			<img src="images/Layer 2.png" alt="Logo" class="logo"
				onclick="location.href='login.jsp';">
			<p class="title">Register</p>
			<form id="form1" class="form" action="UserServlet" method="post">
				<input type="hidden" name="action" value="register">
				<div class="input-group">
					<label for="firstName">First Name:</label> <input type="text"
						id="firstName" name="firstName"
						value="<%= request.getAttribute("firstName") != null ? request.getAttribute("firstName") : "" %>">
				</div>
				<div class="input-group">
					<label for="lastName">Last Name:</label> <input type="text"
						id="lastName" name="lastName"
						value="<%= request.getAttribute("lastName") != null ? request.getAttribute("lastName") : "" %>">
				</div>
				<div class="input-group">
					<label for="phoneNum">Phone Number:</label> <input type="text"
						id="phoneNum" name="phoneNum"
						value="<%= request.getAttribute("phoneNum") != null ? request.getAttribute("phoneNum") : "" %>">
				</div>
				<div class="input-group">
					<label for="birthday">Birthday:</label> <input type="date"
						id="birthday" name="birthday"
						value="<%= request.getAttribute("birthday") != null ? request.getAttribute("birthday") : "" %>">
				</div>
				<div class="input-group">
					<label for="userName">User Name:</label> <input type="text"
						id="userName" name="userName">
				</div>
				<div class="input-group">
					<label for="password">Password:</label> <input type="password"
						id="password" name="password">
				</div>
				<button class="sign" type="submit">Register</button>
			</form>
		</div>
	</div>

	<!-- Success Modal -->
	<div class="success-modal" id="success-modal">
		<svg xmlns="http://www.w3.org/2000/svg" width="24" viewBox="0 0 24 24"
			height="24" fill="none">
			<path fill-rule="evenodd" clip-rule="evenodd"
				d="m12 1c-6.075 0-11 4.925-11 11s4.925 11 11 11 11-4.925 11-11-4.925-11-11-11zm4.768 9.14c.0878-.1004.1546-.21726.1966-.34383.0419-.12657.0581-.26026.0477-.39319-.0105-.13293-.0475-.26242-.1087-.38085-.0613-.11844-.1456-.22342-.2481-.30879-.1024-.08536-.2209-.14938-.3484-.18828s-.2616-.0519-.3942-.03823c-.1327.01366-.2612.05372-.3782.1178-.1169.06409-.2198.15091-.3027.25537l-4.3 5.159-2.225-2.226c-.1886-.1822-.4412-.283-.7034-.2807s-.51301.1075-.69842.2929-.29058.4362-.29285.6984c-.00228.2622.09851.5148.28067.7034l3 3c.0983.0982.2159.1748.3454.2251.1295.0502.2681.0729.4069.0665.1387-.0063.2747-.0414.3991-.1032.1244-.0617.2347-.1487.3236-.2554z"
				fill="#393A37" /></svg>
		<div class="success__title">Registration successful. Please log
			in.</div>
		<div class="close" onclick="location.href='login.jsp';">
			<svg xmlns="http://www.w3.org/2000/svg" width="20"
				viewBox="0 0 20 20" height="20">
				<path fill="#393A37"
					d="m15.8333 5.34166-1.175-1.175-4.6583 4.65834-4.65833-4.65834-1.175 1.175 4.65833 4.65834-4.65833 4.6583 1.175 1.175 4.65833-4.6583 4.6583 4.6583 1.175-1.175-4.6583-4.6583z" /></svg>
		</div>
	</div>

	<!-- Error Modal -->
	<div class="error-modal" id="error-modal">
		<svg xmlns="http://www.w3.org/2000/svg" width="24" viewBox="0 0 24 24"
			height="24" fill="none">
			<path fill="#fff"
				d="m13 13h-2v-6h2zm0 4h-2v-2h2zm-1-15c-1.3132 0-2.61358.25866-3.82683.7612-1.21326.50255-2.31565 1.23915-3.24424 2.16773-1.87536 1.87537-2.92893 4.41891-2.92893 7.07107 0 2.6522 1.05357 5.1957 2.92893 7.0711.92859.9286 2.03098 1.6651 3.24424 2.1677 1.21325.5025 2.51363.7612 3.82683.7612 2.6522 0 5.1957-1.0536 7.0711-2.9289 1.8753-1.8754 2.9289-4.4189 2.9289-7.0711 0-1.3132-.2587-2.61358-.7612-3.82683-.5026-1.21326-1.2391-2.31565-2.1677-3.24424-.9286-.92858-2.031-1.66518-3.2443-2.16773-1.2132-.50254-2.5136-.7612-3.8268-.7612z"
				fill-rule="evenodd" clip-rule="evenodd" /></svg>
		<div class="error__title" id="error-title"></div>
		<div class="close" onclick="$('#error-modal').hide();">
			<svg xmlns="http://www.w3.org/2000/svg" width="20"
				viewBox="0 0 20 20" height="20">
				<path fill="#fff"
					d="m15.8333 5.34166-1.175-1.175-4.6583 4.65834-4.65833-4.65834-1.175 1.175 4.65833 4.65834-4.65833 4.6583 1.175 1.175 4.65833-4.6583 4.6583 4.6583 1.175-1.175-4.6583-4.6583z" /></svg>
		</div>
	</div>

	<script>
        // Function to show success modal
        function showSuccessModal(message) {
            $('#success__title').text(message);
            $('#success-modal').show();
        }

        // Function to show error modal with custom message
        function showErrorModal(errorMessage) {
            $('#error-title').text(errorMessage); // Update the error message dynamically
            $('#error-modal').show();
        }

        // Check for error or success messages and display respective modals
        $(document).ready(function() {
            <%-- Check for error messages --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                showErrorModal("<%= request.getAttribute("errorMessage") %>"); // Pass error message dynamically
                <% request.removeAttribute("errorMessage"); %>
            <% } %>

            <%-- Check for success messages --%>
            <% if (session.getAttribute("message") != null) { %>
                showSuccessModal("<%= session.getAttribute("message") %>"); // Pass success message dynamically
                <% session.removeAttribute("message"); %>
            <% } %>
        });
    </script>
</body>
</html>
