$(document).ready(function() {
    console.log("Document is ready"); // For debugging

    $("#form1").validate({
        rules: {
            userName: {
                required: true,
            },
            password: {
                required: true,
            }
        },
        messages: {
            userName: {
                required: "Please enter your username",
            },
            password: {
                required: "Please provide a password",
            }
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});
