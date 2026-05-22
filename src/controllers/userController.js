import db from '../config/db.js';

export const getUserById = async (req, res) => {
    const { id } = req.params;

    try {
        const [usuarios] = await db.query('SELECT * FROM usuarios WHERE id = ?', [id]);
        if (usuarios.length > 0) {
            const user = usuarios[0];
            // Asegurar compatibilidad con el frontend añadiendo n_control y id_tutor
            return res.json({
                ...user,
                n_control: user.id,
                id_tutor: user.rol === 'tutor' ? user.id : undefined
            });
        }

        return res.status(404).json({ message: "Usuario no encontrado" });
    } catch (error) {
        res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};

export const getContactosDisponibles = async (req, res) => {
    const { rol } = req.query; // Rol de quien hace la solicitud

    try {
        if (rol === 'tutor') {
            // Los tutores ven a estudiantes y docentes
            const [contactos] = await db.query(
                "SELECT id, nombre_completo, correo, rol, CASE WHEN rol = 'estudiante' THEN 'Estudiante' ELSE 'Docente' END as tipo FROM usuarios WHERE rol IN ('estudiante', 'docente')"
            );
            return res.json(contactos);
        } else if (rol === 'estudiante' || rol === 'docente') {
            // Estudiantes y docentes solo ven a los tutores
            const [tutores] = await db.query(
                "SELECT id, nombre_completo, correo, rol, 'Tutor' as tipo FROM usuarios WHERE rol = 'tutor'"
            );
            return res.json(tutores);
        }
        
        return res.json([]);
    } catch (error) {
        res.status(500).json({ message: "Error recuperando contactos", error: error.message });
    }
};

export const updateUserById = async (req, res) => {
    const { id } = req.params;
    const { rol, ...updateData } = req.body;

    try {
        // Protegemos campos sensibles
        delete updateData.id;
        delete updateData.n_control;
        delete updateData.rol;

        const contrasena = updateData.contrasena;
        delete updateData.contrasena;

        const fields = Object.keys(updateData);

        if (fields.length > 0) {
            const setClause = fields.map(field => `${field} = ?`).join(', ');
            const params = fields.map(field => updateData[field]);
            params.push(id);

            const [result] = await db.query(`UPDATE usuarios SET ${setClause} WHERE id = ?`, params);
            if (result.affectedRows === 0 && !contrasena) {
                return res.status(404).json({ message: "Usuario no encontrado" });
            }
        }

        if (contrasena) {
            await db.query(`UPDATE usuarios SET contrasena = ? WHERE id = ?`, [contrasena, id]);
        }

        res.json({ message: "Perfil actualizado exitosamente" });
    } catch (error) {
        res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};
