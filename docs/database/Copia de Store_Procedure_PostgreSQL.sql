-- Familias
CREATE OR REPLACE PROCEDURE insertar_familias(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Familia (Nombre, Observaciones)
    SELECT 
        'Familia ' || n,
        'Observaciones familia ' || n
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Familias insertadas', cantidad;
END;
$$;

-- Escuelas
CREATE OR REPLACE PROCEDURE insertar_escuelas(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay ciudades
    IF NOT EXISTS (SELECT 1 FROM Ciudades) THEN
        RAISE EXCEPTION 'Primero inserta ciudades';
    END IF;
    
    INSERT INTO Escuelas (id_ciudad, Nombre, Direccion, Telefono, Correo, Pagina_Web, Tema, Logo)
    SELECT 
        (n % (SELECT COUNT(*) FROM Ciudades)) + 1,
        'Colegio ' || n,
        'Calle ' || n || ' #' || (n*2),
        310000000 + n,
        'colegio' || n || '@edu.co',
        'http://colegio' || n || '.edu.co',
        'Tema' || n,
        'Logo' || n || 'institucional'
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Escuelas insertadas', cantidad;
END;
$$;

-- Perfil
-- Procedimiento MUY sencillo para insertar 500 perfiles
CREATE OR REPLACE PROCEDURE insertar_perfiles()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT;
BEGIN
    RAISE NOTICE 'Insertando 500 perfiles...';
    
    FOR i IN 1..500 LOOP
        INSERT INTO Perfil (
            Correo,
            Contraseña,
            Telefono,
            Nombre,
            Apellido,
            TipoIdentidad,
            Identificacion,
            FechaNacimiento,
            Direccion
        ) VALUES (
            'correo' || i || '@test.com',
            'pass' || i,
            3000000000 + i,
            'Nombre' || i,
            'Apellido' || i,
            CASE WHEN i % 2 = 0 THEN 'CC' ELSE 'TI' END,
            10000000 + i,
            '1990-01-01'::DATE + (i % 1000),
            'Direccion' || i
        );
        
        IF i % 100 = 0 THEN
            RAISE NOTICE 'Insertados % perfiles', i;
        END IF;
    END LOOP;
    
    RAISE NOTICE '¡Completado! 500 perfiles insertados.';
END;
$$;

-- Para ejecutar:
-- CALL Insertar500PerfilesSencillo();

-- Paradas
CREATE OR REPLACE PROCEDURE insertar_paradas(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay ciudades y escuelas
    IF NOT EXISTS (SELECT 1 FROM Ciudades) THEN
        RAISE EXCEPTION 'Primero inserta ciudades';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Escuelas) THEN
        RAISE EXCEPTION 'Primero inserta escuelas';
    END IF;
    
    INSERT INTO Paradas (id_ciudad, Direccion, Longitud, Latitud, id_escuela)
    SELECT 
        (n % (SELECT COUNT(*) FROM Ciudades)) + 1,
        'Parada ' || n || ' - Cra ' || n || ' #' || (n*2),
        74.0 + (n * 0.01),
        4.0 + (n * 0.01),
        (n % (SELECT COUNT(*) FROM Escuelas)) + 1
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Paradas insertadas', cantidad;
END;
$$;

-- Buses
CREATE OR REPLACE PROCEDURE insertar_buses(cantidad INT DEFAULT 50)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay escuelas y conductores
    IF NOT EXISTS (SELECT 1 FROM Escuelas) THEN
        RAISE EXCEPTION 'Primero inserta escuelas';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Conductores) THEN
        RAISE EXCEPTION 'Primero inserta conductores';
    END IF;
    
    INSERT INTO Buses (id_escuela, Marca, Modelo, id_perfil, Capacidad, Vigencia_SOAT, Estado_GPS)
    SELECT 
        (n % (SELECT COUNT(*) FROM Escuelas)) + 1,
        CASE (n % 5)
            WHEN 0 THEN 'Mercedes'
            WHEN 1 THEN 'Volvo'
            WHEN 2 THEN 'Scania'
            WHEN 3 THEN 'Hino'
            ELSE 'Toyota'
        END,
        'Modelo ' || (2020 + (n % 5)),
        (n % (SELECT COUNT(*) FROM Conductores)) + 1,
        40 + (n % 21),
        CURRENT_DATE + (INTERVAL '1 year'),
        CASE (n % 4)
            WHEN 0 THEN 'Arrancando'
            WHEN 1 THEN 'En ruta'
            WHEN 2 THEN 'Llegando'
            ELSE 'Detenido'
        END::estado_gps
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Buses insertados', cantidad;
END;
$$;

-- Sedes colegios
CREATE OR REPLACE PROCEDURE insertar_sedes(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay escuelas
    IF NOT EXISTS (SELECT 1 FROM Escuelas) THEN
        RAISE EXCEPTION 'Primero inserta escuelas';
    END IF;
    
    INSERT INTO SedesColegios (Nombre, id_escuela, Direccion)
    SELECT 
        'Sede Principal - Colegio ' || n,
        (n % (SELECT COUNT(*) FROM Escuelas)) + 1,
        'Dirección Sede ' || n || ', Cra ' || n || ' #' || (n*3)
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % SedesColegios insertadas', cantidad;
END;
$$;

-- Cursos
CREATE OR REPLACE PROCEDURE insertar_cursos(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay sedes y escuelas
    IF NOT EXISTS (SELECT 1 FROM SedesColegios) THEN
        RAISE EXCEPTION 'Primero inserta sedes';
    END IF;
    
    INSERT INTO Cursos (Nombre, id_sede)
    SELECT 
        CASE (n % 12)
            WHEN 0 THEN 'Transición'
            WHEN 1 THEN 'Primero'
            WHEN 2 THEN 'Segundo'
            WHEN 3 THEN 'Tercero'
            WHEN 4 THEN 'Cuarto'
            WHEN 5 THEN 'Quinto'
            WHEN 6 THEN 'Sexto'
            WHEN 7 THEN 'Séptimo'
            WHEN 8 THEN 'Octavo'
            WHEN 9 THEN 'Noveno'
            WHEN 10 THEN 'Décimo'
            ELSE 'Undécimo'
        END || ' - Grupo ' || chr(65 + (n % 5)),
        (n % (SELECT COUNT(*) FROM SedesColegios)) + 1
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Cursos insertados', cantidad;
END;
$$;

-- Rutas
CREATE OR REPLACE PROCEDURE insertar_rutas(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Asegurar que Rutas tiene id_ruta
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'rutas' AND column_name = 'id_ruta'
    ) THEN
        ALTER TABLE rutas ADD COLUMN id_ruta SERIAL PRIMARY KEY;
    END IF;
    
    INSERT INTO Rutas (id_escuela, Nombre, SectorDestino, HoraInicio, HoraFinalizacion)
    SELECT 
        ((n - 1) % (SELECT COUNT(*) FROM Escuelas)) + 1,
        'Ruta ' || n,
        CASE (n % 6)
            WHEN 0 THEN 'Zona Norte'
            WHEN 1 THEN 'Zona Sur'
            WHEN 2 THEN 'Zona Este'
            WHEN 3 THEN 'Zona Oeste'
            WHEN 4 THEN 'Centro'
            ELSE 'Periferia'
        END,
        TIME '06:30:00' + (INTERVAL '10 minutes' * (n % 12)),
        TIME '15:00:00' + (INTERVAL '10 minutes' * (n % 12))
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Rutas insertadas', cantidad;
END;
$$;

-- ALlertas
CREATE OR REPLACE PROCEDURE insertar_alertas(cantidad INT DEFAULT 50)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay buses, escuelas y tipoalertas
    IF NOT EXISTS (SELECT 1 FROM Buses) THEN
        RAISE EXCEPTION 'Primero inserta buses';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Escuelas) THEN
        RAISE EXCEPTION 'Primero inserta escuelas';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM TipoAlertas) THEN
        RAISE EXCEPTION 'Primero inserta tipoalertas';
    END IF;
    
    INSERT INTO Alertas (id_tipoAlerta, id_bus, id_escuela, FechaHora)
    SELECT 
        (n % (SELECT COUNT(*) FROM TipoAlertas)) + 1,
        (n % (SELECT COUNT(*) FROM Buses)) + 1,
        (n % (SELECT COUNT(*) FROM Escuelas)) + 1,
        CURRENT_TIMESTAMP - (n * INTERVAL '1 hour')
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % Alertas insertadas', cantidad;
END;
$$;

-- Familia miembro
CREATE OR REPLACE PROCEDURE insertar_familia_miembro(cantidad INT DEFAULT 100)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que hay familias y estudiantes
    IF NOT EXISTS (SELECT 1 FROM Familia) THEN
        RAISE EXCEPTION 'Primero inserta familias';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM Estudiantes) THEN
        RAISE EXCEPTION 'Primero inserta estudiantes';
    END IF;
    
    -- Relacionar cada estudiante con una familia
    INSERT INTO FamiliaMiembro (id_familia, id_perfil)
    SELECT 
        (ROW_NUMBER() OVER () % (SELECT COUNT(*) FROM Familia)) + 1,
        id_perfil
    FROM Estudiantes
    LIMIT cantidad;
    
    RAISE NOTICE '✓ % FamiliaMiembro insertados', cantidad;
