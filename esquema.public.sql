
CREATE SEQUENCE public.nivel_prioridad_id_seq;

CREATE TABLE public.nivel_prioridad (
                id INTEGER NOT NULL DEFAULT nextval('public.nivel_prioridad_id_seq'),
                nombre VARCHAR NOT NULL,
                descripcion VARCHAR,
                prioridad VARCHAR NOT NULL,
                numero VARCHAR NOT NULL,
                CONSTRAINT nivel_prioridad_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.nivel_prioridad_id_seq OWNED BY public.nivel_prioridad.id;

CREATE SEQUENCE public.persona_id_seq;

CREATE TABLE public.persona (
                id INTEGER NOT NULL DEFAULT nextval('public.persona_id_seq'),
                cedula VARCHAR NOT NULL,
                nombres VARCHAR NOT NULL,
                apellidos VARCHAR NOT NULL,
                direccion VARCHAR,
                telefono VARCHAR,
                genero VARCHAR,
                activo BOOLEAN,
                fecha_alta TIMESTAMP NOT NULL,
                usuario_modificacion INTEGER NOT NULL,
                fecha_modificacion TIMESTAMP NOT NULL,
                usuario_alta INTEGER NOT NULL,
                CONSTRAINT persona_pk PRIMARY KEY (id)
);
COMMENT ON TABLE public.persona IS 'tabla para registrar personas sean fisicas o juridicas.';
COMMENT ON COLUMN public.persona.id IS 'identificador unico en la bd de cada persona';


ALTER SEQUENCE public.persona_id_seq OWNED BY public.persona.id;

CREATE INDEX persona_nombre_idx
 ON public.persona
 ( nombres ASC );

CREATE UNIQUE INDEX persona_cedula_unique_idx
 ON public.persona
 ( cedula );

CREATE SEQUENCE public.usuario_id_seq;

CREATE TABLE public.usuario (
                id INTEGER NOT NULL DEFAULT nextval('public.usuario_id_seq'),
                persona_id INTEGER NOT NULL,
                username VARCHAR NOT NULL,
                correo VARCHAR NOT NULL,
                password VARCHAR NOT NULL,
                activo BOOLEAN,
                usuario_alta INTEGER NOT NULL,
                fecha_alta TIMESTAMP NOT NULL,
                usuario_modificacion INTEGER NOT NULL,
                fecha_modificacion TIMESTAMP NOT NULL,
                CONSTRAINT usuario_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;

CREATE UNIQUE INDEX usuario_username_unique_idx
 ON public.usuario
 ( username );

CREATE SEQUENCE public.empresa_id_seq;

CREATE TABLE public.empresa (
                id INTEGER NOT NULL DEFAULT nextval('public.empresa_id_seq'),
                usuario_modificacion INTEGER NOT NULL,
                ruc VARCHAR,
                razon_social VARCHAR,
                telefono VARCHAR,
                direccion VARCHAR,
                correo VARCHAR,
                activo BOOLEAN NOT NULL,
                usuario_alta INTEGER NOT NULL,
                fecha_alta TIMESTAMP NOT NULL,
                fecha_modificacion TIMESTAMP NOT NULL,
                CONSTRAINT empresa_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.empresa_id_seq OWNED BY public.empresa.id;

CREATE SEQUENCE public.servicio_id_seq;

CREATE TABLE public.servicio (
                id INTEGER NOT NULL DEFAULT nextval('public.servicio_id_seq'),
                usuario_modificacion INTEGER NOT NULL,
                nombre VARCHAR NOT NULL,
                descripcion VARCHAR,
                cant_colas INTEGER NOT NULL,
                empresa_id INTEGER NOT NULL,
                activo BOOLEAN,
                usuario_alta INTEGER NOT NULL,
                fecha_alta TIMESTAMP NOT NULL,
                fecha_modificacion TIMESTAMP NOT NULL,
                CONSTRAINT servicio_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.servicio_id_seq OWNED BY public.servicio.id;

CREATE SEQUENCE public.cliente_id_seq;

CREATE TABLE public.cliente (
                id INTEGER NOT NULL DEFAULT nextval('public.cliente_id_seq'),
                persona_id INTEGER NOT NULL,
                usuario_modificacion INTEGER NOT NULL,
                usuario_alta INTEGER NOT NULL,
                activo BOOLEAN,
                fecha_alta TIMESTAMP NOT NULL,
                fecha_modificacion TIMESTAMP NOT NULL,
                CONSTRAINT cliente_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;

CREATE SEQUENCE public.atencion_id_seq;

CREATE TABLE public.atencion (
                id INTEGER NOT NULL DEFAULT nextval('public.atencion_id_seq'),
                nro_ticket INTEGER NOT NULL,
                nro_turno INTEGER NOT NULL,
                servicio_id INTEGER NOT NULL,
                nivel_prioridad_id INTEGER NOT NULL,
                cliente_id INTEGER NOT NULL,
                activo BOOLEAN,
                fecha_atencion TIMESTAMP NOT NULL,
                usuario_modificacion INTEGER NOT NULL,
                usuario_alta INTEGER NOT NULL,
                usuario_atencion_id INTEGER NOT NULL,
                fecha_alta TIMESTAMP NOT NULL,
                fecha_modificacion TIMESTAMP NOT NULL,
                usuario_finalizacion INTEGER NOT NULL,
                fecha_finalizacion TIMESTAMP NOT NULL,
                CONSTRAINT atencion_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.atencion_id_seq OWNED BY public.atencion.id;

ALTER TABLE public.atencion ADD CONSTRAINT nivel_prioridad_atencion_fk
FOREIGN KEY (nivel_prioridad_id)
REFERENCES public.nivel_prioridad (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cliente ADD CONSTRAINT persona_cliente_fk
FOREIGN KEY (persona_id)
REFERENCES public.persona (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.usuario ADD CONSTRAINT persona_usuario_fk
FOREIGN KEY (persona_id)
REFERENCES public.persona (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cliente ADD CONSTRAINT usuario_alta_cliente_fk
FOREIGN KEY (usuario_alta)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.atencion ADD CONSTRAINT usuario_atencion_fk
FOREIGN KEY (usuario_alta)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cliente ADD CONSTRAINT usuario_cliente_fk
FOREIGN KEY (usuario_modificacion)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.servicio ADD CONSTRAINT usuario_servicio_fk
FOREIGN KEY (usuario_alta)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE public.servicio ADD CONSTRAINT usuario_servicio_fk1
FOREIGN KEY (usuario_modificacion)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empresa ADD CONSTRAINT usuario_empresa_fk
FOREIGN KEY (usuario_modificacion)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.empresa ADD CONSTRAINT usuario_empresa_fk1
FOREIGN KEY (usuario_alta)
REFERENCES public.usuario (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.servicio ADD CONSTRAINT empresa_servicios_fk
FOREIGN KEY (empresa_id)
REFERENCES public.empresa (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.atencion ADD CONSTRAINT servicio_atencion_fk
FOREIGN KEY (servicio_id)
REFERENCES public.servicio (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.atencion ADD CONSTRAINT cliente_atencion_fk
FOREIGN KEY (cliente_id)
REFERENCES public.cliente (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;