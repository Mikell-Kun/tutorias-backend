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
