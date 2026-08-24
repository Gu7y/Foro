-- ============================================================
-- NEXO — Datos de demostración (seed.sql)
-- Ejecutar DESPUÉS de schema.sql
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Ciudades
INSERT INTO ciudades (nombre, provincia) VALUES
  ('Buenos Aires', 'Buenos Aires'),
  ('Córdoba', 'Córdoba'),
  ('Rosario', 'Santa Fe'),
  ('La Plata', 'Buenos Aires');

-- Sedes
INSERT INTO sedes (nombre, ciudad_id, direccion) VALUES
  ('UTN — Facultad Regional Buenos Aires', 1, 'Medrano 951, CABA'),
  ('UTN — Facultad Regional Córdoba', 2, 'Maestro M. López esq. Cruz Roja'),
  ('UTN — Facultad Regional Rosario', 3, 'Zeballos 1341'),
  ('UNLP — Facultad de Informática', 4, '50 y 120, La Plata');

-- Zonas
INSERT INTO zonas (nombre, sede_id) VALUES
  ('Palermo', 1), ('Almagro', 1), ('Caballito', 1),
  ('Nueva Córdoba', 2), ('Centro', 3), ('City Bell', 4);

-- Carreras
INSERT INTO carreras (nombre, sede_id) VALUES
  ('Ingeniería en Sistemas de Información', 1),
  ('Ingeniería Electrónica', 1),
  ('Ingeniería Industrial', 2),
  ('Licenciatura en Informática', 4),
  ('Ingeniería Civil', 3);

-- Materias
INSERT INTO materias (nombre, codigo) VALUES
  ('Algoritmos y Estructuras de Datos', 'AED'),
  ('Análisis Matemático I', 'AM1'),
  ('Análisis Matemático II', 'AM2'),
  ('Bases de Datos', 'BDD'),
  ('Redes de Computadoras', 'RDC'),
  ('Sistemas Operativos', 'SSO'),
  ('Ingeniería de Software', 'IS1'),
  ('Física I', 'FIS1'),
  ('Física II', 'FIS2'),
  ('Probabilidad y Estadística', 'PYE'),
  ('Paradigmas de Programación', 'PDP'),
  ('Arquitectura de Computadoras', 'ARQ');

-- Asociar materias con carreras
INSERT INTO carreras_materias (carrera_id, materia_id) VALUES
  (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),
  (2,2),(2,3),(2,8),(2,9),(2,12),
  (4,1),(4,4),(4,5),(4,6),(4,7),(4,10),(4,11);

-- Roles
INSERT INTO roles (nombre) VALUES ('visitante'),('usuario'),('moderador'),('administrador');

