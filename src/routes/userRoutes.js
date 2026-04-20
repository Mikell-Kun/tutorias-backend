import { Router } from 'express';
import { getUserById, getContactosDisponibles } from '../controllers/userController.js';

const router = Router();

router.get('/contactos', getContactosDisponibles);
router.get('/:id', getUserById);

export default router;
