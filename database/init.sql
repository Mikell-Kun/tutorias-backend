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

-- =============== INSERTAR USUARIOS ===============
-- Insertar Auth de Tutores
INSERT IGNORE INTO tutores_auth (id_tutor, contrasena) VALUES
(10000001, 'abcdef'), (10000002, 'abcdef'), (10000003, 'abcdef'), (10000004, 'abcdef'), (10000005, 'abcdef'),
(10000006, 'abcdef'), (10000007, 'abcdef'), (10000008, 'abcdef'), (10000009, 'abcdef'), (10000010, 'abcdef'),
(10000011, 'abcdef'), (10000012, 'abcdef'), (10000013, 'abcdef'), (10000014, 'abcdef'), (10000015, 'abcdef'),
(10000016, 'abcdef'), (10000017, 'abcdef'), (10000018, 'abcdef'), (10000019, 'abcdef'), (10000020, 'abcdef');

-- Insertar Tutores
INSERT IGNORE INTO tutores (id_tutor, nombre_completo, telefono, departamento, correo) VALUES
(10000001, 'Tutor 1', '686-101', 'Sistemas Computacionales', 'tutor1@itm.mx'), (10000002, 'Tutor 2', '686-102', 'Sistemas Computacionales', 'tutor2@itm.mx'),
(10000003, 'Tutor 3', '686-103', 'Sistemas Computacionales', 'tutor3@itm.mx'), (10000004, 'Tutor 4', '686-104', 'Sistemas Computacionales', 'tutor4@itm.mx'),
(10000005, 'Tutor 5', '686-105', 'Sistemas Computacionales', 'tutor5@itm.mx'), (10000006, 'Tutor 6', '686-106', 'Sistemas Computacionales', 'tutor6@itm.mx'),
(10000007, 'Tutor 7', '686-107', 'Sistemas Computacionales', 'tutor7@itm.mx'), (10000008, 'Tutor 8', '686-108', 'Sistemas Computacionales', 'tutor8@itm.mx'),
(10000009, 'Tutor 9', '686-109', 'Sistemas Computacionales', 'tutor9@itm.mx'), (10000010, 'Tutor 10', '686-110', 'Sistemas Computacionales', 'tutor10@itm.mx'),
(10000011, 'Tutor 11', '686-111', 'Sistemas Computacionales', 'tutor11@itm.mx'), (10000012, 'Tutor 12', '686-112', 'Sistemas Computacionales', 'tutor12@itm.mx'),
(10000013, 'Tutor 13', '686-113', 'Sistemas Computacionales', 'tutor13@itm.mx'), (10000014, 'Tutor 14', '686-114', 'Sistemas Computacionales', 'tutor14@itm.mx'),
(10000015, 'Tutor 15', '686-115', 'Sistemas Computacionales', 'tutor15@itm.mx'), (10000016, 'Tutor 16', '686-116', 'Sistemas Computacionales', 'tutor16@itm.mx'),
(10000017, 'Tutor 17', '686-117', 'Sistemas Computacionales', 'tutor17@itm.mx'), (10000018, 'Tutor 18', '686-118', 'Sistemas Computacionales', 'tutor18@itm.mx'),
(10000019, 'Tutor 19', '686-119', 'Sistemas Computacionales', 'tutor19@itm.mx'), (10000020, 'Tutor 20', '686-120', 'Sistemas Computacionales', 'tutor20@itm.mx');

-- Insertar Auth Docentes
INSERT IGNORE INTO docentes_auth (n_control, contrasena) VALUES
(20000001, 'abcdef'), (20000002, 'abcdef'), (20000003, 'abcdef'), (20000004, 'abcdef'), (20000005, 'abcdef'),
(20000006, 'abcdef'), (20000007, 'abcdef'), (20000008, 'abcdef'), (20000009, 'abcdef'), (20000010, 'abcdef'),
(20000011, 'abcdef'), (20000012, 'abcdef'), (20000013, 'abcdef'), (20000014, 'abcdef'), (20000015, 'abcdef'),
(20000016, 'abcdef'), (20000017, 'abcdef'), (20000018, 'abcdef'), (20000019, 'abcdef'), (20000020, 'abcdef');

