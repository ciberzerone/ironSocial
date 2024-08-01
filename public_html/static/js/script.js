// Validación de registro
function validateRegisterForm() {
    const username = document.getElementById('username_reg').value.trim();
    const email = document.getElementById('email_reg').value.trim();
    const password = document.getElementById('password_reg').value.trim();

    if (username === '') {
        alert('El nombre de usuario es obligatorio.');
        return false;
    }

    if (email === '') {
        alert('El correo electrónico es obligatorio.');
        return false;
    }

    if (!validateEmail(email)) {
        alert('Por favor, introduce un correo electrónico válido.');
        return false;
    }

    if (password === '') {
        alert('La contraseña es obligatoria.');
        return false;
    }

    if (password.length < 6) {
        alert('La contraseña debe tener al menos 6 caracteres.');
        return false;
    }

    return true;
}

// Validación de inicio de sesión
function validateLoginForm() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value.trim();

    if (email === '') {
        alert('El correo electrónico es obligatorio.');
        return false;
    }

    if (!validateEmail(email)) {
        alert('Por favor, introduce un correo electrónico válido.');
        return false;
    }

    if (password === '') {
        alert('La contraseña es obligatoria.');
        return false;
    }

    return true;
}

// Función para validar correos electrónicos
function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

// Agregar eventos de validación al cargar la página
window.onload = function() {
    const registerForm = document.querySelector('#register form');
    if (registerForm) {
        registerForm.onsubmit = validateRegisterForm;
    }

    const loginForm = document.querySelector('#login form');
    if (loginForm) {
        loginForm.onsubmit = validateLoginForm;
    }

    const nextBtn = document.getElementById('next-btn');
    if (nextBtn) {
        nextBtn.addEventListener('click', function(event) {
            event.preventDefault(); // Prevenir el envío del formulario
            const email = document.getElementById('email').value.trim();
            if (email !== '' && validateEmail(email)) {
                document.getElementById('email-display').textContent = `Introduce la contraseña para ${email}`;
                document.getElementById('email-form').classList.add('hidden');
                document.getElementById('password-form').classList.remove('hidden');
            } else {
                alert('Por favor, introduce un correo electrónico válido.');
            }
        });
    }

    const backBtn = document.getElementById('back-btn');
    if (backBtn) {
        backBtn.addEventListener('click', function(event) {
            event.preventDefault();
            document.getElementById('password-form').classList.add('hidden');
            document.getElementById('email-form').classList.remove('hidden');
        });
    }
};
