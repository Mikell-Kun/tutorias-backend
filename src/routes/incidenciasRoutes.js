import { Router } from 'express';
import { getIncidencias, addIncidencia, markIncidenciaAsRead } from '../controllers/incidenciasController.js';

const router = Router();

router.get('/', getIncidencias);
router.post('/', addIncidencia);
router.put('/:id/leida', markIncidenciaAsRead);

export default router;
