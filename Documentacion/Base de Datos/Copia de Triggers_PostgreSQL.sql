-- Ciudades
CREATE OR REPLACE FUNCTION trigger_auditoria_ciudades()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_ciudades (id_ciudad, accion) 
    VALUES (COALESCE(NEW.id_ciudad, OLD.id_ciudad), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_ciudades ON ciudades;
CREATE TRIGGER trig_auditoria_ciudades
AFTER INSERT OR UPDATE OR DELETE ON ciudades
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_ciudades();

-- Familia
CREATE OR REPLACE FUNCTION trigger_auditoria_familia()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_familia (id_familia, accion) 
    VALUES (COALESCE(NEW.id_familia, OLD.id_familia), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_familia ON familia;
CREATE TRIGGER trig_auditoria_familia
AFTER INSERT OR UPDATE OR DELETE ON familia
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_familia();

-- Escuelas
CREATE OR REPLACE FUNCTION trigger_auditoria_escuelas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_escuelas (id_escuela, accion) 
    VALUES (COALESCE(NEW.id_escuela, OLD.id_escuela), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_escuelas ON escuelas;
CREATE TRIGGER trig_auditoria_escuelas
AFTER INSERT OR UPDATE OR DELETE ON escuelas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_escuelas();

-- Perfil
CREATE OR REPLACE FUNCTION trigger_auditoria_perfil()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_perfil (id_perfil, accion) 
    VALUES (COALESCE(NEW.id_perfil, OLD.id_perfil), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_perfil ON perfil;
CREATE TRIGGER trig_auditoria_perfil
AFTER INSERT OR UPDATE OR DELETE ON perfil
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_perfil();

-- Paradas
CREATE OR REPLACE FUNCTION trigger_auditoria_paradas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_paradas (id_parada, accion) 
    VALUES (COALESCE(NEW.id_parada, OLD.id_parada), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_paradas ON paradas;
CREATE TRIGGER trig_auditoria_paradas
AFTER INSERT OR UPDATE OR DELETE ON paradas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_paradas();

-- Buses
CREATE OR REPLACE FUNCTION trigger_auditoria_buses()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_buses (id_bus, accion) 
    VALUES (COALESCE(NEW.id_bus, OLD.id_bus), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_buses ON buses;
CREATE TRIGGER trig_auditoria_buses
AFTER INSERT OR UPDATE OR DELETE ON buses
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_buses();

-- Asegurar que Rutas tiene id_ruta
-- Rutas
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'rutas' AND column_name = 'id_ruta'
    ) THEN
        ALTER TABLE rutas ADD COLUMN id_ruta SERIAL PRIMARY KEY;
    END IF;
END $$;

CREATE OR REPLACE FUNCTION trigger_auditoria_rutas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_rutas (id_ruta, accion) 
    VALUES (COALESCE(NEW.id_ruta, OLD.id_ruta), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_rutas ON rutas;
CREATE TRIGGER trig_auditoria_rutas
AFTER INSERT OR UPDATE OR DELETE ON rutas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_rutas();

-- Tipo alertas
CREATE OR REPLACE FUNCTION trigger_auditoria_tipoalertas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_tipoalertas (id_tipoAlerta, accion) 
    VALUES (COALESCE(NEW.id_tipoAlerta, OLD.id_tipoAlerta), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_tipoalertas ON tipoalertas;
CREATE TRIGGER trig_auditoria_tipoalertas
AFTER INSERT OR UPDATE OR DELETE ON tipoalertas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_tipoalertas();

-- Alertas
CREATE OR REPLACE FUNCTION trigger_auditoria_alertas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_alertas (id_alerta, accion) 
    VALUES (COALESCE(NEW.id_alerta, OLD.id_alerta), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_alertas ON alertas;
CREATE TRIGGER trig_auditoria_alertas
AFTER INSERT OR UPDATE OR DELETE ON alertas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_alertas();

-- Sedes colegios
CREATE OR REPLACE FUNCTION trigger_auditoria_sedescolegios()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_sedescolegios (id_sede, accion) 
    VALUES (COALESCE(NEW.id_sede, OLD.id_sede), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_sedescolegios ON sedescolegios;
CREATE TRIGGER trig_auditoria_sedescolegios
AFTER INSERT OR UPDATE OR DELETE ON sedescolegios
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_sedescolegios();

-- Cursos
CREATE OR REPLACE FUNCTION trigger_auditoria_cursos()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_cursos (id_curso, accion) 
    VALUES (COALESCE(NEW.id_curso, OLD.id_curso), TG_OP);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_cursos ON cursos;
CREATE TRIGGER trig_auditoria_cursos
AFTER INSERT OR UPDATE OR DELETE ON cursos
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_cursos();

-- Abordajes
CREATE OR REPLACE FUNCTION trigger_auditoria_abordajes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_abordajes (id_perfil, id_bus, id_parada, accion) 
    VALUES (
        COALESCE(NEW.id_perfil, OLD.id_perfil),
        COALESCE(NEW.id_bus, OLD.id_bus),
        COALESCE(NEW.id_parada, OLD.id_parada),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_abordajes ON abordajes;
CREATE TRIGGER trig_auditoria_abordajes
AFTER INSERT OR UPDATE OR DELETE ON abordajes
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_abordajes();

-- Familia miembro
CREATE OR REPLACE FUNCTION trigger_auditoria_familiamiembro()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_familiamiembro (id_familia, id_perfil, accion) 
    VALUES (
        COALESCE(NEW.id_familia, OLD.id_familia),
        COALESCE(NEW.id_perfil, OLD.id_perfil),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_familiamiembro ON familiamiembro;
CREATE TRIGGER trig_auditoria_familiamiembro
AFTER INSERT OR UPDATE OR DELETE ON familiamiembro
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_familiamiembro();

-- Alertas guardadas
CREATE OR REPLACE FUNCTION trigger_auditoria_alertasguardadas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_alertasguardadas (id_perfil, id_alerta, accion) 
    VALUES (
        COALESCE(NEW.id_perfil, OLD.id_perfil),
        COALESCE(NEW.id_alerta, OLD.id_alerta),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_alertasguardadas ON alertasguardadas;
CREATE TRIGGER trig_auditoria_alertasguardadas
AFTER INSERT OR UPDATE OR DELETE ON alertasguardadas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_alertasguardadas();

-- Asignacion rtuas estudiantes
CREATE OR REPLACE FUNCTION trigger_auditoria_asignacionrutas_estudiantes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_asignacionrutas_estudiantes (id_perfil, id_ruta, accion) 
    VALUES (
        COALESCE(NEW.id_perfil, OLD.id_perfil),
        COALESCE(NEW.id_ruta, OLD.id_ruta),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_asignacionrutas_estudiantes ON asignacionrutas_estudiantes;
CREATE TRIGGER trig_auditoria_asignacionrutas_estudiantes
AFTER INSERT OR UPDATE OR DELETE ON asignacionrutas_estudiantes
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_asignacionrutas_estudiantes();

-- Asignacion rutas buses
CREATE OR REPLACE FUNCTION trigger_auditoria_asignacionrutas_buses()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_asignacionrutas_buses (id_bus, id_ruta, accion) 
    VALUES (
        COALESCE(NEW.id_bus, OLD.id_bus),
        COALESCE(NEW.id_ruta, OLD.id_ruta),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_asignacionrutas_buses ON asignacionrutas_buses;
CREATE TRIGGER trig_auditoria_asignacionrutas_buses
AFTER INSERT OR UPDATE OR DELETE ON asignacionrutas_buses
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_asignacionrutas_buses();

-- Recorridos rutas
CREATE OR REPLACE FUNCTION trigger_auditoria_recorridorutas()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_recorridorutas (id_parada, id_ruta, accion) 
    VALUES (
        COALESCE(NEW.id_parada, OLD.id_parada),
        COALESCE(NEW.id_ruta, OLD.id_ruta),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_recorridorutas ON recorridorutas;
CREATE TRIGGER trig_auditoria_recorridorutas
AFTER INSERT OR UPDATE OR DELETE ON recorridorutas
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_recorridorutas();

-- Licencias Conductores
CREATE OR REPLACE FUNCTION trigger_auditoria_licenciasconductor()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_licenciasconductor (id_licencia, accion) 
    VALUES (
        COALESCE(NEW.id_licencia, OLD.id_licencia),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_licencia ON licenciasconductores;
CREATE TRIGGER trig_auditoria_licenciaconductor
AFTER INSERT OR UPDATE OR DELETE ON licenciasconductores
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_licenciasconductor();

-- Perfil Rol
CREATE OR REPLACE FUNCTION trigger_auditoria_perfilrol()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_perfilrol (id_perfil, id_rol, accion) 
    VALUES (
        COALESCE(NEW.id_perfil, OLD.id_perfil),
        COALESCE(NEW.id_rol, OLD.id_rol),
        TG_OP
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trig_auditoria_perfilrol ON perfilrol;
CREATE TRIGGER trig_auditoria_perfilrol
AFTER INSERT OR UPDATE OR DELETE ON perfilrol
FOR EACH ROW EXECUTE FUNCTION trigger_auditoria_perfilrol();