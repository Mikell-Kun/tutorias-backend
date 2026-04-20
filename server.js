import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import db from './src/config/db.js';

// Importar rutas
import authRoutes from './src/routes/authRoutes.js';
import userRoutes from './src/routes/userRoutes.js';
import mensajesRoutes from './src/routes/mensajesRoutes.js';
import incidenciasRoutes from './src/routes/incidenciasRoutes.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middlewares
app.use(cors());
app.use(express.json());

// Registrar rutas
app.use('/api/auth', authRoutes);
app.use('/api/usuarios', userRoutes);
app.use('/api/mensajes', mensajesRoutes);
app.use('/api/incidencias', incidenciasRoutes);

// Endpoints básicos de prueba
app.get('/api/test-db', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT 1 + 1 AS resultado');
        res.json({ message: 'Conexión exitosa a MySQL', data: rows });
    } catch (error) {
        console.error("Error conectando a la BD:", error);
        res.status(500).json({ message: 'Error conectando a la base de datos', error: error.message });
    }
});

app.get('/api/estudiantes', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM estudiantes');
        res.json(rows);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Levantar el servidor
app.listen(PORT, () => {
    console.log(`Servidor corriendo en el puerto ${PORT}`);
});
