-- Tabla Rol (debe crearse primero porque Perfil la referenciaba originalmente)
CREATE TABLE Rol (
    id_rol SERIAL PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT,
    Permisos TEXT
);

-- Tabla Ciudades
CREATE TABLE Ciudades (
    id_ciudad SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Pais VARCHAR(255) NOT NULL
);

-- Tabla Familia
CREATE TABLE Familia (
    id_familia SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Observaciones TEXT
);

-- Tabla Escuelas
CREATE TABLE Escuelas (
    id_escuela SERIAL PRIMARY KEY,
    id_ciudad INT,
    Nombre VARCHAR(300) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Logo BYTEA,
    Telefono INT,
    Correo VARCHAR(100),
    Pagina_Web TEXT,
    Tema VARCHAR(255)
    FOREIGN KEY (id_ciudad) REFERENCES Ciudades(id_ciudad),
);

-- Tabla Perfil
CREATE TABLE Perfil (
    id_perfil SERIAL PRIMARY KEY,
    Correo VARCHAR(255) NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    Telefono INT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    TipoIdentidad VARCHAR(50),
    Identificacion INTEGER,
    FechaNacimiento DATE,
    Direccion VARCHAR(255)
);

-- Tabla PerfilRol
CREATE TABLE PerfilRol (
    id_perfil INT,
    id_rol INT,
    PRIMARY KEY(id_perfil, id_rol),
    FOREIGN KEY(id_perfil) REFERENCES Perfil(id_perfil),
    FOREIGN KEY(id_rol) REFERENCES Rol(id_rol)
);

-- Tabla FamiliaMiembro
CREATE TABLE FamiliaMiembro (
    id_familia INT,
    id_perfil INT,
    PRIMARY KEY(id_familia, id_perfil)
    FOREIGN KEY (id_familia) REFERENCES Familia(id_familia),
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
);

-- Tabla LicenciasConductores
CREATE TABLE LicenciasConductores (
    id_licencia SERIAL PRIMARY KEY,
    id_perfil INT,
    Numero_Licencia INTEGER,
    LicenciaConduccion VARCHAR(255),
    Fecha_Vencimiento DATE,
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil)
);

-- Tabla Buses
CREATE TYPE estado_gps AS ENUM ('Arrancando', 'En ruta', 'Llegando', 'Detenido');

CREATE TABLE Buses (
    id_bus SERIAL PRIMARY KEY,
    id_perfil INT,
    id_escuela INT,
    Marca VARCHAR(40),
    Modelo VARCHAR(40),
    Capacidad INT,
    Vigencia_SOAT DATE,
    Estado_GPS estado_gps
    FOREIGN KEY (id_escuela) REFERENCES Escuelas(id_escuela),
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
);

-- Tabla Paradas
CREATE TABLE Paradas (
    id_parada SERIAL PRIMARY KEY,
    id_ciudad INT,
    id_escuela INT,
    Direccion VARCHAR(255) NOT NULL,
    Longitud INT,
    Latitud INT,
    FOREIGN KEY (id_escuela) REFERENCES Escuelas(id_escuela),
    FOREIGN KEY (id_ciudad) REFERENCES Ciudades(id_ciudad)
);

-- Tabla Rutas
CREATE TABLE Rutas (
    id_bus INT,
    id_escuela INT,
    Nombre VARCHAR(100),
    SectorDestino VARCHAR(100),
    HoraInicio TIME,
    HoraFinalizacion TIME,
    PRIMARY KEY(id_bus, id_escuela),
    FOREIGN KEY (id_bus) REFERENCES Buses(id_bus),
    FOREIGN KEY (id_escuela) REFERENCES Escuelas(id_escuela)
);

-- Tabla TipoAlertas
CREATE TABLE TipoAlertas (
    id_tipoAlerta SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    NivelUrgencia INT
);

-- Tabla Alertas
CREATE TABLE Alertas (
    id_alerta SERIAL PRIMARY KEY,
    id_tipoAlerta INT, 
    id_bus INT,
    id_escuela INT,
    FechaHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY (id_bus)REFERENCES Buses(id_bus),
    FOREIGN KEY (id_escuela)REFERENCES Escuelas(id_escuela),
    FOREIGN KEY (id_alerta)REFERENCES TipoAlertas(id_tipoAlerta),
);

-- Tabla AlertasGuardadas
CREATE TABLE AlertasGuardadas (
    id_perfil INT,
    id_alerta INT,
    PRIMARY KEY(id_perfil, id_alerta),
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
    FOREIGN KEY (id_alerta) REFERENCES Alertas(id_alerta),
);

-- Tabla Abordajes
CREATE TABLE Abordajes (
    id_bus INT,
    id_parada INT, 
    id_perfil INT, 
    PRIMARY KEY(id_bus, id_parada, id_perfil),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Accion BOOLEAN,
    FOREIGN KEY (id_bus) REFERENCES Buses(id_bus),
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
    FOREIGN KEY (id_parada) REFERENCES Paradas(id_parada),
);

-- Tabla SedesColegios
CREATE TABLE SedesColegios (
    id_sede SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    id_escuela INT, 
    Direccion VARCHAR(50),
    FOREIGN KEY (id_escuela) REFERENCES Escuelas(id_escuela),
);

-- Tabla Cursos
CREATE TABLE Cursos (
    id_curso SERIAL PRIMARY KEY,
    Nombre VARCHAR(100),
    id_sede INT,
    FOREIGN KEY (id_sede) REFERENCES SedesColegios(id_sede)
);

-- Tabla AsignacionRutas_Estudiantes
CREATE TABLE AsignacionRutas_Estudiantes (
    id_perfil INT,
    id_ruta INT,
    PRIMARY KEY(id_perfil, id_ruta),
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_bus, id_escuela)
);

-- Tabla AsignacionRutas_Buses
CREATE TABLE AsignacionRutas_Buses (
    id_bus INT,
    id_ruta INT,
    PRIMARY KEY(id_bus, id_ruta),
    FOREIGN KEY (id_bus) REFERENCES Buses(id_bus),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_bus, id_escuela)
);

-- Tabla RecorridoRutas
CREATE TABLE RecorridoRutas (
    id_parada INT,
    id_ruta INT,
    PRIMARY KEY(id_parada, id_ruta),
    FOREIGN KEY(id_parada) REFERENCES Paradas(id_parada),
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_bus, id_escuela)
);