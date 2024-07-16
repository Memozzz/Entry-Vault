<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/login.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<title>Entry Vault - Login</title>
<link rel="icon" type="image/x-icon" href="images/Layer 2.png">
</head>
<body>
	<div class="container">
		<div class="form-container">
			<p class="title">Login</p>
			<form id="form1" class="form" action="UserServlet" method="post">
				<input type="hidden" name="action" value="login">
				<div class="input-group">
					<label for="userName">Username</label> <input type="text"
						name="userName" id="userName" placeholder="">
				</div>
				<div class="input-group">
					<label for="password">Password</label> <input type="password"
						name="password" id="password" placeholder="">
					<div class="forgot">
						<a rel="noopener noreferrer" href="#">Forgot Password?</a>
					</div>
				</div>
				<button class="sign" type="submit">Sign in</button>
			</form>
			<div class="social-message">
				<div class="line"></div>
				<p class="message">Login with social accounts</p>
				<div class="line"></div>
			</div>
			<div class="social-icons">
				<button aria-label="Log in with Google" class="icon">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                        <path d="M16.318 13.714v5.484h9.078c-0.37 2.354-2.745 6.901-9.078 6.901-5.458 0-9.917-4.521-9.917-10.099s4.458-10.099 9.917-10.099c3.109 0 5.193 1.318 6.38 2.464l4.339-4.182c-2.786-2.599-6.396-4.182-10.719-4.182-8.844 0-16 7.151-16 16s7.156 16 16 16c9.234 0 15.365-6.49 15.365-15.635 0-1.052-0.115-1.854-0.255-2.651z"></path>
                    </svg>
				</button>
				<button aria-label="Log in with Twitter" class="icon">
					 <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                        <path d="M31.937 6.093c-1.177 0.516-2.437 0.871-3.765 1.032 1.355-0.813 2.391-2.099 2.885-3.631-1.271 0.74-2.677 1.276-4.172 1.579-1.192-1.276-2.896-2.079-4.787-2.079-3.625 0-6.563 2.937-6.563 6.557 0 0.521 0.063 1.021 0.172 1.495-5.453-0.255-10.287-2.875-13.52-6.833-0.568 0.964-0.891 2.084-0.891 3.303 0 2.281 1.161 4.281 2.916 5.457-1.073-0.031-2.083-0.328-2.968-0.817v0.079c0 3.181 2.26 5.833 5.26 6.437-0.547 0.145-1.131 0.229-1.724 0.229-0.421 0-0.823-0.041-1.224-0.115 0.844 2.604 3.26 4.5 6.14 4.557-2.239 1.755-5.077 2.801-8.135 2.801-0.521 0-1.041-0.025-1.563-0.088 2.917 1.86 6.36 2.948 10.079 2.948 12.067 0 18.661-9.995 18.661-18.651 0-0.276 0-0.557-0.021-0.839 1.287-0.917 2.401-2.079 3.281-3.396z"></path>
                    </svg>
				</button>
				<button aria-label="Log in with GitHub" class="icon">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32">
                        <path d="M16 0.396c-8.837 0-16 7.163-16 16 0 7.068 4.584 13.066 10.943 15.183 0.8 0.147 1.093-0.347 1.093-0.771 0-0.38-0.014-1.387-0.022-2.723-4.451 0.967-5.39-2.146-5.39-2.146-0.729-1.852-1.779-2.346-1.779-2.346-1.454-0.994 0.111-0.974 0.111-0.974 1.606 0.113 2.451 1.651 2.451 1.651 1.43 2.451 3.752 1.743 4.663 1.333 0.145-1.036 0.559-1.743 1.015-2.144-3.552-0.405-7.288-1.776-7.288-7.906 0-1.746 0.623-3.175 1.647-4.294-0.165-0.405-0.714-2.037 0.156-4.247 0 0 1.343-0.43 4.4 1.64 1.276-0.355 2.646-0.533 4.007-0.539 1.36 0.006 2.732 0.184 4.011 0.539 3.053-2.07 4.392-1.64 4.392-1.64 0.872 2.21 0.323 3.842 0.158 4.247 1.026 1.119 1.644 2.547 1.644 4.294 0 6.145-3.742 7.496-7.306 7.894 0.576 0.498 1.091 1.493 1.091 3.006 0 2.172-0.02 3.926-0.02 4.454 0 0.428 0.286 0.926 1.1 0.769 6.348-2.121 10.924-8.117 10.924-15.183 0-8.837-7.163-16-16-16z"></path>
                    </svg>
				</button>
			</div>
			<p class="signup">
				Don't have an account? <a rel="noopener noreferrer"
					href="loginForm.jsp">Sign up</a>
			</p>
		</div>
	</div>

	<!-- Error Modal -->
	<div class="error-modal" id="error-modal">
		<svg xmlns="http://www.w3.org/2000/svg" width="24" viewBox="0 0 24 24"
			height="24" fill="none">
            <path fill="#fff"
				d="m13 13h-2v-6h2zm0 4h-2v-2h2zm-1-15c-1.3132 0-2.61358.25866-3.82683.7612-1.21326.50255-2.31565 1.23915-3.24424 2.16773-1.87536 1.87537-2.92893 4.41891-2.92893 7.07107 0 2.6522 1.05357 5.1957 2.92893 7.0711.92859.9286 2.03098 1.6651 3.24424 2.1677 1.21325.5025 2.51363.7612 3.82683.7612 2.6522 0 5.1957-1.0536 7.0711-2.9289 1.8753-1.8754 2.9289-4.4189 2.9289-7.0711 0-1.3132-.2587-2.61358-.7612-3.82683-.5026-1.21326-1.2391-2.31565-2.1677-3.24424-.9286-.92858-2.031-1.66518-3.2443-2.16773-1.2132-.50254-2.5136-.7612-3.8268-.7612z"
				fill-rule="evenodd" clip-rule="evenodd" />
        </svg>
		<div class="error__title" id="error-title"></div>
		<div class="close" onclick="$('#error-modal').hide();">
			<svg xmlns="http://www.w3.org/2000/svg" width="20"
				viewBox="0 0 20 20" height="20">
                <path fill="#fff"
					d="m15.8333 5.34166-1.175-1.175-4.6583 4.65834-4.65833-4.65834-1.175 1.175 4.65833 4.65834-4.65833 4.6583 1.175 1.175 4.65833-4.6583 4.6583 4.6583 1.175-1.175-4.6583-4.6583z" />
            </svg>
		</div>
	</div>

	<script>
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
        });
    </script>
</body>
</html>
