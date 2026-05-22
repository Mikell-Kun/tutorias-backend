import db from '../config/db.js';

export const getMensajes = async (req, res) => {
    const { userId } = req.params;

    try {
        const [mensajes] = await db.query(
            'SELECT * FROM mensajes WHERE remitente_id = ? OR destinatario_id = ? ORDER BY fecha_hora ASC',
            [userId, userId]
        );
        res.json(mensajes);
    } catch (error) {
        res.status(500).json({ message: "Error recuperando mensajes", error: error.message });
    }
};

export const addMensaje = async (req, res) => {
    const { remitenteId, destinatarioId, contenido, materiaCodigo, materia_codigo } = req.body;
    const finalMateriaCodigo = materiaCodigo || materia_codigo || null;

    if (!remitenteId || !destinatarioId || !contenido) {
        return res.status(400).json({ message: "Faltan datos obligatorios" });
    }

    try {
        const [result] = await db.query(
            'INSERT INTO mensajes (remitente_id, destinatario_id, contenido, materia_codigo) VALUES (?, ?, ?, ?)',
            [remitenteId, destinatarioId, contenido, finalMateriaCodigo]
        );
        
        // Retornar el mensaje recién creado
        const [nuevoMensaje] = await db.query('SELECT * FROM mensajes WHERE id = ?', [result.insertId]);
        res.status(201).json(nuevoMensaje[0]);
    } catch (error) {
        res.status(500).json({ message: "Error al enviar mensaje", error: error.message });
    }
};

export const markMensajesComoLeidos = async (req, res) => {
    // Marca como leídos los mensajes donde userId es el DESTINATARIO y contactId es el REMITENTE
    const { userId, contactId } = req.body;

    try {
        await db.query(
            'UPDATE mensajes SET leido = 1 WHERE destinatario_id = ? AND remitente_id = ? AND leido = 0',
            [userId, contactId]
        );
        res.json({ message: "Mensajes marcados como leídos" });
    } catch (error) {
        res.status(500).json({ message: "Error actualizando mensajes", error: error.message });
    }
};