-- Insertar Docentes
INSERT IGNORE INTO docentes (n_control, nombre_completo, departamento, correo, telefono) VALUES
(20000001, 'Docente 1', 'Sistemas', 'docente1@itm.mx', '686-201'), (20000002, 'Docente 2', 'Sistemas', 'docente2@itm.mx', '686-202'),
(20000003, 'Docente 3', 'Sistemas', 'docente3@itm.mx', '686-203'), (20000004, 'Docente 4', 'Sistemas', 'docente4@itm.mx', '686-204'),
(20000005, 'Docente 5', 'Sistemas', 'docente5@itm.mx', '686-205'), (20000006, 'Docente 6', 'Sistemas', 'docente6@itm.mx', '686-206'),
(20000007, 'Docente 7', 'Sistemas', 'docente7@itm.mx', '686-207'), (20000008, 'Docente 8', 'Sistemas', 'docente8@itm.mx', '686-208'),
(20000009, 'Docente 9', 'Sistemas', 'docente9@itm.mx', '686-209'), (20000010, 'Docente 10', 'Sistemas', 'docente10@itm.mx', '686-210'),
(20000011, 'Docente 11', 'Sistemas', 'docente11@itm.mx', '686-211'), (20000012, 'Docente 12', 'Sistemas', 'docente12@itm.mx', '686-212'),
(20000013, 'Docente 13', 'Sistemas', 'docente13@itm.mx', '686-213'), (20000014, 'Docente 14', 'Sistemas', 'docente14@itm.mx', '686-214'),
(20000015, 'Docente 15', 'Sistemas', 'docente15@itm.mx', '686-215'), (20000016, 'Docente 16', 'Sistemas', 'docente16@itm.mx', '686-216'),
(20000017, 'Docente 17', 'Sistemas', 'docente17@itm.mx', '686-217'), (20000018, 'Docente 18', 'Sistemas', 'docente18@itm.mx', '686-218'),
(20000019, 'Docente 19', 'Sistemas', 'docente19@itm.mx', '686-219'), (20000020, 'Docente 20', 'Sistemas', 'docente20@itm.mx', '686-220');

-- Insertar Auth Estudiantes
INSERT IGNORE INTO estudiantes_auth (n_control, contrasena) VALUES
(30000001, '12345678'), (30000002, '12345678'), (30000003, '12345678'), (30000004, '12345678'), (30000005, '12345678'),
(30000006, '12345678'), (30000007, '12345678'), (30000008, '12345678'), (30000009, '12345678'), (30000010, '12345678'),
(30000011, '12345678'), (30000012, '12345678'), (30000013, '12345678'), (30000014, '12345678'), (30000015, '12345678'),
(30000016, '12345678'), (30000017, '12345678'), (30000018, '12345678'), (30000019, '12345678'), (30000020, '12345678'),
(30000021, '12345678'), (30000022, '12345678'), (30000023, '12345678'), (30000024, '12345678'), (30000025, '12345678'),
(30000026, '12345678'), (30000027, '12345678'), (30000028, '12345678'), (30000029, '12345678'), (30000030, '12345678');