-- Usuarios (contraseñas hasheadas con bcrypt para "nexo1234")
INSERT INTO usuarios (alias, email, password_hash, email_verificado, reputacion) VALUES
  ('admin_nexo',   'admin@nexo.edu.ar',      '$2y$12$demoHashAdminxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1, 500),
  ('maria_dev',    'maria@correo.com',        '$2y$12$demoHashMariaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1, 245),
  ('lucas_isi',    'lucas@correo.com',        '$2y$12$demoHashLucasxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1, 180),
  ('sofia_db',     'sofia@correo.com',        '$2y$12$demoHashSofiaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1, 310),
  ('tomas_redes',  'tomas@correo.com',        '$2y$12$demoHashTomasxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1, 95),
  ('mod_sistemas', 'modsistemas@nexo.edu.ar', '$2y$12$demoHashModSisxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', 1, 400);

-- Roles de usuarios
INSERT INTO usuarios_roles (usuario_id, rol_id) VALUES
  (1,4),(2,2),(3,2),(4,2),(5,2),(6,3);

-- Perfiles
INSERT INTO perfiles (usuario_id, nombre_completo, descripcion, carrera_id, sede_id, ciudad_id, zona_id, anio_semestre) VALUES
  (1, 'Administrador Nexo', 'Administrador de la plataforma Nexo.', NULL, NULL, 1, NULL, NULL),
  (2, 'María González', 'ISI 4° año. Me gustan los algoritmos y las bases de datos.', 1, 1, 1, 1, '4° año'),
  (3, 'Lucas Martínez', 'ISI 3° año. Apasionado por el desarrollo web.', 1, 1, 1, 2, '3° año'),
  (4, 'Sofía Ramírez', 'ISI 5° año. Especialista en BDD y sistemas.', 1, 1, 1, 3, '5° año'),
  (5, 'Tomás Herrera', 'ISI 2° año. Aprendiendo redes y sistemas operativos.', 1, 1, 1, 1, '2° año'),
  (6, 'Moderador Sistemas', 'Moderador de la comunidad Sistemas.', 1, 1, 1, NULL, NULL);

-- Comunidades
INSERT INTO comunidades (nombre, slug, descripcion, reglas, carrera_id) VALUES
  ('Ingeniería en Sistemas UTN-BA',    'sistemas-utn-ba',    'Comunidad para estudiantes de ISI en UTN Buenos Aires.', '1. Respeto mutuo.\n2. No spam.\n3. Contenido relacionado con la carrera.', 1),
  ('Ingeniería Electrónica UTN-BA',    'electronica-utn-ba', 'Comunidad para estudiantes de Electrónica UTN-BA.', '1. Respeto.\n2. Contenido académico relevante.', 2),
  ('Informática UNLP',                 'informatica-unlp',   'Comunidad de la Facultad de Informática de La Plata.', '1. Respeto.\n2. Sin spam.', 4),
  ('General — Nexo',                   'general',            'Espacio para todos los estudiantes universitarios.', '1. Respeto mutuo.\n2. Solo temas estudiantiles.', NULL);

-- Miembros de comunidades
INSERT INTO miembros_comunidad (usuario_id, comunidad_id, rol) VALUES
  (2,1,'miembro'),(3,1,'miembro'),(4,1,'miembro'),(5,1,'miembro'),
  (6,1,'moderador'),(2,4,'miembro'),(3,4,'miembro'),(4,4,'miembro');

-- Etiquetas
INSERT INTO etiquetas (nombre) VALUES
  ('parcial'),('final'),('apunte'),('consulta'),('resumen'),
  ('ejercicios'),('examen-viejo'),('grupo'),('proyecto'),('tip');

-- Publicaciones
INSERT INTO publicaciones (autor_id, comunidad_id, materia_id, tipo, titulo, descripcion, votos) VALUES
  (2, 1, 1, 'apunte',   'Resumen completo AED — Árbol AVL y Grafos',          'Subí el resumen de todo el bloque 3 de AED con los algoritmos de balanceo AVL y recorridos en grafos (BFS, DFS, Dijkstra). Incluye ejemplos resueltos paso a paso.', 47),
  (4, 1, 4, 'apunte',   'Guía de SQL avanzado — Triggers, Vistas y Stored Procedures', 'Compilé todos los temas de BDD que entran en el segundo parcial. Incluye ejercicios de los últimos 3 años con soluciones comentadas.', 38),
  (3, 1, 2, 'duda',     '¿Cómo demuestro convergencia de series con criterio de Leibniz?', 'Tengo dudas con el criterio de Leibniz para series alternadas. Específicamente con el ejercicio 4c de la guía 8. ¿Alguien lo resolvió?', 12),
  (5, 1, 5, 'duda',     'Diferencias entre TCP y UDP en capa de transporte',  'No me queda clara la diferencia práctica entre TCP y UDP. ¿Cuándo conviene cada uno? Lo vi en Redes pero me confundo.', 8),
  (4, 1, 6, 'apunte',   'Apuntes Sistemas Operativos — Scheduling y Memoria', 'Resumen de los temas de SSO que más toman en los finales: scheduling (FCFS, SJF, Round Robin) y paginación de memoria.', 29),
  (2, 1, 7, 'informacion','Fechas de parciales IS1 — Cátedra Fernández 2025', 'Confirmo fechas: 1er parcial 15/10, 2do parcial 19/11. El recuperatorio es el 3/12. Cátedra Fernández mañana va a subir el enunciado modelo.', 15),
  (3, 1, 1, 'grupo_estudio','Grupo AED para el parcial del 20 de octubre',   'Buscamos 4 personas más para repasar AED antes del parcial. Nos juntamos martes y jueves 17hs en el campus. Los que cursan con Medina son bienvenidos.', 6),
  (2, 4, NULL,'informacion','Bienvenidos a Nexo — El foro universitario argentino', 'Nexo es el espacio colaborativo donde estudiantes de todas las universidades podemos compartir apuntes, resolver dudas y organizarnos para estudiar juntos. ¡Empecemos!', 91);

-- Etiquetas de publicaciones
INSERT INTO publicaciones_etiquetas (publicacion_id, etiqueta_id) VALUES
  (1,3),(1,5),(1,6),(2,3),(2,5),(2,7),(3,4),(4,4),(5,3),(5,5),(6,1),(6,10),(7,8),(8,10);

-- Grupos de estudio
INSERT INTO grupos_estudio (creador_id, materia_id, sede_id, zona_id, nombre, descripcion, modalidad, privacidad, cupo_maximo, cupo_actual, fecha, horario_inicio, horario_fin) VALUES
  (2, 1, 1, 1, 'AED — Parcial Octubre',    'Repaso intensivo de AED enfocado en el parcial. Traigan ejercicios de la guía.', 'presencial', 'publico',   6, 3, '2025-10-15', '17:00', '19:00'),
  (4, 4, 1, 3, 'Bases de Datos — Final',   'Preparación para el final de BDD. Practicamos normalización, triggers y vistas.', 'virtual',    'aprobacion',5, 2, '2025-11-01', '20:00', '22:00'),
  (3, 5, 1, 2, 'Redes — Comisión Medina',  'Grupo de estudio de Redes para la comisión de Medina. Resolución de guías y simulacros.', 'mixto',  'publico',   8, 4, '2025-10-20', '18:00', '20:00');

-- Miembros de grupos
INSERT INTO miembros_grupo (usuario_id, grupo_id, rol) VALUES
  (2,1,'administrador'),(3,1,'miembro'),(5,1,'miembro'),
  (4,2,'administrador'),(2,2,'miembro'),
  (3,3,'administrador'),(4,3,'miembro'),(5,3,'miembro'),(2,3,'miembro');

-- Comentarios
INSERT INTO comentarios (publicacion_id, autor_id, contenido) VALUES
  (1, 3, '¡Gracias María! Justamente necesitaba el tema de Dijkstra. ¿Lo vas a actualizar con Bellman-Ford también?'),
  (1, 5, 'Excelente resumen. ¿Esto es para la cátedra de Pereyra o también sirve para Mitre?'),
  (1, 4, 'Sirve para las dos cátedras, los temas son los mismos aunque el orden difiere un poco.'),
  (3, 2, 'El criterio de Leibniz aplica cuando la serie es alternada, los términos son decrecientes y el límite del término general es 0. ¿Cuál es exactamente el ejercicio 4c?'),
  (3, 4, 'Para el 4c de la guía 8 hay que verificar las 3 condiciones del criterio. El límite de a_n = 1/n es 0, y {1/n} es estrictamente decreciente. Converge.');

-- Respuesta a un comentario
INSERT INTO comentarios (publicacion_id, autor_id, padre_id, contenido) VALUES
  (1, 2, 1, 'Sí, voy a agregar Bellman-Ford la semana que viene cuando lo veamos en clase.');

-- Votos de publicaciones (usuario_id, publicacion_id, valor)
INSERT INTO votos_publicacion (usuario_id, publicacion_id, valor) VALUES
  (3,1,1),(4,1,1),(5,1,1),(2,2,1),(3,2,1),(5,2,1),(2,3,1),(4,4,1),(3,5,1),(2,6,1),(5,7,1),(3,8,1),(4,8,1),(5,8,1);

-- Mensajes de chat (grupo 1)
INSERT INTO mensajes_grupo (grupo_id, autor_id, contenido) VALUES
  (1, 2, 'Hola! Confirmo que nos juntamos el martes 17hs en el SUM del campus.'),
  (1, 3, 'Perfecto, llevo los ejercicios de la guía 3 impresos.'),
  (1, 5, '¿Alguien tiene el apunte de AVL? No lo encuentro en el campus virtual.'),
  (1, 2, 'Sí, lo subí al foro, buscá el post de "Resumen AED".'),
  (1, 3, 'Arrancaríamos con el bloque de grafos o primero AED básico?');

-- Notificaciones
INSERT INTO notificaciones (usuario_id, tipo, referencia_tipo, referencia_id, mensaje) VALUES
  (2, 'comentario_en_post', 'publicacion', 1, 'lucas_isi comentó tu publicación "Resumen completo AED".'),
  (2, 'comentario_en_post', 'publicacion', 1, 'tomas_redes comentó tu publicación "Resumen completo AED".'),
  (3, 'respuesta_comentario','comentario', 1, 'maria_dev respondió tu comentario.'),
  (2, 'solicitud_grupo',     'grupo', 1, 'tomas_redes solicitó unirse a tu grupo AED — Parcial Octubre.'),
  (4, 'aceptado_grupo',      'grupo', 2, 'Tu solicitud al grupo Bases de Datos — Final fue aceptada.');

-- Preferencias de notificación
INSERT INTO preferencias_notificacion (usuario_id, email_comentarios, email_grupos) VALUES
  (2,1,1),(3,1,0),(4,1,1),(5,0,1);

SET FOREIGN_KEY_CHECKS = 1;