END;
$$;

-- Alertas guardadas
CREATE OR REPLACE PROCEDURE insertar_alertas_guardadas(cantidad INT DEFAULT 30)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO AlertasGuardadas (id_perfil, id_alerta)
    SELECT 
        ((ROW_NUMBER() OVER () - 1) % (SELECT COUNT(*) FROM Perfil)) + (SELECT MIN(id_perfil) FROM Perfil),
        id_alerta
    FROM Alertas
    LIMIT cantidad;
    
    RAISE NOTICE '✓ % AlertasGuardadas insertadas', cantidad;
END;
$$;

-- Abordajes
CREATE OR REPLACE PROCEDURE insertar_abordajes(cantidad INT DEFAULT 50)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Abordajes (id_perfil, id_bus, id_parada, fecha_hora, Accion)
    SELECT 
        e.id_perfil,
        ((ROW_NUMBER() OVER () - 1) % (SELECT COUNT(*) FROM Buses)) + 1,
        ((ROW_NUMBER() OVER () - 1) % (SELECT COUNT(*) FROM Paradas)) + 1,
        CURRENT_TIMESTAMP - (((ROW_NUMBER() OVER () - 1) % 48) * INTERVAL '30 minutes'),
        CASE WHEN (ROW_NUMBER() OVER () % 2) = 0 THEN FALSE ELSE TRUE END
    FROM Perfil e
    LIMIT cantidad;
    
    RAISE NOTICE '✓ % Abordajes insertados', cantidad;