-- Insertar Estudiantes
INSERT IGNORE INTO estudiantes (n_control, nombre_completo, fecha_nacimiento, telefono, carrera, semestre, estatus, correo, tutor_id) VALUES
(30000001, 'estudiante1', '2000-01-01', '686-301', 'Sistemas', '1er Semestre', 'Regular', 'est1@mx', 10000001),
(30000002, 'estudiante2', '2000-01-02', '686-302', 'Sistemas', '1er Semestre', 'Regular', 'est2@mx', 10000001),
(30000003, 'estudiante3', '2000-01-03', '686-303', 'Sistemas', '2do Semestre', 'Regular', 'est3@mx', 10000002),
(30000004, 'estudiante4', '2000-01-04', '686-304', 'Sistemas', '2do Semestre', 'Regular', 'est4@mx', 10000002),
(30000005, 'estudiante5', '2000-01-05', '686-305', 'Sistemas', '3er Semestre', 'Regular', 'est5@mx', 10000003),
(30000006, 'estudiante6', '2000-01-06', '686-306', 'Sistemas', '3er Semestre', 'Regular', 'est6@mx', 10000003),
(30000007, 'estudiante7', '2000-01-07', '686-307', 'Sistemas', '4to Semestre', 'Regular', 'est7@mx', 10000004),
(30000008, 'estudiante8', '2000-01-08', '686-308', 'Sistemas', '4to Semestre', 'Regular', 'est8@mx', 10000004),
(30000009, 'estudiante9', '2000-01-09', '686-309', 'Sistemas', '5to Semestre', 'Regular', 'est9@mx', 10000005),
(30000010, 'estudiante10', '2000-01-10', '686-310', 'Sistemas', '5to Semestre', 'Regular', 'est10@mx', 10000005),
(30000011, 'estudiante11', '2000-01-11', '686-311', 'Sistemas', '6to Semestre', 'Regular', 'est11@mx', 10000006),
(30000012, 'estudiante12', '2000-01-12', '686-312', 'Sistemas', '6to Semestre', 'Regular', 'est12@mx', 10000006),
(30000013, 'estudiante13', '2000-01-13', '686-313', 'Sistemas', '7mo Semestre', 'Regular', 'est13@mx', 10000007),
(30000014, 'estudiante14', '2000-01-14', '686-314', 'Sistemas', '7mo Semestre', 'Regular', 'est14@mx', 10000007),
(30000015, 'estudiante15', '2000-01-15', '686-315', 'Sistemas', '8vo Semestre', 'Regular', 'est15@mx', 10000008),
(30000016, 'estudiante16', '2000-01-16', '686-316', 'Sistemas', '8vo Semestre', 'Regular', 'est16@mx', 10000008),
(30000017, 'estudiante17', '2000-01-17', '686-317', 'Sistemas', '9no Semestre', 'Regular', 'est17@mx', 10000009),
(30000018, 'estudiante18', '2000-01-18', '686-318', 'Sistemas', '9no Semestre', 'Regular', 'est18@mx', 10000009),
(30000019, 'estudiante19', '2000-01-19', '686-319', 'Sistemas', '1er Semestre', 'Regular', 'est19@mx', 10000010),
(30000020, 'estudiante20', '2000-01-20', '686-320', 'Sistemas', '2do Semestre', 'Regular', 'est20@mx', 10000010),
(30000021, 'estudiante21', '2000-01-21', '686-321', 'Sistemas', '3er Semestre', 'Regular', 'est21@mx', 10000011),
(30000022, 'estudiante22', '2000-01-22', '686-322', 'Sistemas', '4to Semestre', 'Regular', 'est22@mx', 10000011),
(30000023, 'estudiante23', '2000-01-23', '686-323', 'Sistemas', '5to Semestre', 'Regular', 'est23@mx', 10000012),
(30000024, 'estudiante24', '2000-01-24', '686-324', 'Sistemas', '6to Semestre', 'Regular', 'est24@mx', 10000012),
(30000025, 'estudiante25', '2000-01-25', '686-325', 'Sistemas', '7mo Semestre', 'Regular', 'est25@mx', 10000013),
(30000026, 'estudiante26', '2000-01-26', '686-326', 'Sistemas', '8vo Semestre', 'Regular', 'est26@mx', 10000013),
(30000027, 'estudiante27', '2000-01-27', '686-327', 'Sistemas', '9no Semestre', 'Regular', 'est27@mx', 10000014),
(30000028, 'estudiante28', '2000-01-28', '686-328', 'Sistemas', '1er Semestre', 'Regular', 'est28@mx', 10000014),
(30000029, 'estudiante29', '2000-01-29', '686-329', 'Sistemas', '2do Semestre', 'Regular', 'est29@mx', 10000015),
(30000030, 'estudiante30', '2000-01-30', '686-330', 'Sistemas', '3er Semestre', 'Regular', 'est30@mx', 10000015);

