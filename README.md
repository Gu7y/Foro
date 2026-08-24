# Foro Universitario 🎓

Plataforma web tipo foro/red social universitaria diseñada para conectar estudiantes, facilitar el intercambio de apuntes entre distintas sedes y facultades, y permitir la creación de grupos de estudio.

## 🚀 Características Principales

- **Feed Principal y Publicaciones**: Sistema de publicaciones por categoría/carrera, votos, comentarios e hilo de debate estilo Reddit.
- **Intercambio de Apuntes**: Sección dedicada a subir, buscar y descargar apuntes de estudio por materia y facultad.
- **Grupos de Estudio**: Conexión entre estudiantes para organizar sesiones de estudio grupales.
- **Chat y Notificaciones**: Mensajería interna y centro de notificaciones en tiempo real.
- **Autenticación y Perfiles**: Registro e inicio de sesión con roles de estudiante, moderador y administrador.
- **Paneles de Administración y Moderación**: Herramientas para la gestión de contenido, usuarios y reportes.

## 📁 Estructura del Proyecto

```text
foro/
├── database/            # Scripts de base de datos (schema.sql, seed.sql)
├── docs/                # Documentación del proyecto
├── public/              # Archivos públicos y vistas frontend
│   ├── css/             # Estilos CSS (main, components, responsive)
│   ├── js/              # Scripts frontend (app.js, mock-data.js)
│   ├── assets/          # Imágenes y recursos estáticos
│   └── *.html           # Páginas HTML (index, auth, post, apuntes, etc.)
└── src/                 # Arquitectura del servidor backend
    ├── config/          # Configuraciones del sistema
    ├── controllers/     # Controladores de lógica de negocio
    ├── core/            # Núcleo del framework/aplicación
    ├── helpers/         # Funciones auxiliares y utilidades
    ├── models/          # Modelos de datos
    └── views/           # Vistas dinamizadas
```

## 🛠️ Tecnologías Utilizadas

- **Frontend**: HTML5, CSS3 (Vanilla CSS con diseño responsive y moderno), JavaScript (ES6+).
- **Base de Datos**: MySQL / PostgreSQL (Scripts SQL incluidos en `/database`).
- **Control de Versiones**: Git & GitHub.

## ⚙️ Instalación y Uso Local

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/Gu7y/Foro.git
   cd Foro
   ```

2. Abrir la aplicación:
   - Puedes abrir directamente `public/index.html` en tu navegador o utilizar un servidor local como Live Server en VS Code o `python -m http.server`.

3. Importar la base de datos (opcional):
   - Ejecutar los scripts en `/database/schema.sql` y `/database/seed.sql` en tu gestor de base de datos SQL.
