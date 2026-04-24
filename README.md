# Sistema de Gestión de Tutorías - Backend

Este proyecto corresponde a la interfaz de programación de aplicaciones (API REST) y la base de datos central para el Sistema de Gestión de Tutorías. El backend está construido utilizando Node.js y MySQL para gestionar a los estudiantes, docentes, tutores, reportes de incidencias y la autenticación del sistema.

## Requisitos Previos

Para ejecutar este proyecto localmente, asegúrese de tener instalados los siguientes componentes:
- Node.js (versión 16.x o superior)
- Servidor MySQL (puede utilizar herramientas como XAMPP, WAMP o MySQL Workbench)

## Instalación y Configuración

1. Instalación de dependencias
Navegue al directorio raíz del backend y ejecute el siguiente comando para instalar las librerías necesarias:
```bash
npm install
```

2. Configuración de Base de Datos
- Inicie su servidor MySQL local.
- Abra su gestor de MySQL e importe el archivo de estructura ubicado en `database/init.sql`. Este archivo se encargará de crear la base de datos `tutorias_db`, sus tablas correspondientes (estudiantes, docentes, materias, auth, etc.) y los usuarios de prueba.

3. Variables de Entorno
En la raíz de la carpeta `tutorias_backend`, cree un archivo con el nombre `.env` y agregue las credenciales de su base de datos local. Ejemplo de configuración:
```env
PORT=3001
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=tutorias_db
DB_PORT=3306
```
Asegúrese de modificar el usuario y la contraseña según corresponda a su entorno local.

## Ejecución del Proyecto

Para levantar el servidor en modo desarrollo (el cual se reiniciará automáticamente al detectar cambios gracias a la librería `nodemon`), ejecute:
```bash
npm run dev
```

El servidor estará escuchando en `http://localhost:3001`.

## Librerías Principales Utilizadas
- express: Framework web principal para manejar las rutas y peticiones HTTP.
- mysql2: Cliente de base de datos para ejecutar consultas de manera asíncrona (promesas).
- dotenv: Carga de variables de entorno seguras para la conexión a la base de datos.
- cors: Middleware para permitir peticiones HTTP desde el frontend local.
- nodemon: Herramienta de desarrollo para reiniciar el servidor al guardar cambios.
