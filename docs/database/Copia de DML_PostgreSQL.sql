INSERT INTO Ciudades (Nombre, Pais) VALUES
('Bogotá', 'Colombia'),
('Medellín', 'Colombia'),
('Cali', 'Colombia'),
('Barranquilla', 'Colombia'),
('Cartagena', 'Colombia'),
('Cúcuta', 'Colombia'),
('Bucaramanga', 'Colombia'),
('Pereira', 'Colombia'),
('Santa Marta', 'Colombia'),
('Manizales', 'Colombia'),
('Ibagué', 'Colombia'),
('Villavicencio', 'Colombia'),
('Pasto', 'Colombia'),
('Montería', 'Colombia'),
('Neiva', 'Colombia'),
('Armenia', 'Colombia'),
('Sincelejo', 'Colombia'),
('Popayán', 'Colombia'),
('Valledupar', 'Colombia'),
('Riohacha', 'Colombia');

INSERT INTO TipoAlertas (Nombre, Descripcion, NivelUrgencia) VALUES
('Accidente', 'Accidente de tránsito', 5),
('Retraso', 'Bus retrasado', 3),
('Desvío', 'Cambio en la ruta', 2),
('Emergencia', 'Emergencia médica', 5),
('Mantenimiento', 'Bus en mantenimiento', 1),
('Clima', 'Condiciones climáticas adversas', 4),
('Tráfico', 'Congestión vehicular', 3),
('Protestas', 'Manifestaciones en la vía', 4),
('Falla Técnica', 'Problema mecánico', 3),
('Otro', 'Otra situación no especificada', 1);

INSERT INTO rol (nombre, descripcion, permisos) values
('Administrador', 'El administrador sera el encargado de gestionar el sistema del aplicativo.', 'Permisos de gestionar el sistema.'),
('Estudiante', 'El estudiante quien hara uso del aplicativo.', 'Permiso de escanear el codigo QR.'),
('Acudiente', 'El Acudiente quien hara uso del aplicativo.', 'Permiso de visualizar en el mapa el recorrido de la ruta'),
('Conductor', 'El conductor quien hara uso del aplicativo, y realizara el recorrido de las rutas', 'Permiso de visualizar en el mapa el recorrido de la ruta');