END;
$$;

-- Asignacion rutas estudiantes
CREATE OR REPLACE PROCEDURE insertar_asignacion_rutas_estudiantes(cantidad INT DEFAULT 50)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO AsignacionRutas_Estudiantes (id_perfil, id_ruta)
    SELECT 
        e.id_perfil,
        ((ROW_NUMBER() OVER () - 1) % (SELECT COUNT(*) FROM Rutas)) + 1
    FROM Perfil e
    LIMIT cantidad;
    
    RAISE NOTICE '✓ % AsignacionRutas_Estudiantes insertados', cantidad;
END;
$$;

-- Asignacion rutas buses
CREATE OR REPLACE PROCEDURE insertar_asignacion_rutas_buses(cantidad INT DEFAULT 30)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO AsignacionRutas_Buses (id_bus, id_ruta)
    SELECT 
        b.id_bus,
        ((ROW_NUMBER() OVER () - 1) % (SELECT COUNT(*) FROM Rutas)) + 1
    FROM Buses b
    LIMIT cantidad;
    
    RAISE NOTICE '✓ % AsignacionRutas_Buses insertados', cantidad;
END;
$$;

-- Recorrido rutas
CREATE OR REPLACE PROCEDURE insertar_recorrido_rutas(cantidad INT DEFAULT 50)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO RecorridoRutas (id_parada, id_ruta)
    SELECT 
        ((n - 1) % (SELECT COUNT(*) FROM Paradas)) + 1,
        ((n - 1) % (SELECT COUNT(*) FROM Rutas)) + 1
    FROM generate_series(1, cantidad) n;
    
    RAISE NOTICE '✓ % RecorridoRutas insertados', cantidad;
