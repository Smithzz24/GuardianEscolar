CREATE TABLE auditoria_ciudades (
    id_auditoria SERIAL PRIMARY KEY,
    id_ciudad INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_familia (
    id_auditoria SERIAL PRIMARY KEY,
    id_familia INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_escuelas (
    id_auditoria SERIAL PRIMARY KEY,
    id_escuela INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_perfil (
    id_auditoria SERIAL PRIMARY KEY,
    id_perfil INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_paradas (
    id_auditoria SERIAL PRIMARY KEY,
    id_parada INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_buses (
    id_auditoria SERIAL PRIMARY KEY,
    id_bus INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

-- RUTAS: Asegurar que tiene id_ruta primero
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'rutas' AND column_name = 'id_ruta') THEN
        ALTER TABLE rutas ADD COLUMN id_ruta SERIAL PRIMARY KEY;
    END IF;
END $$;

CREATE TABLE auditoria_rutas (
    id_auditoria SERIAL PRIMARY KEY,
    id_ruta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_tipoalertas (
    id_auditoria SERIAL PRIMARY KEY,
    id_tipoAlerta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_alertas (
    id_auditoria SERIAL PRIMARY KEY,
    id_alerta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_sedescolegios (
    id_auditoria SERIAL PRIMARY KEY,
    id_sede INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_cursos (
    id_auditoria SERIAL PRIMARY KEY,
    id_curso INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

-- 2. TABLAS DE RELACIÓN (CON CLAVES COMPUESTAS)
CREATE TABLE auditoria_abordajes (
    id_auditoria SERIAL PRIMARY KEY,
    id_perfil INT NOT NULL,
    id_bus INT NOT NULL,
    id_parada INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_familiamiembro (
    id_auditoria SERIAL PRIMARY KEY,
    id_familia INT NOT NULL,
    id_perfil INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_alertasguardadas (
    id_auditoria SERIAL PRIMARY KEY,
    id_perfil INT NOT NULL,
    id_alerta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

-- Crear tabla CORRECTA (con claves compuestas)
CREATE TABLE auditoria_asignacionrutas_estudiantes (
    id_auditoria SERIAL PRIMARY KEY,
    id_perfil INT NOT NULL,
    id_ruta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_asignacionrutas_buses (
    id_auditoria SERIAL PRIMARY KEY,
    id_bus INT NOT NULL,
    id_ruta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_recorridorutas (
    id_auditoria SERIAL PRIMARY KEY,
    id_parada INT NOT NULL,
    id_ruta INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_licenciasconductor (
    id_auditoria SERIAL PRIMARY KEY,
    id_licencia INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);

CREATE TABLE auditoria_perfilrol (
    id_auditoria SERIAL PRIMARY KEY,
    id_perfil INT NOT NULL,
    id_rol INT NOT NULL,
    accion VARCHAR(10) CHECK (accion IN ('INSERT', 'UPDATE', 'DELETE')),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(100) DEFAULT CURRENT_USER
);