<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Ruta - InDriver</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 700px;
            width: 100%;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #333;
            font-size: 2em;
            margin-bottom: 10px;
        }

        .header p {
            color: #666;
            font-size: 1em;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s ease;
            background-color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-group select {
            cursor: pointer;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #2196F3;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .section-title {
            color: #333;
            font-size: 1.3em;
            margin: 30px 0 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .section-title:first-of-type {
            margin-top: 0;
        }

        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196F3;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .info-box p {
            color: #1565c0;
            font-size: 0.9em;
            line-height: 1.5;
            margin: 0;
        }

        .btn {
            width: 100%;
            background: #2196F3;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 1.1em;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            margin-top: 10px;
        }

        .btn:hover {
            background: #1976D2;
        }

        .btn:active {
            transform: scale(0.98);
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #d0d0d0;
        }

        .button-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 20px;
        }

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        @media (max-width: 768px) {
            .container {
                padding: 25px;
            }

            .header h1 {
                font-size: 1.5em;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .button-group {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Crear Nueva Ruta</h1>
            <p>Completa la información de tu ruta</p>
        </div>

        <div class="error-message" id="errorMessage"></div>

        <form action="CrearRutaServlet" method="POST" id="rutaForm">
            
            <h3 class="section-title">Información Básica</h3>

            <div class="form-group">
                <label for="titulo">Título de la Ruta *</label>
                <input type="text" id="titulo" name="titulo" placeholder="Ej: Ruta Centro-Universidad" required>
            </div>

            <h3 class="section-title">Puntos de Recorrido</h3>

            <div class="form-group">
                <label for="puntoInicio">Punto de Inicio *</label>
                <input type="text" id="puntoInicio" name="puntoInicio" placeholder="Ej: Centro Comercial Buenavista" required>
            </div>

            <div class="form-group">
                <label for="puntoFin">Punto de Fin *</label>
                <input type="text" id="puntoFin" name="puntoFin" placeholder="Ej: Universidad del Norte" required>
            </div>

            <h3 class="section-title">Detalles del Viaje</h3>

            <div class="form-row">
                <div class="form-group">
                    <label for="fecha">Fecha del Viaje *</label>
                    <input type="date" id="fecha" name="fecha" required>
                </div>

                <div class="form-group">
                    <label for="horaSalida">Hora de Salida *</label>
                    <input type="time" id="horaSalida" name="horaSalida" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="cuposTotales">Cupos Disponibles *</label>
                    <select id="cuposTotales" name="cuposTotales" required>
                        <option value="">Selecciona</option>
                        <option value="1">1 pasajero</option>
                        <option value="2">2 pasajeros</option>
                        <option value="3">3 pasajeros</option>
                        <option value="4">4 pasajeros</option>
                        <option value="5">5 pasajeros</option>
                        <option value="6">6 pasajeros</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="precio">Precio por Persona (COP) *</label>
                    <input type="number" id="precio" name="precio" placeholder="5000" min="1000" step="500" required>
                </div>
            </div>

            <div class="form-group">
                <label for="vehiculo">Vehículo *</label>
                <select id="vehiculo" name="vehiculo" required>
                    <option value="">Selecciona tu vehículo</option>
                    <!-- Los vehículos se cargarán desde el servlet -->
                </select>
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-secondary" onclick="history.back()">
                    Cancelar
                </button>
                <button type="submit" class="btn">
                    Crear Ruta
                </button>
            </div>
        </form>
    </div>

    <script>
        // Establecer fecha mínima (hoy)
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('fecha').setAttribute('min', today);

        // Cargar vehículos del conductor (vendrían del servlet)
        var vehiculos = <%= request.getAttribute("vehiculosJson") != null ? request.getAttribute("vehiculosJson") : "[]" %>;
        
        function cargarVehiculos() {
            var select = document.getElementById('vehiculo');
            
            if (vehiculos.length === 0) {
                select.innerHTML = '<option value="">No tienes vehículos registrados</option>';
                select.disabled = true;
                document.getElementById('rutaForm').addEventListener('submit', function(e) {
                    e.preventDefault();
                    alert('Debes registrar un vehículo antes de crear una ruta');
                    window.location.href = 'registro-vehiculo.jsp';
                });
                return;
            }
            
            var html = '<option value="">Selecciona tu vehículo</option>';
            for (var i = 0; i < vehiculos.length; i++) {
                var v = vehiculos[i];
                html += '<option value="' + v.id + '">' + v.marca + ' ' + v.modelo + ' - ' + v.placa + '</option>';
            }
            select.innerHTML = html;
        }

        // Validar formulario
        document.getElementById('rutaForm').addEventListener('submit', function(e) {
            var fecha = new Date(document.getElementById('fecha').value);
            var hoy = new Date();
            hoy.setHours(0, 0, 0, 0);
            
            if (fecha < hoy) {
                e.preventDefault();
                var errorMsg = document.getElementById('errorMessage');
                errorMsg.textContent = 'La fecha del viaje no puede ser anterior a hoy';
                errorMsg.classList.add('show');
                window.scrollTo(0, 0);
                return false;
            }
            
            var precio = parseInt(document.getElementById('precio').value);
            if (precio < 1000) {
                e.preventDefault();
                var errorMsg = document.getElementById('errorMessage');
                errorMsg.textContent = 'El precio mínimo es de $1,000 COP';
                errorMsg.classList.add('show');
                window.scrollTo(0, 0);
                return false;
            }
        });

        // Formatear precio mientras se escribe
        document.getElementById('precio').addEventListener('input', function(e) {
            var value = e.target.value.replace(/\D/g, '');
            e.target.value = value;
        });

        // Mostrar mensajes de error desde URL
        window.onload = function() {
            cargarVehiculos();
            
            var urlParams = new URLSearchParams(window.location.search);
            var error = urlParams.get('error');
            
            if (error) {
                var errorMsg = document.getElementById('errorMessage');
                if (error === 'no_vehiculo') {
                    errorMsg.textContent = 'Debes registrar un vehículo antes de crear rutas';
                } else if (error === 'creacion_fallida') {
                    errorMsg.textContent = 'Error al crear la ruta. Intenta nuevamente';
                }
                errorMsg.classList.add('show');
            }
        };
    </script>
</body>
</html>