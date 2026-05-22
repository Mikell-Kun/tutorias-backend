CREATE DATABASE IF NOT EXISTS tutorias_db;
USE tutorias_db;

-- =============== TABLA UNIFICADA DE USUARIOS ===============
CREATE TABLE IF NOT EXISTS usuarios (
    id INT PRIMARY KEY,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    nombre_completo VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    rol ENUM('estudiante', 'docente', 'tutor') NOT NULL,
    
    -- Campos específicos de Docente / Tutor
    departamento VARCHAR(100),
    
    -- Campos específicos de Estudiante
    fecha_nacimiento DATE,
    carrera VARCHAR(100),
    semestre VARCHAR(50),
    estatus VARCHAR(50),
    tutor_id INT,
    
    FOREIGN KEY (tutor_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

-- =============== MATERIAS ===============
CREATE TABLE IF NOT EXISTS materias (
    codigo VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    departamento VARCHAR(100)
);

-- =============== MENSAJES ===============
CREATE TABLE IF NOT EXISTS mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    remitente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    materia_codigo VARCHAR(20) NULL,
    contenido TEXT NOT NULL,
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (remitente_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (destinatario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (materia_codigo) REFERENCES materias(codigo) ON DELETE SET NULL
);

-- =============== INCIDENCIAS ===============
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
    FOREIGN KEY (remitente_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (estudiante_relacionado) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- =============== INSERTAR USUARIOS (TUTORES) ===============
INSERT IGNORE INTO usuarios (id, correo, contrasena, nombre_completo, telefono, rol, departamento) VALUES
(10000001, 'tutor1@itm.mx', 'abcdef', 'Tutor 1', '686-101', 'tutor', 'Sistemas Computacionales'),
(10000002, 'tutor2@itm.mx', 'abcdef', 'Tutor 2', '686-102', 'tutor', 'Sistemas Computacionales'),
(10000003, 'tutor3@itm.mx', 'abcdef', 'Tutor 3', '686-103', 'tutor', 'Sistemas Computacionales'),
(10000004, 'tutor4@itm.mx', 'abcdef', 'Tutor 4', '686-104', 'tutor', 'Sistemas Computacionales'),
(10000005, 'tutor5@itm.mx', 'abcdef', 'Tutor 5', '686-105', 'tutor', 'Sistemas Computacionales'),
(10000006, 'tutor6@itm.mx', 'abcdef', 'Tutor 6', '686-106', 'tutor', 'Sistemas Computacionales'),
(10000007, 'tutor7@itm.mx', 'abcdef', 'Tutor 7', '686-107', 'tutor', 'Sistemas Computacionales'),
(10000008, 'tutor8@itm.mx', 'abcdef', 'Tutor 8', '686-108', 'tutor', 'Sistemas Computacionales'),
(10000009, 'tutor9@itm.mx', 'abcdef', 'Tutor 9', '686-109', 'tutor', 'Sistemas Computacionales'),
(10000010, 'tutor10@itm.mx', 'abcdef', 'Tutor 10', '686-110', 'tutor', 'Sistemas Computacionales'),
(10000011, 'tutor11@itm.mx', 'abcdef', 'Tutor 11', '686-111', 'tutor', 'Sistemas Computacionales'),
(10000012, 'tutor12@itm.mx', 'abcdef', 'Tutor 12', '686-112', 'tutor', 'Sistemas Computacionales'),
(10000013, 'tutor13@itm.mx', 'abcdef', 'Tutor 13', '686-113', 'tutor', 'Sistemas Computacionales'),
(10000014, 'tutor14@itm.mx', 'abcdef', 'Tutor 14', '686-114', 'tutor', 'Sistemas Computacionales'),
(10000015, 'tutor15@itm.mx', 'abcdef', 'Tutor 15', '686-115', 'tutor', 'Sistemas Computacionales'),
(10000016, 'tutor16@itm.mx', 'abcdef', 'Tutor 16', '686-116', 'tutor', 'Sistemas Computacionales'),
(10000017, 'tutor17@itm.mx', 'abcdef', 'Tutor 17', '686-117', 'tutor', 'Sistemas Computacionales'),
(10000018, 'tutor18@itm.mx', 'abcdef', 'Tutor 18', '686-118', 'tutor', 'Sistemas Computacionales'),
(10000019, 'tutor19@itm.mx', 'abcdef', 'Tutor 19', '686-119', 'tutor', 'Sistemas Computacionales'),
(10000020, 'tutor20@itm.mx', 'abcdef', 'Tutor 20', '686-120', 'tutor', 'Sistemas Computacionales');

-- =============== INSERTAR USUARIOS (DOCENTES) ===============
INSERT IGNORE INTO usuarios (id, correo, contrasena, nombre_completo, telefono, rol, departamento) VALUES
(20000001, 'docente1@itm.mx', 'abcdef', 'Docente 1', '686-201', 'docente', 'Sistemas Computacionales'),
(20000002, 'docente2@itm.mx', 'abcdef', 'Docente 2', '686-202', 'docente', 'Sistemas Computacionales'),
(20000003, 'docente3@itm.mx', 'abcdef', 'Docente 3', '686-203', 'docente', 'Sistemas Computacionales'),
(20000004, 'docente4@itm.mx', 'abcdef', 'Docente 4', '686-204', 'docente', 'Sistemas Computacionales'),
(20000005, 'docente5@itm.mx', 'abcdef', 'Docente 5', '686-205', 'docente', 'Sistemas Computacionales'),
(20000006, 'docente6@itm.mx', 'abcdef', 'Docente 6', '686-206', 'docente', 'Sistemas Computacionales'),
(20000007, 'docente7@itm.mx', 'abcdef', 'Docente 7', '686-207', 'docente', 'Sistemas Computacionales'),
(20000008, 'docente8@itm.mx', 'abcdef', 'Docente 8', '686-208', 'docente', 'Sistemas Computacionales'),
(20000009, 'docente9@itm.mx', 'abcdef', 'Docente 9', '686-209', 'docente', 'Sistemas Computacionales'),
(20000010, 'docente10@itm.mx', 'abcdef', 'Docente 10', '686-210', 'docente', 'Sistemas Computacionales'),
(20000011, 'docente11@itm.mx', 'abcdef', 'Docente 11', '686-211', 'docente', 'Sistemas Computacionales'),
(20000012, 'docente12@itm.mx', 'abcdef', 'Docente 12', '686-212', 'docente', 'Sistemas Computacionales'),
(20000013, 'docente13@itm.mx', 'abcdef', 'Docente 13', '686-213', 'docente', 'Sistemas Computacionales'),
(20000014, 'docente14@itm.mx', 'abcdef', 'Docente 14', '686-214', 'docente', 'Sistemas Computacionales'),
(20000015, 'docente15@itm.mx', 'abcdef', 'Docente 15', '686-215', 'docente', 'Sistemas Computacionales'),
(20000016, 'docente16@itm.mx', 'abcdef', 'Docente 16', '686-216', 'docente', 'Sistemas Computacionales'),
(20000017, 'docente17@itm.mx', 'abcdef', 'Docente 17', '686-217', 'docente', 'Sistemas Computacionales'),
(20000018, 'docente18@itm.mx', 'abcdef', 'Docente 18', '686-218', 'docente', 'Sistemas Computacionales'),
(20000019, 'docente19@itm.mx', 'abcdef', 'Docente 19', '686-219', 'docente', 'Sistemas Computacionales'),
(20000020, 'docente20@itm.mx', 'abcdef', 'Docente 20', '686-220', 'docente', 'Sistemas Computacionales');

-- =============== INSERTAR USUARIOS (ESTUDIANTES) ===============
INSERT IGNORE INTO usuarios (id, correo, contrasena, nombre_completo, telefono, rol, fecha_nacimiento, carrera, semestre, estatus, tutor_id) VALUES
(30000001, 'est1@mx', '12345678', 'estudiante1', '686-301', 'estudiante', '2000-01-01', 'Ingeniería en Sistemas Computacionales', '1er Semestre', 'Regular', 10000001),
(30000002, 'est2@mx', '12345678', 'estudiante2', '686-302', 'estudiante', '2000-01-02', 'Ingeniería en Sistemas Computacionales', '1er Semestre', 'Regular', 10000001),
(30000003, 'est3@mx', '12345678', 'estudiante3', '686-303', 'estudiante', '2000-01-03', 'Ingeniería en Sistemas Computacionales', '2do Semestre', 'Regular', 10000002),
(30000004, 'est4@mx', '12345678', 'estudiante4', '686-304', 'estudiante', '2000-01-04', 'Ingeniería en Sistemas Computacionales', '2do Semestre', 'Regular', 10000002),
(30000005, 'est5@mx', '12345678', 'estudiante5', '686-305', 'estudiante', '2000-01-05', 'Ingeniería en Sistemas Computacionales', '3er Semestre', 'Regular', 10000003),
(30000006, 'est6@mx', '12345678', 'estudiante6', '686-306', 'estudiante', '2000-01-06', 'Ingeniería en Sistemas Computacionales', '3er Semestre', 'Regular', 10000003),
(30000007, 'est7@mx', '12345678', 'estudiante7', '686-307', 'estudiante', '2000-01-07', 'Ingeniería en Sistemas Computacionales', '4to Semestre', 'Regular', 10000004),
(30000008, 'est8@mx', '12345678', 'estudiante8', '686-308', 'estudiante', '2000-01-08', 'Ingeniería en Sistemas Computacionales', '4to Semestre', 'Regular', 10000004),
(30000009, 'est9@mx', '12345678', 'estudiante9', '686-309', 'estudiante', '2000-01-09', 'Ingeniería en Sistemas Computacionales', '5to Semestre', 'Regular', 10000005),
(30000010, 'est10@mx', '12345678', 'estudiante10', '686-310', 'estudiante', '2000-01-10', 'Ingeniería en Sistemas Computacionales', '5to Semestre', 'Regular', 10000005),
(30000011, 'est11@mx', '12345678', 'estudiante11', '686-311', 'estudiante', '2000-01-11', 'Ingeniería en Sistemas Computacionales', '6to Semestre', 'Regular', 10000006),
(30000012, 'est12@mx', '12345678', 'estudiante12', '686-312', 'estudiante', '2000-01-12', 'Ingeniería en Sistemas Computacionales', '6to Semestre', 'Regular', 10000006),
(30000013, 'est13@mx', '12345678', 'estudiante13', '686-313', 'estudiante', '2000-01-13', 'Ingeniería en Sistemas Computacionales', '7mo Semestre', 'Regular', 10000007),
(30000014, 'est14@mx', '12345678', 'estudiante14', '686-314', 'estudiante', '2000-01-14', 'Ingeniería en Sistemas Computacionales', '7mo Semestre', 'Regular', 10000007),
(30000015, 'est15@mx', '12345678', 'estudiante15', '686-315', 'estudiante', '2000-01-15', 'Ingeniería en Sistemas Computacionales', '8vo Semestre', 'Regular', 10000008),
(30000016, 'est16@mx', '12345678', 'estudiante16', '686-316', 'estudiante', '2000-01-16', 'Ingeniería en Sistemas Computacionales', '8vo Semestre', 'Regular', 10000008),
(30000017, 'est17@mx', '12345678', 'estudiante17', '686-317', 'estudiante', '2000-01-17', 'Ingeniería en Sistemas Computacionales', '9no Semestre', 'Regular', 10000009),
(30000018, 'est18@mx', '12345678', 'estudiante18', '686-318', 'estudiante', '2000-01-18', 'Ingeniería en Sistemas Computacionales', '9no Semestre', 'Regular', 10000009),
(30000019, 'est19@mx', '12345678', 'estudiante19', '686-319', 'estudiante', '2000-01-19', 'Ingeniería en Sistemas Computacionales', '1er Semestre', 'Regular', 10000010),
(30000020, 'est20@mx', '12345678', 'estudiante20', '686-320', 'estudiante', '2000-01-20', 'Ingeniería en Sistemas Computacionales', '2do Semestre', 'Regular', 10000010),
(30000021, 'est21@mx', '12345678', 'estudiante21', '686-321', 'estudiante', '2000-01-21', 'Ingeniería en Sistemas Computacionales', '3er Semestre', 'Regular', 10000011),
(30000022, 'est22@mx', '12345678', 'estudiante22', '686-322', 'estudiante', '2000-01-22', 'Ingeniería en Sistemas Computacionales', '4to Semestre', 'Regular', 10000011),
(30000023, 'est23@mx', '12345678', 'estudiante23', '686-323', 'estudiante', '2000-01-23', 'Ingeniería en Sistemas Computacionales', '5to Semestre', 'Regular', 10000012),
(30000024, 'est24@mx', '12345678', 'estudiante24', '686-324', 'estudiante', '2000-01-24', 'Ingeniería en Sistemas Computacionales', '6to Semestre', 'Regular', 10000012),
(30000025, 'est25@mx', '12345678', 'estudiante25', '686-325', 'estudiante', '2000-01-25', 'Ingeniería en Sistemas Computacionales', '7mo Semestre', 'Regular', 10000013),
(30000026, 'est26@mx', '12345678', 'estudiante26', '686-326', 'estudiante', '2000-01-26', 'Ingeniería en Sistemas Computacionales', '8vo Semestre', 'Regular', 10000013),
(30000027, 'est27@mx', '12345678', 'estudiante27', '686-327', 'estudiante', '2000-01-27', 'Ingeniería en Sistemas Computacionales', '9no Semestre', 'Regular', 10000014),
(30000028, 'est28@mx', '12345678', 'estudiante28', '686-328', 'estudiante', '2000-01-28', 'Ingeniería en Sistemas Computacionales', '1er Semestre', 'Regular', 10000014),
(30000029, 'est29@mx', '12345678', 'estudiante29', '686-329', 'estudiante', '2000-01-29', 'Ingeniería en Sistemas Computacionales', '2do Semestre', 'Regular', 10000015),
(30000030, 'est30@mx', '12345678', 'estudiante30', '686-330', 'estudiante', '2000-01-30', 'Ingeniería en Sistemas Computacionales', '3er Semestre', 'Regular', 10000015);

-- =============== INSERTAR MATERIAS (SISTEMAS COMPUTACIONALES) ===============
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
