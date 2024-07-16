$(document).ready(function() {
    $('#form1').validate({
        rules: {
            firstName: {
                required: true,
                lettersonly: true
            },
            lastName: {
                required: true,
                lettersonly: true
            },
            phoneNum: {
                required: true,
                digits: true,
                minlength: 11,
                maxlength: 11
            },
            birthday: {
                required: true
            },
            userName: {
                required: true,
                minlength: 5,
                maxlength: 15
            },
            password: {
                required: true,
                minlength: 8,
                passwordNeed: true
            }
        },
        messages: {
            firstName: {
                required: "First name is required.",
                lettersonly: "Please enter letters only."
            },
            lastName: {
                required: "Last name is required.",
                lettersonly: "Please enter letters only."
            },
            phoneNum: {
                required: "Mobile number is required.",
                digits: "Please enter numbers only.",
                minlength: "Mobile number must be exactly 11 digits.",
                maxlength: "Mobile number must be exactly 11 digits."
            },
            birthday: {
                required: "Birthday is required."
            },
            userName: {
                required: "User name is required.",
                minlength: "User name must be at least 5 characters long.",
                maxlength: "User name must be less than 15 characters long."
            },
            password: {
                required: "Password is required.",
                minlength: "Password must be at least 8 characters long.",
                passwordNeed: "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character."
            }
        },
        submitHandler: function(form) {
            form.submit();
        }
    });

    // Custom validator methods
   jQuery.validator.addMethod('lettersonly', function(value, element) {
    // Update the regular expression to allow letters and spaces
    return /^[a-zA-Z]+(?:\s[a-zA-Z]+)*$/.test(value);
    }, "Please enter letters only");

    jQuery.validator.addMethod('passwordNeed', function(value, element) {
        return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&._^#])[A-Za-z\d@$!%*?&._^# ]{8,}$/.test(value);
    }, "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.");
    
    
});
