import db from '../config/db.js';

export const getIncidencias = async (req, res) => {
    try {
        const [incidencias] = await db.query('SELECT * FROM incidencias ORDER BY fecha_hora DESC');
        // Asegurarnos que JSON se parsee si fue guardado como string (depende de MySQL), 
        // pero db.query suele ya retornar el JSON parseado si se declaró el tipo JSON
        res.json(incidencias);
    } catch (error) {
        res.status(500).json({ message: "Error recuperando incidencias", error: error.message });
    }
};

export const addIncidencia = async (req, res) => {
    const { remitente_id, estudiante_relacionado, tipo, titulo, descripcion, datos } = req.body;

    try {
        // datos se guarda en JSON en la DB
        const [result] = await db.query(
            'INSERT INTO incidencias (remitente_id, estudiante_relacionado, tipo, titulo, descripcion, datos) VALUES (?, ?, ?, ?, ?, ?)',
            [remitente_id, estudiante_relacionado, tipo, titulo, descripcion, JSON.stringify(datos || {})]
        );
        
        // Return created
        const [nuevaIncidencia] = await db.query('SELECT * FROM incidencias WHERE id = ?', [result.insertId]);
        res.status(201).json(nuevaIncidencia[0]);
    } catch (error) {
        res.status(500).json({ message: "Error creando incidencia", error: error.message });
    }
};

export const markIncidenciaAsRead = async (req, res) => {
    const { id } = req.params;

    try {
        await db.query('UPDATE incidencias SET leida = 1 WHERE id = ?', [id]);
        res.json({ message: "Incidencia marcada como leída" });
    } catch (error) {
        res.status(500).json({ message: "Error actualizando incidencia", error: error.message });
    }
};
