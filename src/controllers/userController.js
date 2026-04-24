import db from '../config/db.js';

export const getUserById = async (req, res) => {
    const { id } = req.params;

    try {
        // 1. Tratar como Estudiante
        const [estudiante] = await db.query('SELECT *, "estudiante" as rol FROM estudiantes WHERE n_control = ?', [id]);
        if (estudiante.length > 0) return res.json(estudiante[0]);

        // 2. Tratar como Docente
        const [docente] = await db.query('SELECT *, "docente" as rol FROM docentes WHERE n_control = ?', [id]);
        if (docente.length > 0) return res.json(docente[0]);

        // 3. Tratar como Tutor
        const [tutor] = await db.query('SELECT *, "tutor" as rol FROM tutores WHERE id_tutor = ?', [id]);
        if (tutor.length > 0) return res.json(tutor[0]);

        return res.status(404).json({ message: "Usuario no encontrado" });
    } catch (error) {
        res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};

export const getContactosDisponibles = async (req, res) => {
    const { rol } = req.query; // Rol de quien hace la solicitud

    try {
        if (rol === 'tutor') {
            // Tutors can see everyone
            const [estudiantes] = await db.query('SELECT n_control as id, nombre_completo, "Estudiante" as tipo FROM estudiantes');
            const [docentes] = await db.query('SELECT n_control as id, nombre_completo, "Docente" as tipo FROM docentes');
            return res.json([...estudiantes, ...docentes]);
        } else if (rol === 'estudiante' || rol === 'docente') {
            // Students and Teachers can only see Tutors
            const [tutores] = await db.query('SELECT id_tutor as id, nombre_completo, "Tutor" as tipo FROM tutores');
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
        let updateQuery = '';
        const params = [];

        // Protegemos campos sensibles
        delete updateData.estatus;
        delete updateData.n_control;
        delete updateData.id_tutor;

        const contrasena = updateData.contrasena;
        delete updateData.contrasena;

        const fields = Object.keys(updateData);
        let updatedProfile = true;

        if (fields.length > 0) {
            const setClause = fields.map(field => `${field} = ?`).join(', ');
            fields.forEach(field => params.push(updateData[field]));
            params.push(id);

            if (rol === 'estudiante') {
                updateQuery = `UPDATE estudiantes SET ${setClause} WHERE n_control = ?`;
            } else if (rol === 'docente') {
                updateQuery = `UPDATE docentes SET ${setClause} WHERE n_control = ?`;
            } else if (rol === 'tutor') {
                updateQuery = `UPDATE tutores SET ${setClause} WHERE id_tutor = ?`;
            } else {
                 return res.status(400).json({ message: "Rol inválido" });
            }

            const [result] = await db.query(updateQuery, params);
            if (result.affectedRows === 0 && !contrasena) {
                return res.status(404).json({ message: "Usuario no encontrado" });
            }
        }

        if (contrasena) {
            let authQuery = '';
            if (rol === 'estudiante') {
                authQuery = `UPDATE estudiantes_auth SET contrasena = ? WHERE n_control = ?`;
            } else if (rol === 'docente') {
                authQuery = `UPDATE docentes_auth SET contrasena = ? WHERE n_control = ?`;
            } else if (rol === 'tutor') {
                authQuery = `UPDATE tutores_auth SET contrasena = ? WHERE id_tutor = ?`;
            }
            if(authQuery) {
                await db.query(authQuery, [contrasena, id]);
            }
        }

        res.json({ message: "Perfil actualizado exitosamente" });
    } catch (error) {
        res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};
