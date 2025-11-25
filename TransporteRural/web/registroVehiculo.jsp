<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Vehículo - InDriver</title>
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
            max-width: 600px;
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

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #e0e0e0;
            border-radius: 3px;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: #2196F3;
            width: 50%;
            transition: width 0.3s ease;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s ease;
            background-color: white;
        }

        .form-group select {
            cursor: pointer;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #2196F3;
        }

        .file-upload {
            border: 2px dashed #e0e0e0;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .file-upload:hover {
            border-color: #2196F3;
            background: #f5f9ff;
        }

        .file-upload input {
            display: none;
        }

        .file-upload-text {
            color: #666;
            margin-bottom: 10px;
        }

        .file-upload-icon {
            font-size: 2em;
            color: #2196F3;
            margin-bottom: 10px;
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
            <h1>Registro de Vehículo</h1>
            <p>Completa la información de tu vehículo para comenzar a trabajar</p>
        </div>

        <div class="error-message" id="errorMessage"></div>

        <form action="VehiculoServlet" method="POST" enctype="multipart/form-data">
            
            <!-- Información del Vehículo -->
            <h3 style="color: #333; margin-bottom: 20px;">Información del Vehículo</h3>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="marca">Marca *</label>
                    <select id="marca" name="marca" required>
                        <option value="">Selecciona marca</option>
                        <option value="Toyota">Toyota</option>
                        <option value="Chevrolet">Chevrolet</option>
                        <option value="Mazda">Mazda</option>
                        <option value="Renault">Renault</option>
                        <option value="Nissan">Nissan</option>
                        <option value="Honda">Honda</option>
                        <option value="Hyundai">Hyundai</option>
                        <option value="Kia">Kia</option>
                        <option value="Ford">Ford</option>
                        <option value="Volkswagen">Volkswagen</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="modelo">Modelo *</label>
                    <input type="text" id="modelo" name="modelo" placeholder="Ej: Corolla, Spark" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="anio">Año *</label>
                    <input type="number" id="anio" name="anio" min="2000" max="2025" placeholder="2020" required>
                </div>

                <div class="form-group">
                    <label for="color">Color *</label>
                    <select id="color" name="color" required>
                        <option value="">Selecciona color</option>
                        <option value="Blanco">Blanco</option>
                        <option value="Negro">Negro</option>
                        <option value="Gris">Gris</option>
                        <option value="Plata">Plata</option>
                        <option value="Rojo">Rojo</option>
                        <option value="Azul">Azul</option>
                        <option value="Verde">Verde</option>
                        <option value="Amarillo">Amarillo</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="placa">Placa *</label>
                <input type="text" id="placa" name="placa" placeholder="ABC-123" style="text-transform: uppercase;" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="capacidad">Capacidad de Pasajeros *</label>
                    <select id="capacidad" name="capacidad" required>
                        <option value="">Selecciona</option>
                        <option value="2">2 pasajeros</option>
                        <option value="3">3 pasajeros</option>
                        <option value="4">4 pasajeros</option>
                        <option value="5">5 pasajeros</option>
                        <option value="6">6 pasajeros</option>
                        <option value="7">7 pasajeros</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="tipoVehiculo">Tipo de Vehículo *</label>
                    <select id="tipoVehiculo" name="tipoVehiculo" required>
                        <option value="">Selecciona tipo</option>
                        <option value="Sedan">Sedán</option>
                        <option value="Hatchback">Hatchback</option>
                        <option value="SUV">SUV</option>
                        <option value="Camioneta">Camioneta</option>
                        <option value="Van">Van</option>
                    </select>
                </div>
            </div>

            <!-- Documentos del Conductor -->
            <h3 style="color: #333; margin: 30px 0 20px 0;">Documentos del Conductor</h3>

            <div class="form-group">
                <label for="licencia">Número de Licencia *</label>
                <input type="text" id="licencia" name="licencia" placeholder="Número de licencia de conducir" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="categoriaLicencia">Categoría de Licencia *</label>
                    <select id="categoriaLicencia" name="categoriaLicencia" required>
                        <option value="">Selecciona</option>
                        <option value="B1">B1</option>
                        <option value="B2">B2</option>
                        <option value="B3">B3</option>
                        <option value="C1">C1</option>
                        <option value="C2">C2</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="vigenciaLicencia">Vigencia de Licencia *</label>
                    <input type="date" id="vigenciaLicencia" name="vigenciaLicencia" required>
                </div>
            </div>

            <!-- Documentos Opcionales -->
            <div class="form-group">
                <label>SOAT (Opcional)</label>
                <input type="text" id="soat" name="soat" placeholder="Número de SOAT">
            </div>

            <div class="form-group">
                <label>Tecnomecánica (Opcional)</label>
                <input type="text" id="tecnomecanica" name="tecnomecanica" placeholder="Número de revisión tecnomecánica">
            </div>

            <!-- Botones -->
            <div class="button-group">
                <button type="button" class="btn btn-secondary" onclick="window.location.href='index.html'">
                    Cancelar
                </button>
                <button type="submit" class="btn">
                    Completar Registro
                </button>
            </div>
        </form>
    </div>

    <script>
        // Convertir placa a mayúsculas automáticamente
        document.getElementById('placa').addEventListener('input', function(e) {
            e.target.value = e.target.value.toUpperCase();
        });

        // Validar fecha de vigencia (debe ser futura)
        document.querySelector('form').addEventListener('submit', function(e) {
            const vigencia = new Date(document.getElementById('vigenciaLicencia').value);
            const hoy = new Date();
            
            if (vigencia < hoy) {
                e.preventDefault();
                const errorMsg = document.getElementById('errorMessage');
                errorMsg.textContent = 'La licencia debe tener una fecha de vigencia válida';
                errorMsg.classList.add('show');
                window.scrollTo(0, 0);
            }
        });

        // Validar año del vehículo
        document.getElementById('anio').addEventListener('change', function() {
            const anio = parseInt(this.value);
            const anioActual = new Date().getFullYear();
            
            if (anio > anioActual) {
                const errorMsg = document.getElementById('errorMessage');
                errorMsg.textContent = 'El año del vehículo no puede ser mayor al año actual';
                errorMsg.classList.add('show');
                this.value = '';
            }
        });

        // Mostrar mensajes de error desde URL
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            
            if (error) {
                const errorMsg = document.getElementById('errorMessage');
                if (error === 'placa_existe') {
                    errorMsg.textContent = 'Esta placa ya está registrada en el sistema';
                } else if (error === 'registro_fallido') {
                    errorMsg.textContent = 'Error al registrar el vehículo. Intenta nuevamente';
                }
                errorMsg.classList.add('show');
            }
        };
    </script>
</body>
</html>