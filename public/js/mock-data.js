// NEXO — mock-data.js
'use strict';

const NEXO = {

  currentUser: {
    id: 3, alias: 'lucas_isi', nombre: 'Lucas Martínez',
    inicial: 'L', carrera: 'Ingeniería en Sistemas', sede: 'UTN-BA',
    anio: '3° año', reputacion: 180, rol: 'usuario'
  },

  ciudades: ['Buenos Aires','Córdoba','Rosario','La Plata'],

  sedes: [
    { id:1, nombre:'UTN — FR Buenos Aires', ciudad:'Buenos Aires' },
    { id:2, nombre:'UTN — FR Córdoba',      ciudad:'Córdoba' },
    { id:3, nombre:'UTN — FR Rosario',      ciudad:'Rosario' },
    { id:4, nombre:'UNLP — Informática',    ciudad:'La Plata' },
  ],

  carreras: [
    { id:1, nombre:'Ingeniería en Sistemas', sede_id:1 },
    { id:2, nombre:'Ingeniería Electrónica', sede_id:1 },
    { id:3, nombre:'Ingeniería Industrial',  sede_id:2 },
    { id:4, nombre:'Licenciatura en Informática', sede_id:4 },
    { id:5, nombre:'Ingeniería Civil',       sede_id:3 },
  ],

  materias: [
    { id:1,  nombre:'Algoritmos y Estructuras de Datos', codigo:'AED' },
    { id:2,  nombre:'Análisis Matemático I',             codigo:'AM1' },
    { id:3,  nombre:'Análisis Matemático II',            codigo:'AM2' },
    { id:4,  nombre:'Bases de Datos',                    codigo:'BDD' },
    { id:5,  nombre:'Redes de Computadoras',             codigo:'RDC' },
    { id:6,  nombre:'Sistemas Operativos',               codigo:'SSO' },
    { id:7,  nombre:'Ingeniería de Software',            codigo:'IS1' },
    { id:8,  nombre:'Física I',                          codigo:'FIS1' },
    { id:9,  nombre:'Probabilidad y Estadística',        codigo:'PYE' },
    { id:10, nombre:'Paradigmas de Programación',        codigo:'PDP' },
    { id:11, nombre:'Arquitectura de Computadoras',      codigo:'ARQ' },
  ],

  comunidades: [
    { id:1, nombre:'Sistemas UTN-BA',    slug:'sistemas-utn-ba',    miembros:412, descripcion:'Comunidad para estudiantes de ISI en UTN Buenos Aires.', carrera_id:1 },
    { id:2, nombre:'Electrónica UTN-BA', slug:'electronica-utn-ba', miembros:198, descripcion:'Comunidad de Ingeniería Electrónica UTN-BA.', carrera_id:2 },
    { id:3, nombre:'Informática UNLP',   slug:'informatica-unlp',   miembros:287, descripcion:'Facultad de Informática de La Plata.', carrera_id:4 },
    { id:4, nombre:'General — Nexo',     slug:'general',            miembros:980, descripcion:'Espacio para todos los estudiantes universitarios.', carrera_id:null },
  ],

  posts: [
    {
      id:1, tipo:'apunte', titulo:'Resumen completo AED — Árbol AVL y Grafos',
      descripcion:'Subí el resumen de todo el bloque 3 de AED con los algoritmos de balanceo AVL y recorridos en grafos (BFS, DFS, Dijkstra). Incluye ejemplos resueltos.',
      autor:'maria_dev', autor_inicial:'M', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'AED', sede:'UTN-BA', votos:47, comentarios:6,
      tags:['parcial','apunte','resumen'], archivos:[{nombre:'resumen-aed-bloque3.pdf', tipo:'pdf'}],
      hace:'hace 3 horas', miVoto: 0, guardado: false,
    },
    {
      id:2, tipo:'apunte', titulo:'Guía de SQL avanzado — Triggers, Vistas y Stored Procedures',
      descripcion:'Compilé todos los temas de BDD que entran en el segundo parcial. Ejercicios de los últimos 3 años con soluciones comentadas.',
      autor:'sofia_db', autor_inicial:'S', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'BDD', sede:'UTN-BA', votos:38, comentarios:4,
      tags:['parcial','apunte','examen-viejo'], archivos:[{nombre:'sql-avanzado-guia.pdf', tipo:'pdf'},{nombre:'ejercicios-BDD.pdf',tipo:'pdf'}],
      hace:'hace 5 horas', miVoto: 0, guardado: true,
    },
    {
      id:3, tipo:'duda', titulo:'¿Cómo demuestro convergencia de series con criterio de Leibniz?',
      descripcion:'Tengo dudas con el criterio de Leibniz para series alternadas. Específicamente con el ejercicio 4c de la guía 8. ¿Alguien lo resolvió?',
      autor:'lucas_isi', autor_inicial:'L', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'AM1', sede:'UTN-BA', votos:12, comentarios:3,
      tags:['consulta'], archivos:[],
      hace:'hace 8 horas', miVoto: 0, guardado: false,
    },
    {
      id:4, tipo:'duda', titulo:'Diferencias entre TCP y UDP en capa de transporte',
      descripcion:'No me queda clara la diferencia práctica entre TCP y UDP. ¿Cuándo conviene cada uno? Lo vi en Redes pero me confundo.',
      autor:'tomas_redes', autor_inicial:'T', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'RDC', sede:'UTN-BA', votos:8, comentarios:2,
      tags:['consulta'], archivos:[],
      hace:'hace 10 horas', miVoto: 0, guardado: false,
    },
    {
      id:5, tipo:'apunte', titulo:'Apuntes Sistemas Operativos — Scheduling y Memoria',
      descripcion:'Resumen de los temas de SSO que más toman en finales: scheduling (FCFS, SJF, Round Robin) y paginación de memoria con ejemplos.',
      autor:'sofia_db', autor_inicial:'S', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'SSO', sede:'UTN-BA', votos:29, comentarios:5,
      tags:['final','apunte','resumen'], archivos:[{nombre:'SSO-scheduling-memoria.pdf',tipo:'pdf'}],
      hace:'hace 1 día', miVoto: 0, guardado: false,
    },
    {
      id:6, tipo:'informacion', titulo:'Fechas de parciales IS1 — Cátedra Fernández 2025',
      descripcion:'Confirmo: 1er parcial 15/10, 2do parcial 19/11. Recuperatorio el 3/12. La cátedra va a subir el enunciado modelo esta semana.',
      autor:'maria_dev', autor_inicial:'M', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'IS1', sede:'UTN-BA', votos:15, comentarios:7,
      tags:['parcial','tip'], archivos:[],
      hace:'hace 2 días', miVoto: 0, guardado: false,
    },
    {
      id:7, tipo:'grupo', titulo:'Grupo AED para el parcial del 20 de octubre',
      descripcion:'Buscamos 4 personas para repasar AED. Martes y jueves 17hs en el campus. Los que cursan con Medina son bienvenidos.',
      autor:'lucas_isi', autor_inicial:'L', comunidad:'Sistemas UTN-BA', comunidad_slug:'sistemas-utn-ba',
      materia:'AED', sede:'UTN-BA', votos:6, comentarios:3,
      tags:['grupo','parcial'], archivos:[],
      hace:'hace 3 días', miVoto: 0, guardado: false,
    },
    {
      id:8, tipo:'informacion', titulo:'Bienvenidos a Nexo — El foro universitario argentino',
      descripcion:'Nexo es el espacio colaborativo donde estudiantes de todas las universidades podemos compartir apuntes, resolver dudas y organizarnos para estudiar. ¡Empecemos!',
      autor:'admin_nexo', autor_inicial:'A', comunidad:'General — Nexo', comunidad_slug:'general',
      materia:null, sede:null, votos:91, comentarios:14,
      tags:['tip'], archivos:[],
      hace:'hace 5 días', miVoto: 0, guardado: false,
    },
  ],

  comentarios: {
    1: [
      { id:1, autor:'lucas_isi', inicial:'L', texto:'¡Gracias María! Justamente necesitaba el tema de Dijkstra. ¿Lo vas a actualizar con Bellman-Ford también?', hace:'hace 2 horas', votos:5, miVoto:0,
        respuestas:[
          { id:6, autor:'maria_dev', inicial:'M', texto:'Sí, voy a agregar Bellman-Ford la semana que viene cuando lo veamos en clase.', hace:'hace 1 hora', votos:3, miVoto:0, respuestas:[] }
        ]
      },
      { id:2, autor:'tomas_redes', inicial:'T', texto:'Excelente resumen. ¿Esto es para la cátedra de Pereyra o también sirve para Mitre?', hace:'hace 1 hora', votos:2, miVoto:0, respuestas:[] },
      { id:3, autor:'sofia_db', inicial:'S', texto:'Sirve para las dos cátedras, los temas son los mismos aunque el orden difiere un poco.', hace:'hace 45 min', votos:4, miVoto:0, respuestas:[] },
    ],
    3: [
      { id:4, autor:'maria_dev', inicial:'M', texto:'El criterio de Leibniz aplica cuando la serie es alternada, los términos son decrecientes y el límite del término general es 0. ¿Cuál es exactamente el 4c?', hace:'hace 6 horas', votos:8, miVoto:0, respuestas:[] },
      { id:5, autor:'sofia_db', inicial:'S', texto:'Para el 4c de la guía 8 hay que verificar las 3 condiciones. El límite de a_n = 1/n es 0 y {1/n} es estrictamente decreciente → converge.', hace:'hace 4 horas', votos:6, miVoto:0, respuestas:[] },
    ],
  },

  grupos: [
    {
      id:1, nombre:'AED — Parcial Octubre', materia:'Algoritmos y Estructuras de Datos',
      modalidad:'presencial', privacidad:'publico',
      cupo_maximo:6, cupo_actual:3,
      fecha:'2025-10-15', horario:'17:00 - 19:00',
      sede:'UTN-BA', zona:'Almagro',
      descripcion:'Repaso intensivo de AED enfocado en el parcial. Traigan ejercicios de la guía.',
      creador:'maria_dev', estado:'activo', miembro: true,
    },
    {
      id:2, nombre:'Bases de Datos — Final', materia:'Bases de Datos',
      modalidad:'virtual', privacidad:'aprobacion',
      cupo_maximo:5, cupo_actual:2,
      fecha:'2025-11-01', horario:'20:00 - 22:00',
      sede:'Remoto', zona:null,
      descripcion:'Preparación para el final de BDD. Normalización, triggers y vistas.',
      creador:'sofia_db', estado:'activo', miembro: false,
    },
    {
      id:3, nombre:'Redes — Comisión Medina', materia:'Redes de Computadoras',
      modalidad:'mixto', privacidad:'publico',
      cupo_maximo:8, cupo_actual:4,
      fecha:'2025-10-20', horario:'18:00 - 20:00',
      sede:'UTN-BA', zona:'Palermo',
      descripcion:'Grupo de estudio de Redes para la comisión de Medina. Resolución de guías.',
      creador:'lucas_isi', estado:'activo', miembro: true,
    },
    {
      id:4, nombre:'Probabilidad — Recuperatorio', materia:'Probabilidad y Estadística',
      modalidad:'virtual', privacidad:'publico',
      cupo_maximo:4, cupo_actual:4,
      fecha:'2025-10-25', horario:'19:00 - 21:00',
      sede:'Remoto', zona:null,
      descripcion:'Grupo para el recuperatorio de PYE. Cupo completo.',
      creador:'tomas_redes', estado:'completo', miembro: false,
    },
  ],

  mensajes: [
    { id:1, grupo_id:1, autor:'maria_dev', inicial:'M', texto:'Hola! Confirmo que nos juntamos el martes 17hs en el SUM del campus.', hora:'16:45', propio:false },
    { id:2, grupo_id:1, autor:'lucas_isi', inicial:'L', texto:'Perfecto, llevo los ejercicios de la guía 3 impresos.', hora:'16:47', propio:true },
    { id:3, grupo_id:1, autor:'tomas_redes', inicial:'T', texto:'¿Alguien tiene el apunte de AVL? No lo encuentro en el campus virtual.', hora:'16:50', propio:false },
    { id:4, grupo_id:1, autor:'maria_dev', inicial:'M', texto:'Sí, lo subí al foro, buscá el post "Resumen AED".', hora:'16:51', propio:false },
    { id:5, grupo_id:1, autor:'lucas_isi', inicial:'L', texto:'¿Arrancamos con grafos o primero AED básico?', hora:'16:55', propio:true },
  ],

  notificaciones: [
    { id:1, tipo:'comentario', icono:'💬', mensaje:'<strong>maria_dev</strong> respondió tu comentario en "Resumen AED".', hace:'hace 1 hora', leida:false, url:'post.html?id=1' },
    { id:2, tipo:'grupo',      icono:'👥', mensaje:'Tu solicitud al grupo <strong>AED — Parcial Octubre</strong> fue aceptada.', hace:'hace 2 horas', leida:false, url:'grupos.html' },
    { id:3, tipo:'comentario', icono:'💬', mensaje:'<strong>sofia_db</strong> comentó tu publicación "Criterio de Leibniz".', hace:'hace 5 horas', leida:false, url:'post.html?id=3' },
    { id:4, tipo:'voto',       icono:'⬆️', mensaje:'Tu publicación "Grupo AED" recibió 5 nuevos votos.', hace:'hace 8 horas', leida:true, url:'post.html?id=7' },
    { id:5, tipo:'grupo',      icono:'🔔', mensaje:'<strong>tomas_redes</strong> solicitó unirse a tu grupo de estudio.', hace:'hace 1 día', leida:true, url:'grupos.html' },
    { id:6, tipo:'sistema',    icono:'✅', mensaje:'Tu email fue verificado correctamente. ¡Bienvenido a Nexo!', hace:'hace 3 días', leida:true, url:null },
  ],

  reportes: [
    { id:1, tipo:'publicacion', contenido_id:3, motivo:'Contenido inapropiado', descripcion:'El título es engañoso.', reportado_por:'tomas_redes', estado:'pendiente', hace:'hace 30 min' },
    { id:2, tipo:'comentario',  contenido_id:2, motivo:'Spam', descripcion:'Publicita servicios externos.', reportado_por:'sofia_db', estado:'en_revision', hace:'hace 2 horas' },
    { id:3, tipo:'usuario',     contenido_id:5, motivo:'Comportamiento agresivo', descripcion:'', reportado_por:'maria_dev', estado:'resuelto', hace:'hace 1 día' },
    { id:4, tipo:'publicacion', contenido_id:7, motivo:'Fuera de tema', descripcion:'No es académico.', reportado_por:'lucas_isi', estado:'desestimado', hace:'hace 2 días' },
  ],

};
