const canvas = document.getElementById('drawingCanvas');
const ctx = canvas.getContext('2d');
const popup = document.getElementById('popup');
let painting = false;

function resizeCanvas() {
	canvas.width = window.innerWidth;
	canvas.height = window.innerHeight - document.querySelector('.navbar').offsetHeight;
	drawInitialImage();
}

window.addEventListener('resize', resizeCanvas);
resizeCanvas();

function drawInitialImage() {
	const img = new Image();
	img.src = 'images/Entry Vault.png'; // Image path within the source folder
	img.onload = function() {
		ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear canvas before drawing
		ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
	};
}

function startPosition(e) {
	painting = true;
	draw(e);
	showPopup();
}

function endPosition() {
	painting = false;
	ctx.beginPath();
}

function draw(e) {
	if (!painting) return;

	ctx.lineWidth = 5;
	ctx.lineCap = 'round';
	const rect = canvas.getBoundingClientRect();
	const xPos = e.clientX - rect.left;

	// Set stroke color based on x-coordinate
	if (xPos < canvas.width / 2) {
		ctx.strokeStyle = '#FFFFFF'; // White for left half
	} else {
		ctx.strokeStyle = '#000000'; // Black for right half
	}

	ctx.lineTo(xPos, e.clientY - rect.top);
	ctx.stroke();
	ctx.beginPath();
	ctx.moveTo(xPos, e.clientY - rect.top);
}

function clearCanvas() {
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	drawInitialImage();
}

function showPopup() {
	popup.style.display = 'block';
	setTimeout(() => {
		popup.style.display = 'none';
	}, 3000);
}

function scrollToCanvas() {
	document.getElementById('drawingForm').scrollIntoView({ behavior: 'smooth' });
}

canvas.addEventListener('mousedown', startPosition);
canvas.addEventListener('mouseup', endPosition);
canvas.addEventListener('mousemove', draw);
canvas.addEventListener('mouseleave', endPosition);

canvas.addEventListener('contextmenu', function(e) {
	e.preventDefault();
	clearCanvas();
});

drawInitialImage();