-- Insertar Materias (Sistemas Computacionales)
INSERT IGNORE INTO materias (codigo, nombre, departamento) VALUES
('ACF-0901', 'Cálculo Diferencial', 'Sistemas Computacionales'),
('SCD-1008', 'Fundamentos de Programación', 'Sistemas Computacionales'),
('ACA-0907', 'Taller de Ética', 'Sistemas Computacionales'),
('SCH-1024', 'Matemáticas Discretas', 'Sistemas Computacionales'),
('SCH-1034', 'Taller de Administración', 'Sistemas Computacionales'),
('ACC-0906', 'Fundamentos de Investigación', 'Sistemas Computacionales'),
('ACF-0902', 'Cálculo Integral', 'Sistemas Computacionales'),
('SCD-1020', 'Programación Orientada a Objetos', 'Sistemas Computacionales'),
('EC-1008', 'Contabilidad Financiera', 'Sistemas Computacionales'),
('AEC-1058', 'Química', 'Sistemas Computacionales'),
('ACF-0903', 'Álgebra Lineal', 'Sistemas Computacionales'),
('AEF-1052', 'Probabilidad y Estadística', 'Sistemas Computacionales'),
('ACF-0904', 'Cálculo Vectorial', 'Sistemas Computacionales'),
('AED-1026', 'Estructura de Datos', 'Sistemas Computacionales'),
('SCC-1005', 'Cultura Empresarial', 'Sistemas Computacionales'),
('SCC-1013', 'Investigación de Operaciones', 'Sistemas Computacionales'),
('SCD-1022', 'Simulación', 'Sistemas Computacionales'),
('SCF-1006', 'Física General', 'Sistemas Computacionales'),
('ACF-0905', 'Ecuaciones Diferenciales', 'Sistemas Computacionales'),
('SCC-1017', 'Métodos Numéricos', 'Sistemas Computacionales'),
('SCD-1027', 'Tópicos Avanzados de Programación', 'Sistemas Computacionales'),
('AEF-1031', 'Fundamentos de Base de Datos', 'Sistemas Computacionales'),
('AEC-1061', 'Sistemas Operativos', 'Sistemas Computacionales'),
('SCD-1018', 'Principios Eléctricos y Aplic. Digitales', 'Sistemas Computacionales'),
('ACD-0908', 'Desarrollo Sustentable', 'Sistemas Computacionales'),
('SCC-1007', 'Fundamentos de Ingeniería de Software', 'Sistemas Computacionales'),
('AEC-1034', 'Fundamentos de Telecomunicación', 'Sistemas Computacionales'),
('SCA-1025', 'Taller de Base de Datos', 'Sistemas Computacionales'),
('SCA-1026', 'Taller de Sistemas Operativos', 'Sistemas Computacionales'),
('SCD-1003', 'Arquitectura de Computadoras', 'Sistemas Computacionales'),
('SCD-1015', 'Lenguajes y Autómatas I', 'Sistemas Computacionales'),
('SCD-1011', 'Ingeniería de Software', 'Sistemas Computacionales'),
('SCD-1021', 'Redes de Computadora', 'Sistemas Computacionales'),
('SCC-1010', 'Graficación', 'Sistemas Computacionales'),
('SCC-1019', 'Programación Lógica y Funcional', 'Sistemas Computacionales'),
('SCC-1014', 'Lenguajes de Interfaz', 'Sistemas Computacionales'),
('SCD-1016', 'Lenguajes y Autómatas II', 'Sistemas Computacionales'),
('SCC-1012', 'Inteligencia Artificial', 'Sistemas Computacionales'),
('SCD-1004', 'Conmutación y Enrutamiento de Datos', 'Sistemas Computacionales'),
('SCB-1004', 'Programación Web', 'Sistemas Computacionales'),
('ISG-1701', 'Ambientes Operativos en la Nube', 'Sistemas Computacionales'),
('SCC-1023', 'Sistemas Programables', 'Sistemas Computacionales'),
('ACA-0909', 'Taller de Investigación I', 'Sistemas Computacionales'),
('ISG-1702', 'Arquitectura Orientada a Servicios', 'Sistemas Computacionales'),
('SCG-1009', 'Gestión de Proyectos de Software', 'Sistemas Computacionales'),
('SCA-1002', 'Administración de Redes', 'Sistemas Computacionales'),
('SCB-1001', 'Administración de Base de Datos', 'Sistemas Computacionales'),
('ISI-1704', 'Desarrollo de Aplicaciones Web', 'Sistemas Computacionales'),
('BZA9-E', 'Desarrollo de Aplicaciones Móviles', 'Sistemas Computacionales'),
('ACA-0910', 'Taller de Investigación II', 'Sistemas Computacionales');
