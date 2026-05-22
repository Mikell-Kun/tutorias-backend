import db from '../config/db.js';

export const login = async (req, res) => {
    // La interfaz frontal envía n_control o id_tutor como "nControl"
    const { nControl, password, rol, roleKey } = req.body;

    if (!nControl || !password) {
        return res.status(400).json({ message: "Se requiere usuario y contraseña" });
    }

    try {
        const [userResult] = await db.query(
            'SELECT * FROM usuarios WHERE id = ? AND contrasena = ?',
            [nControl, password]
        );

        if (userResult.length === 0) {
            return res.status(401).json({ message: "Credenciales inválidas o no encontradas" });
        }

        const user = userResult[0];

        // Validaciones opcionales de seguridad por rol si se especifican las claves
        if (user.rol === 'docente') {
            const expectedKey = process.env.CLAVE_DOCENTE || 'docente123';
            if (roleKey && roleKey !== expectedKey) {
                return res.status(401).json({ message: "Clave de seguridad de docente incorrecta" });
            }
        } else if (user.rol === 'tutor') {
            const expectedKey = process.env.CLAVE_TUTOR || 'tutor123';
            if (roleKey && roleKey !== expectedKey) {
                return res.status(401).json({ message: "Clave de seguridad de tutor incorrecta" });
            }
        }

        // Si la interfaz espera un rol específico enviado por el body, lo validamos.
        if (rol && user.rol !== rol) {
            return res.status(401).json({ message: `El usuario no tiene el rol de ${rol}` });
        }

        // El frontend espera n_control incluso para tutores. 
        // Agregamos n_control con el valor de id para compatibilidad.
        return res.json({
            ...user,
            n_control: user.id,
            id_tutor: user.rol === 'tutor' ? user.id : undefined
        });
    } catch (error) {
        console.error("Error validando login:", error);
        res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};

export const register = async (req, res) => {
    const { rol, nControl, nombreCompleto, correo, contrasena, roleKey } = req.body;

    if (!rol || !nombreCompleto || !correo || !contrasena) {
        return res.status(400).json({ message: "Todos los campos obligatorios son requeridos" });
    }

    try {
        // Verificar si ya existe el correo
        const [existingEmail] = await db.query('SELECT id FROM usuarios WHERE correo = ?', [correo]);
        if (existingEmail.length > 0) {
            return res.status(400).json({ message: "El correo electrónico ya está registrado" });
        }

        if (rol === 'estudiante') {
            if (!nControl) {
                return res.status(400).json({ message: "Número de control es requerido para estudiantes" });
            }
            
            // Verificar si ya existe en usuarios
            const [existing] = await db.query('SELECT id FROM usuarios WHERE id = ?', [nControl]);
            if (existing.length > 0) {
                return res.status(400).json({ message: "El número de control ya está registrado" });
            }

            // Insertar estudiante en usuarios
            await db.query(
                'INSERT INTO usuarios (id, correo, contrasena, nombre_completo, rol, carrera, semestre, estatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                [nControl, correo, contrasena, nombreCompleto, 'estudiante', 'Ingeniería en Sistemas Computacionales', '1er Semestre', 'Regular']
            );

            return res.status(201).json({
                n_control: nControl,
                nombre_completo: nombreCompleto,
                correo: correo,
                rol: 'estudiante',
                message: "Estudiante registrado exitosamente"
            });
        } 
        
        if (rol === 'docente') {
            const expectedKey = process.env.CLAVE_DOCENTE || 'docente123';
            if (roleKey && roleKey !== expectedKey) {
                return res.status(401).json({ message: "Clave de seguridad de docente incorrecta" });
            }

            // Generar ID secuencial si no se pasa nControl
            let finalId = nControl;
            if (!finalId) {
                const [maxResult] = await db.query("SELECT MAX(id) as max_id FROM usuarios WHERE rol = 'docente'");
                finalId = 20000001;
                if (maxResult[0] && maxResult[0].max_id && maxResult[0].max_id >= 20000000) {
                    finalId = maxResult[0].max_id + 1;
                }
            }

            // Verificar si ya existe el ID
            const [existing] = await db.query('SELECT id FROM usuarios WHERE id = ?', [finalId]);
            if (existing.length > 0) {
                return res.status(400).json({ message: "El ID generado o proveído ya está registrado" });
            }

            // Insertar docente en usuarios
            await db.query(
                'INSERT INTO usuarios (id, correo, contrasena, nombre_completo, rol, departamento) VALUES (?, ?, ?, ?, ?, ?)',
                [finalId, correo, contrasena, nombreCompleto, 'docente', 'Sistemas Computacionales']
            );

            return res.status(201).json({
                n_control: finalId,
                nombre_completo: nombreCompleto,
                correo: correo,
                rol: 'docente',
                message: "Docente registrado exitosamente"
            });
        } 
        
        if (rol === 'tutor') {
            const expectedKey = process.env.CLAVE_TUTOR || 'tutor123';
            if (roleKey && roleKey !== expectedKey) {
                return res.status(401).json({ message: "Clave de seguridad de tutor incorrecta" });
            }

            // Generar ID secuencial si no se pasa nControl
            let finalId = nControl;
            if (!finalId) {
                const [maxResult] = await db.query("SELECT MAX(id) as max_id FROM usuarios WHERE rol = 'tutor'");
                finalId = 10000001;
                if (maxResult[0] && maxResult[0].max_id && maxResult[0].max_id >= 10000000) {
                    finalId = maxResult[0].max_id + 1;
                }
            }

            // Verificar si ya existe el ID
            const [existing] = await db.query('SELECT id FROM usuarios WHERE id = ?', [finalId]);
            if (existing.length > 0) {
                return res.status(400).json({ message: "El ID generado o proveído ya está registrado" });
            }

            // Insertar tutor en usuarios
            await db.query(
                'INSERT INTO usuarios (id, correo, contrasena, nombre_completo, rol, departamento) VALUES (?, ?, ?, ?, ?, ?)',
                [finalId, correo, contrasena, nombreCompleto, 'tutor', 'Sistemas Computacionales']
            );

            return res.status(201).json({
                n_control: finalId,
                id_tutor: finalId,
                nombre_completo: nombreCompleto,
                correo: correo,
                rol: 'tutor',
                message: "Tutor registrado exitosamente"
            });
        }

        return res.status(400).json({ message: "Rol inválido" });
    } catch (error) {
        console.error("Error al registrar usuario:", error);
        res.status(500).json({ message: "Error interno del servidor al registrar", error: error.message });
    }
};