END;
$$;

-- Perfil Rol
CREATE OR REPLACE PROCEDURE InsertarPerfilRolLicenciasConductores()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT;
    perfil_id INT;
    rol_id INT;
BEGIN
    RAISE NOTICE 'Insertando 500 registros en PerfilRol...';
    
    FOR i IN 1..500 LOOP
        SELECT id_perfil INTO perfil_id 
        FROM Perfil 
        ORDER BY RANDOM() 
        LIMIT 1;
        
        IF perfil_id IS NULL THEN
            perfil_id := i;
        END IF;

        rol_id := ((i - 1) % 4) + 1;

        INSERT INTO PerfilRol (id_perfil, id_rol)
        VALUES (perfil_id, rol_id)
        ON CONFLICT (id_perfil, id_rol) DO NOTHING;
        
        IF i % 100 = 0 THEN
            RAISE NOTICE 'PerfilRol: % registros insertados', i;
        END IF;
    END LOOP;
    
    
    RAISE NOTICE 'Insertando 500 registros en LicenciasConductores...';
    
    FOR i IN 1..500 LOOP
        SELECT id_perfil INTO perfil_id 
        FROM Perfil 
        ORDER BY RANDOM() 
        LIMIT 1;
        
        IF perfil_id IS NULL THEN
            perfil_id := i;
        END IF;

        INSERT INTO LicenciasConductores (
            id_perfil, 
            Numero_Licencia, 
            LicenciaConduccion, 
            Fecha_Vencimiento
        ) VALUES (
            perfil_id,
            100000 + i,
            CASE 
                WHEN i % 3 = 0 THEN 'C1 - Transporte Público'
                WHEN i % 3 = 1 THEN 'B1 - Particular'
                ELSE 'C2 - Transporte Escolar'
            END,
            CURRENT_DATE + (365 * (2 + (i % 3)))
        )
        ON CONFLICT DO NOTHING;

        IF i % 100 = 0 THEN
            RAISE NOTICE 'LicenciasConductores: % registros insertados', i;
        END IF;
    END LOOP;
    
    RAISE NOTICE '¡Completado! 500 registros insertados en cada tabla.';
    
END;
$$;

--------------------------------------------------------
CALL insertar_familias(500);
CALL insertar_escuelas(500);
CALL insertar_perfiles();
CALL insertar_paradas(500);
CALL insertar_conductores(500);
CALL insertar_buses(500);
CALL insertar_sedes(500);
CALL insertar_cursos(500);
CALL insertar_estudiantes(500);
CALL insertar_acudientes(500);
CALL insertar_administradores(500);
CALL insertar_rutas(500);
CALL insertar_alertas(500);
CALL insertar_familia_miembro(500);
CALL insertar_alertas_guardadas(500);
CALL insertar_abordajes(500);
CALL insertar_asignacion_rutas_estudiantes(500);
CALL insertar_asignacion_rutas_buses(500);
CALL insertar_recorrido_rutas(500);
CALL InsertarPerfilRolLicenciasConductores();

-----------------------------------------------------
TRUNCATE TABLE 
    Abordajes,
    AlertasGuardadas,
    Alertas,
    AsignacionRutas_Estudiantes,
    AsignacionRutas_Buses,
    RecorridoRutas,
    Estudiantes,
    Acudientes,
    Administradores,
    Conductores,
    Cursos,
    SedesColegios,
    Rutas,
    FamiliaMiembro,
    Perfil,
    Paradas,
    Buses,
    Escuelas,
    Familia,
    TipoAlertas,
    Ciudades
RESTART IDENTITY;