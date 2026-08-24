-- ============================================================
-- NEXO — Foro Universitario
-- Schema MySQL v1.0
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- ------------------------------------------------------------
-- CATÁLOGO ACADÉMICO
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ciudades (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre     VARCHAR(100) NOT NULL,
  provincia  VARCHAR(100),
  pais       VARCHAR(80) NOT NULL DEFAULT 'Argentina',
  creado_en  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sedes (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre     VARCHAR(150) NOT NULL,
  ciudad_id  INT UNSIGNED NOT NULL,
  direccion  VARCHAR(255),
  creado_en  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_sede_ciudad FOREIGN KEY (ciudad_id) REFERENCES ciudades(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS zonas (
  id        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(100) NOT NULL,
  sede_id   INT UNSIGNED,
  CONSTRAINT fk_zona_sede FOREIGN KEY (sede_id) REFERENCES sedes(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS carreras (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(200) NOT NULL,
  descripcion TEXT,
  sede_id     INT UNSIGNED,
  creado_en   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_carrera_sede FOREIGN KEY (sede_id) REFERENCES sedes(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS materias (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(200) NOT NULL,
  codigo      VARCHAR(20),
  descripcion TEXT,
  creado_en   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS carreras_materias (
  carrera_id INT UNSIGNED NOT NULL,
  materia_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (carrera_id, materia_id),
  CONSTRAINT fk_cm_carrera FOREIGN KEY (carrera_id) REFERENCES carreras(id) ON DELETE CASCADE,
  CONSTRAINT fk_cm_materia FOREIGN KEY (materia_id) REFERENCES materias(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- USUARIOS Y AUTENTICACIÓN
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS roles (
  id     TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL UNIQUE
  -- valores esperados: visitante, usuario, moderador, administrador
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios (
  id               INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  alias            VARCHAR(50) NOT NULL,
  email            VARCHAR(254) NOT NULL,
  password_hash    VARCHAR(255) NOT NULL,
  email_verificado TINYINT(1) NOT NULL DEFAULT 0,
  activo           TINYINT(1) NOT NULL DEFAULT 1,
  suspendido_hasta DATETIME,
  intentos_fallidos TINYINT UNSIGNED NOT NULL DEFAULT 0,
  bloqueado_hasta  DATETIME,
  reputacion       INT NOT NULL DEFAULT 0,
  creado_en        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ultimo_acceso    DATETIME,
  CONSTRAINT uq_usuarios_alias UNIQUE (alias),
  CONSTRAINT uq_usuarios_email UNIQUE (email),
  INDEX idx_usuarios_alias (alias),
  INDEX idx_usuarios_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios_roles (
  usuario_id INT UNSIGNED NOT NULL,
  rol_id     TINYINT UNSIGNED NOT NULL,
  asignado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, rol_id),
  CONSTRAINT fk_ur_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_ur_rol     FOREIGN KEY (rol_id)     REFERENCES roles(id)    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS perfiles (
  usuario_id      INT UNSIGNED PRIMARY KEY,
  nombre_completo VARCHAR(120),
  avatar_url      VARCHAR(500),
  descripcion     TEXT,
  carrera_id      INT UNSIGNED,
  sede_id         INT UNSIGNED,
  ciudad_id       INT UNSIGNED,
  zona_id         INT UNSIGNED,
  anio_semestre   VARCHAR(20),
  -- visibilidad: 'publico' | 'privado'
  visibilidad_perfil ENUM('publico','privado') NOT NULL DEFAULT 'publico',
  mostrar_carrera    TINYINT(1) NOT NULL DEFAULT 1,
  mostrar_sede       TINYINT(1) NOT NULL DEFAULT 1,
  mostrar_zona       TINYINT(1) NOT NULL DEFAULT 1,
  disponibilidad     VARCHAR(200),
  actualizado_en     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_perfil_usuario  FOREIGN KEY (usuario_id) REFERENCES usuarios(id)  ON DELETE CASCADE,
  CONSTRAINT fk_perfil_carrera  FOREIGN KEY (carrera_id) REFERENCES carreras(id)  ON DELETE SET NULL,
  CONSTRAINT fk_perfil_sede     FOREIGN KEY (sede_id)    REFERENCES sedes(id)     ON DELETE SET NULL,
  CONSTRAINT fk_perfil_ciudad   FOREIGN KEY (ciudad_id)  REFERENCES ciudades(id)  ON DELETE SET NULL,
  CONSTRAINT fk_perfil_zona     FOREIGN KEY (zona_id)    REFERENCES zonas(id)     ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS perfiles_materias (
  usuario_id INT UNSIGNED NOT NULL,
  materia_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (usuario_id, materia_id),
  CONSTRAINT fk_pm_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_pm_materia FOREIGN KEY (materia_id) REFERENCES materias(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS verificaciones_email (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  usuario_id  INT UNSIGNED NOT NULL,
  token       VARCHAR(128) NOT NULL UNIQUE,
  expira_en   DATETIME NOT NULL,
  usado       TINYINT(1) NOT NULL DEFAULT 0,
  creado_en   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_ve_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  INDEX idx_ve_token (token)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS recuperaciones_password (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT UNSIGNED NOT NULL,
  token      VARCHAR(128) NOT NULL UNIQUE,
  expira_en  DATETIME NOT NULL,
  usado      TINYINT(1) NOT NULL DEFAULT 0,
  creado_en  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rp_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  INDEX idx_rp_token (token)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- COMUNIDADES
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS comunidades (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  slug        VARCHAR(110) NOT NULL UNIQUE,
  descripcion TEXT,
  reglas      TEXT,
  carrera_id  INT UNSIGNED,
  banner_url  VARCHAR(500),
  icono_url   VARCHAR(500),
  creado_en   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_com_carrera FOREIGN KEY (carrera_id) REFERENCES carreras(id) ON DELETE SET NULL,
  INDEX idx_com_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS miembros_comunidad (
  usuario_id   INT UNSIGNED NOT NULL,
  comunidad_id INT UNSIGNED NOT NULL,
  rol          ENUM('miembro','moderador') NOT NULL DEFAULT 'miembro',
  unido_en     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, comunidad_id),
  CONSTRAINT fk_mc_usuario   FOREIGN KEY (usuario_id)   REFERENCES usuarios(id)    ON DELETE CASCADE,
  CONSTRAINT fk_mc_comunidad FOREIGN KEY (comunidad_id) REFERENCES comunidades(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- PUBLICACIONES
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS etiquetas (
  id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  INDEX idx_etiqueta_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS publicaciones (
  id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  autor_id     INT UNSIGNED NOT NULL,
  comunidad_id INT UNSIGNED NOT NULL,
  materia_id   INT UNSIGNED,
  sede_id      INT UNSIGNED,
  tipo         ENUM('apunte','duda','informacion','grupo_estudio') NOT NULL,
  titulo       VARCHAR(300) NOT NULL,
  descripcion  TEXT NOT NULL,
  votos        INT NOT NULL DEFAULT 0,
  oculta       TINYINT(1) NOT NULL DEFAULT 0,
  eliminada    TINYINT(1) NOT NULL DEFAULT 0,
  creado_en    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_pub_autor     FOREIGN KEY (autor_id)     REFERENCES usuarios(id)    ON DELETE RESTRICT,
  CONSTRAINT fk_pub_comunidad FOREIGN KEY (comunidad_id) REFERENCES comunidades(id) ON DELETE RESTRICT,
  CONSTRAINT fk_pub_materia   FOREIGN KEY (materia_id)   REFERENCES materias(id)    ON DELETE SET NULL,
  CONSTRAINT fk_pub_sede      FOREIGN KEY (sede_id)      REFERENCES sedes(id)       ON DELETE SET NULL,
  INDEX idx_pub_comunidad (comunidad_id),
  INDEX idx_pub_autor (autor_id),
  INDEX idx_pub_tipo (tipo),
  INDEX idx_pub_creado (creado_en),
  FULLTEXT INDEX ft_pub_busqueda (titulo, descripcion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS publicaciones_etiquetas (
  publicacion_id INT UNSIGNED NOT NULL,
  etiqueta_id    INT UNSIGNED NOT NULL,
  PRIMARY KEY (publicacion_id, etiqueta_id),
  CONSTRAINT fk_pe_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id) ON DELETE CASCADE,
  CONSTRAINT fk_pe_etiqueta    FOREIGN KEY (etiqueta_id)    REFERENCES etiquetas(id)     ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS archivos (
  id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  publicacion_id INT UNSIGNED NOT NULL,
  subido_por     INT UNSIGNED NOT NULL,
  nombre_original VARCHAR(255) NOT NULL,
  nombre_seguro  VARCHAR(255) NOT NULL,
  ruta           VARCHAR(500) NOT NULL,
  tipo_mime      ENUM('application/pdf','image/jpeg','image/png','image/webp') NOT NULL,
  tamanio_bytes  INT UNSIGNED NOT NULL,
  creado_en      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_arch_pub    FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id) ON DELETE CASCADE,
  CONSTRAINT fk_arch_subido FOREIGN KEY (subido_por)     REFERENCES usuarios(id)      ON DELETE RESTRICT,
  INDEX idx_arch_pub (publicacion_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS votos_publicacion (
  usuario_id     INT UNSIGNED NOT NULL,
  publicacion_id INT UNSIGNED NOT NULL,
  valor          TINYINT NOT NULL CHECK (valor IN (-1, 1)),
  votado_en      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, publicacion_id),
  CONSTRAINT fk_vp_usuario     FOREIGN KEY (usuario_id)     REFERENCES usuarios(id)     ON DELETE CASCADE,
  CONSTRAINT fk_vp_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS publicaciones_guardadas (
  usuario_id     INT UNSIGNED NOT NULL,
  publicacion_id INT UNSIGNED NOT NULL,
  guardado_en    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, publicacion_id),
  CONSTRAINT fk_pg_usuario     FOREIGN KEY (usuario_id)     REFERENCES usuarios(id)      ON DELETE CASCADE,
  CONSTRAINT fk_pg_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- COMENTARIOS
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS comentarios (
  id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  publicacion_id INT UNSIGNED NOT NULL,
  autor_id       INT UNSIGNED NOT NULL,
  padre_id       INT UNSIGNED,               -- respuesta a otro comentario
  contenido      TEXT NOT NULL,
  votos          INT NOT NULL DEFAULT 0,
  oculto         TINYINT(1) NOT NULL DEFAULT 0,
  eliminado      TINYINT(1) NOT NULL DEFAULT 0,
  creado_en      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_com_pub    FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id) ON DELETE CASCADE,
  CONSTRAINT fk_com_autor  FOREIGN KEY (autor_id)       REFERENCES usuarios(id)      ON DELETE RESTRICT,
  CONSTRAINT fk_com_padre  FOREIGN KEY (padre_id)       REFERENCES comentarios(id)   ON DELETE SET NULL,
  INDEX idx_com_pub (publicacion_id),
  INDEX idx_com_padre (padre_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS votos_comentario (
  usuario_id    INT UNSIGNED NOT NULL,
  comentario_id INT UNSIGNED NOT NULL,
  valor         TINYINT NOT NULL CHECK (valor IN (-1, 1)),
  votado_en     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, comentario_id),
  CONSTRAINT fk_vc_usuario    FOREIGN KEY (usuario_id)    REFERENCES usuarios(id)    ON DELETE CASCADE,
  CONSTRAINT fk_vc_comentario FOREIGN KEY (comentario_id) REFERENCES comentarios(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- GRUPOS DE ESTUDIO
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS grupos_estudio (
  id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  creador_id   INT UNSIGNED NOT NULL,
  materia_id   INT UNSIGNED NOT NULL,
  sede_id      INT UNSIGNED,
  zona_id      INT UNSIGNED,
  nombre       VARCHAR(200) NOT NULL,
  descripcion  TEXT,
  modalidad    ENUM('presencial','virtual','mixto') NOT NULL,
  privacidad   ENUM('publico','aprobacion') NOT NULL DEFAULT 'publico',
  cupo_maximo  TINYINT UNSIGNED NOT NULL DEFAULT 10,
  cupo_actual  TINYINT UNSIGNED NOT NULL DEFAULT 1,
  fecha        DATE,
  horario_inicio TIME,
  horario_fin    TIME,
  estado       ENUM('activo','completo','cerrado') NOT NULL DEFAULT 'activo',
  publicacion_id INT UNSIGNED,
  creado_en    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_ge_creador     FOREIGN KEY (creador_id)     REFERENCES usuarios(id)      ON DELETE RESTRICT,
  CONSTRAINT fk_ge_materia     FOREIGN KEY (materia_id)     REFERENCES materias(id)      ON DELETE RESTRICT,
  CONSTRAINT fk_ge_sede        FOREIGN KEY (sede_id)        REFERENCES sedes(id)         ON DELETE SET NULL,
  CONSTRAINT fk_ge_zona        FOREIGN KEY (zona_id)        REFERENCES zonas(id)         ON DELETE SET NULL,
  CONSTRAINT fk_ge_publicacion FOREIGN KEY (publicacion_id) REFERENCES publicaciones(id) ON DELETE SET NULL,
  INDEX idx_ge_materia (materia_id),
  INDEX idx_ge_estado  (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS solicitudes_grupo (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  grupo_id   INT UNSIGNED NOT NULL,
  usuario_id INT UNSIGNED NOT NULL,
  estado     ENUM('pendiente','aceptada','rechazada','cancelada') NOT NULL DEFAULT 'pendiente',
  mensaje    TEXT,
  creado_en  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resuelto_en DATETIME,
  CONSTRAINT fk_sg_grupo   FOREIGN KEY (grupo_id)   REFERENCES grupos_estudio(id) ON DELETE CASCADE,
  CONSTRAINT fk_sg_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)       ON DELETE CASCADE,
  UNIQUE INDEX uq_sg_activa (grupo_id, usuario_id, estado),
  INDEX idx_sg_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS miembros_grupo (
  usuario_id INT UNSIGNED NOT NULL,
  grupo_id   INT UNSIGNED NOT NULL,
  rol        ENUM('miembro','administrador') NOT NULL DEFAULT 'miembro',
  unido_en   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (usuario_id, grupo_id),
  CONSTRAINT fk_mg_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)       ON DELETE CASCADE,
  CONSTRAINT fk_mg_grupo   FOREIGN KEY (grupo_id)   REFERENCES grupos_estudio(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- CHAT GRUPAL
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS mensajes_grupo (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  grupo_id   INT UNSIGNED NOT NULL,
  autor_id   INT UNSIGNED NOT NULL,
  contenido  TEXT NOT NULL,
  eliminado  TINYINT(1) NOT NULL DEFAULT 0,
  enviado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_msg_grupo FOREIGN KEY (grupo_id) REFERENCES grupos_estudio(id) ON DELETE CASCADE,
  CONSTRAINT fk_msg_autor FOREIGN KEY (autor_id) REFERENCES usuarios(id)       ON DELETE RESTRICT,
  INDEX idx_msg_grupo_tiempo (grupo_id, enviado_en)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- NOTIFICACIONES
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS notificaciones (
  id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  usuario_id   INT UNSIGNED NOT NULL,
  tipo         VARCHAR(50) NOT NULL,
  -- Ej: comentario_en_post, respuesta_comentario, solicitud_grupo,
  --     aceptado_grupo, rechazado_grupo, sancion, moderacion
  referencia_tipo VARCHAR(30),
  referencia_id   INT UNSIGNED,
  mensaje      VARCHAR(500) NOT NULL,
  leida        TINYINT(1) NOT NULL DEFAULT 0,
  creado_en    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_noti_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
  INDEX idx_noti_usuario_leida (usuario_id, leida),
  INDEX idx_noti_creado (creado_en)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS preferencias_notificacion (
  usuario_id              INT UNSIGNED PRIMARY KEY,
  email_comentarios       TINYINT(1) NOT NULL DEFAULT 1,
  email_grupos            TINYINT(1) NOT NULL DEFAULT 1,
  email_moderacion        TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_pn_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- MODERACIÓN Y SANCIONES
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS reportes (
  id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  reportado_por   INT UNSIGNED NOT NULL,
  tipo_contenido  ENUM('publicacion','comentario','mensaje','usuario') NOT NULL,
  contenido_id    INT UNSIGNED NOT NULL,
  motivo          VARCHAR(100) NOT NULL,
  descripcion     TEXT,
  estado          ENUM('pendiente','en_revision','desestimado','resuelto') NOT NULL DEFAULT 'pendiente',
  resuelto_por    INT UNSIGNED,
  creado_en       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resuelto_en     DATETIME,
  CONSTRAINT fk_rep_reportado FOREIGN KEY (reportado_por) REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_rep_resuelto  FOREIGN KEY (resuelto_por)  REFERENCES usuarios(id) ON DELETE SET NULL,
  INDEX idx_rep_estado (estado),
  INDEX idx_rep_tipo (tipo_contenido, contenido_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS sanciones (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  usuario_id  INT UNSIGNED NOT NULL,
  tipo        ENUM('advertencia','suspension','bloqueo') NOT NULL,
  motivo      TEXT NOT NULL,
  duracion_horas INT UNSIGNED,           -- NULL = permanente
  inicio_en   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fin_en      DATETIME,
  aplicado_por INT UNSIGNED NOT NULL,
  activa      TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_san_usuario   FOREIGN KEY (usuario_id)   REFERENCES usuarios(id) ON DELETE CASCADE,
  CONSTRAINT fk_san_aplicador FOREIGN KEY (aplicado_por) REFERENCES usuarios(id) ON DELETE RESTRICT,
  INDEX idx_san_usuario (usuario_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS acciones_moderacion (
  id            INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  moderador_id  INT UNSIGNED NOT NULL,
  accion        VARCHAR(100) NOT NULL,
  -- Ej: ocultar_publicacion, eliminar_comentario, resolver_reporte,
  --     suspender_usuario, asignar_moderador
  referencia_tipo VARCHAR(40),
  referencia_id   INT UNSIGNED,
  detalle       TEXT,
  realizado_en  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_am_moderador FOREIGN KEY (moderador_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
  INDEX idx_am_moderador (moderador_id),
  INDEX idx_am_realizado  (realizado_en)
  -- Las acciones de moderación NO pueden eliminarse (sin DELETE CASCADE ni panel de borrado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
