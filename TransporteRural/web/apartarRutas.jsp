<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rutas Disponibles - InDriver</title>
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
            padding: 20px;
        }

        .header {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            text-align: center;
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .routes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .route-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .route-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.15);
            border-color: #4CAF50;
        }

        .route-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .route-title {
            color: #333;
            font-size: 1.4em;
            font-weight: 600;
        }

        .route-status {
            background: #4CAF50;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .route-status.full {
            background: #f44336;
        }

        .route-info {
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            color: #555;
        }

        .info-label {
            font-weight: 600;
            color: #333;
            min-width: 120px;
        }

        .info-value {
            color: #666;
        }

        .route-points {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .point {
            display: flex;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .point:last-child {
            margin-bottom: 0;
        }

        .point-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: white;
            margin-right: 12px;
            flex-shrink: 0;
        }

        .point-icon.start {
            background: #4CAF50;
        }

        .point-icon.end {
            background: #2196F3;
        }

        .point-text {
            flex: 1;
            padding-top: 5px;
        }

        .point-label {
            font-size: 0.85em;
            color: #888;
            margin-bottom: 3px;
        }

        .point-location {
            color: #333;
            font-weight: 500;
        }

        .route-details {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .detail-box {
            text-align: center;
            flex: 1;
        }

        .detail-value {
            color: #2196F3;
            font-size: 1.5em;
            font-weight: 600;
        }

        .detail-label {
            color: #888;
            font-size: 0.85em;
            margin-top: 5px;
        }

        .btn-reserve {
            width: 100%;
            background: #4CAF50;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            font-size: 1.1em;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .btn-reserve:hover {
            background: #45a049;
            transform: scale(1.02);
        }

        .btn-reserve:active {
            transform: scale(0.98);
        }

        .btn-reserve:disabled {
            background: #cccccc;
            cursor: not-allowed;
            transform: none;
        }

        .no-routes {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .no-routes h2 {
            color: #666;
            margin-bottom: 10px;
        }

        .no-routes p {
            color: #999;
        }

        @media (max-width: 768px) {
            .routes-grid {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 1.5em;
            }

            .route-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Rutas Disponibles</h1>
            <p>Selecciona una ruta y reserva tu cupo</p>
        </div>
        
        <div class="routes-grid" id="routesContainer">
            <!-- Las rutas se cargarán dinámicamente aquí desde el servlet -->
        </div>
        
        <div class="no-routes" id="noRoutes" style="display: none;">
            <h2>No hay rutas disponibles</h2>
            <p>Por el momento no hay rutas activas. Vuelve más tarde.</p>
        </div>
    </div>

    <script>
        var rutas = <%= request.getAttribute("rutasJson") != null ? request.getAttribute("rutasJson") : "[]" %>;

        function getStatusClass(cuposDisponibles) {
            if (cuposDisponibles === 0) return 'full';
            return '';
        }

        function getStatusText(cuposDisponibles) {
            if (cuposDisponibles === 0) return 'Lleno';
            return 'Disponible';
        }

        function cargarRutas() {
            var container = document.getElementById('routesContainer');
            var noRoutes = document.getElementById('noRoutes');

            if (rutas.length === 0) {
                noRoutes.style.display = 'block';
                return;
            }

            var html = '';
            for (var i = 0; i < rutas.length; i++) {
                var ruta = rutas[i];
                var statusClass = getStatusClass(ruta.cuposDisponibles);
                var statusText = getStatusText(ruta.cuposDisponibles);
                var disabledAttr = ruta.cuposDisponibles === 0 ? 'disabled' : '';
                var buttonText = ruta.cuposDisponibles === 0 ? 'Sin Cupos' : 'Apartar Cupo';
                
                html += '<div class="route-card">';
                html += '  <div class="route-header">';
                html += '    <h2 class="route-title">' + ruta.titulo + '</h2>';
                html += '    <span class="route-status ' + statusClass + '">' + statusText + '</span>';
                html += '  </div>';
                
                html += '  <div class="route-points">';
                html += '    <div class="point">';
                html += '      <div class="point-icon start">A</div>';
                html += '      <div class="point-text">';
                html += '        <div class="point-label">Punto de Inicio</div>';
                html += '        <div class="point-location">' + ruta.puntoInicio + '</div>';
                html += '      </div>';
                html += '    </div>';
                html += '    <div class="point">';
                html += '      <div class="point-icon end">B</div>';
                html += '      <div class="point-text">';
                html += '        <div class="point-label">Punto de Fin</div>';
                html += '        <div class="point-location">' + ruta.puntoFin + '</div>';
                html += '      </div>';
                html += '    </div>';
                html += '  </div>';
                
                html += '  <div class="route-info">';
                html += '    <div class="info-row">';
                html += '      <span class="info-label">Conductor:</span>';
                html += '      <span class="info-value">' + ruta.conductor + '</span>';
                html += '    </div>';
                html += '    <div class="info-row">';
                html += '      <span class="info-label">Hora de salida:</span>';
                html += '      <span class="info-value">' + ruta.horaSalida + '</span>';
                html += '    </div>';
                html += '  </div>';
                
                html += '  <div class="route-details">';
                html += '    <div class="detail-box">';
                html += '      <div class="detail-value">
</body>
</html> + ruta.precio.toLocaleString() + '</div>';
                html += '      <div class="detail-label">Precio</div>';
                html += '    </div>';
                html += '    <div class="detail-box">';
                html += '      <div class="detail-value">' + ruta.cuposDisponibles + '/' + ruta.cuposTotales + '</div>';
                html += '      <div class="detail-label">Cupos</div>';
                html += '    </div>';
                html += '  </div>';
                
                html += '  <button class="btn-reserve" onclick="apartarRuta(' + ruta.id + ')" ' + disabledAttr + '>';
                html += buttonText;
                html += '  </button>';
                html += '</div>';
            }
            
            container.innerHTML = html;
        }

        function apartarRuta(rutaId) {
            if (confirm('¿Deseas apartar un cupo en esta ruta?')) {
                window.location.href = 'ReservaServlet?rutaId=' + rutaId + '&action=apartar';
            }
        }

        window.onload = function() {
            cargarRutas();
        };
    </script>
</body>
</html>