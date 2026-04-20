CREATE DATABASE IF NOT EXISTS tutorias_db;
USE tutorias_db;

-- =============== TUTORES ===============
CREATE TABLE IF NOT EXISTS tutores_auth (
    id_tutor INT PRIMARY KEY,
    contrasena VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS tutores (
    id_tutor INT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    departamento VARCHAR(100),
    correo VARCHAR(100),
    FOREIGN KEY (id_tutor) REFERENCES tutores_auth(id_tutor) ON DELETE CASCADE
);

-- =============== DOCENTES ===============
CREATE TABLE IF NOT EXISTS docentes_auth (
    n_control INT PRIMARY KEY,
    contrasena VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS docentes (
    n_control INT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    departamento VARCHAR(100),
    correo VARCHAR(100),
    telefono VARCHAR(20),
    FOREIGN KEY (n_control) REFERENCES docentes_auth(n_control) ON DELETE CASCADE
);

-- =============== ESTUDIANTES ===============
CREATE TABLE IF NOT EXISTS estudiantes_auth (
    n_control INT PRIMARY KEY,
    contrasena VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS estudiantes (
    n_control INT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    carrera VARCHAR(100),
    semestre VARCHAR(50),
    estatus VARCHAR(50),
    correo VARCHAR(100),
    tutor_id INT,
    FOREIGN KEY (n_control) REFERENCES estudiantes_auth(n_control) ON DELETE CASCADE,
    FOREIGN KEY (tutor_id) REFERENCES tutores(id_tutor) ON DELETE SET NULL
);

-- =============== OTRAS TABLAS ===============
CREATE TABLE IF NOT EXISTS materias (
    codigo VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    departamento VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    remitente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS incidencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    remitente_id INT,
    estudiante_relacionado INT,
    tipo VARCHAR(100),
    titulo VARCHAR(255),
    descripcion TEXT,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    leida BOOLEAN DEFAULT FALSE,
    datos JSON,
    FOREIGN KEY (estudiante_relacionado) REFERENCES estudiantes(n_control) ON DELETE CASCADE
);

-- =============== INSERTAR DATOS FALSOS ===============
-- Insertar Auth de Tutores
INSERT IGNORE INTO tutores_auth (id_tutor, contrasena) VALUES
(10101010, 'Tutor123'), (20202020, 'Tutor123'), (30303030, 'Tutor123'),
(40404040, 'Tutor123'), (40404041, 'Tutor123');

-- Insertar Tutores
INSERT IGNORE INTO tutores (id_tutor, nombre_completo, telefono, departamento, correo) VALUES
(10101010, 'Tutor1', '686-333-4455', 'Sistemas y Computación', 'tutor1@itmexicali.edu.mx'),
(20202020, 'Tutor2', '686-333-4455', 'Sistemas y Computación', 'tutor2@itmexicali.edu.mx'),
(30303030, 'Tutor3', '686-555-6677', 'Química', 'tutor3@itmexicali.edu.mx'),
(40404040, 'Tutor4', '686-555-6677', 'Química', 'tutor4@itmexicali.edu.mx');

-- Insertar Auth de Docentes (Evitamos solapar el 10101010)
INSERT IGNORE INTO docentes_auth (n_control, contrasena) VALUES
(10101011, 'Docente123'), (20202021, 'Docente123'), (30303031, 'Docente123');

-- Insertar Docentes
INSERT IGNORE INTO docentes (n_control, nombre_completo, departamento, correo, telefono) VALUES
(10101011, 'Docente1', 'Sistemas Computacionales', 'docente1@itmexicali.edu.mx', '686-111-2233'),
(20202021, 'Docente2', 'Sistemas Computacionales', 'docente2@itmexicali.edu.mx', '686-111-2233'),
(30303031, 'Docente3', 'Sistemas Computacionales', 'docente3@itmexicali.edu.mx', '686-444-5566');

-- Insertar Auth de Estudiantes
INSERT IGNORE INTO estudiantes_auth (n_control, contrasena) VALUES
(20491199, 'Gatitofeliz3'), (20491198, '123456'), (20491197, '123456'),
(20491196, '123456'), (20491195, '123456');

-- Insertar Estudiantes
INSERT IGNORE INTO estudiantes (n_control, nombre_completo, fecha_nacimiento, telefono, carrera, semestre, estatus, correo, tutor_id) VALUES
(20491199, 'Gabriel Miguel Cabrera Samano', '2002-09-15', '686-315-1314', 'Ingeniería en Sistemas computacionales', '7mo Semestre', 'Regular', 'a20491199@gmail.com', 20202020),
(20491198, 'Juan Garcia Perez', '2001-05-20', '686-123-4567', 'Ingeniería en Sistemas computacionales', '5to Semestre', 'Regular', 'a20491198@itmexicali.edu.mx', 20202020),
(20491197, 'Maria antonieta de las nieves', '2000-04-20', '686-123-4567', 'Ingeniería en Sistemas computacionales', '8to Semestre', 'Regular', 'a20491198@itmexicali.edu.mx', 40404040),
(20491196, 'Veronica citlali martinez lopez', '2000-04-20', '686-123-4567', 'Ingeniería en Sistemas computacionales', '4to Semestre', 'Regular', 'a20491198@itmexicali.edu.mx', 40404040),
(20491195, 'Jesus Alejandro Hernandez Lopez', '2000-04-20', '686-123-4567', 'Ingenieria en quimica', '2to Semestre', 'Regular', 'a20491198@itmexicali.edu.mx', 20202020);

-- Insertar Materias
INSERT IGNORE INTO materias (codigo, nombre, departamento) VALUES
('ACF-0901', 'Cálculo Diferencial', 'Sistemas Computacionales'),
('SCD-1008', 'Fundamentos de Programación', 'Sistemas Computacionales'),
('ACA-0907', 'Taller de Ética', 'Sistemas Computacionales');
