import db from '../config/db.js';

export const login = async (req, res) => {
    // La interfaz frontal envía n_control o id_tutor como "nControl"
    const { nControl, password } = req.body;

    if (!nControl || !password) {
        return res.status(400).json({ message: "Se requiere usuario y contraseña" });
    }

    try {
        // 1. Revisar si es Estudiante
        const [estudianteAuth] = await db.query(
            'SELECT e.* FROM estudiantes_auth ea JOIN estudiantes e ON ea.n_control = e.n_control WHERE ea.n_control = ? AND ea.contrasena = ?',
            [nControl, password]
        );
        if (estudianteAuth.length > 0) {
            return res.json({ ...estudianteAuth[0], rol: 'estudiante' });
        }

        // 2. Revisar si es Docente
        const [docenteAuth] = await db.query(
            'SELECT d.* FROM docentes_auth da JOIN docentes d ON da.n_control = d.n_control WHERE da.n_control = ? AND da.contrasena = ?',
            [nControl, password]
        );
        if (docenteAuth.length > 0) {
            return res.json({ ...docenteAuth[0], rol: 'docente' });
        }

        // 3. Revisar si es Tutor
        const [tutorAuth] = await db.query(
            'SELECT t.* FROM tutores_auth ta JOIN tutores t ON ta.id_tutor = t.id_tutor WHERE ta.id_tutor = ? AND ta.contrasena = ?',
            [nControl, password]
        );
        if (tutorAuth.length > 0) {
            // Asegurarse de retornar un objeto manejable
            const tutor = tutorAuth[0];
            // Asegúrate de que enviamos una variable estándar por si el Front busca "n_control"
            tutor.n_control = tutor.id_tutor; 
            return res.json({ ...tutor, rol: 'tutor' });
        }

        // Ninguno conectó
        return res.status(401).json({ message: "Credenciales inválidas o no encontradas" });
    } catch (error) {
        console.error("Error validando login:", error);
        res.status(500).json({ message: "Error interno del servidor", error: error.message });
    }
};
