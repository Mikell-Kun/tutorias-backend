import { Router } from 'express';
import { getMensajes, addMensaje, markMensajesComoLeidos } from '../controllers/mensajesController.js';

const router = Router();

router.get('/:userId', getMensajes);
router.post('/', addMensaje);
router.put('/leidos', markMensajesComoLeidos);

export default router;
