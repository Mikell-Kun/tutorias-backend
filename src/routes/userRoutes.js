import { Router } from 'express';
import { getUserById, getContactosDisponibles, updateUserById } from '../controllers/userController.js';

const router = Router();

router.get('/contactos', getContactosDisponibles);
router.get('/:id', getUserById);
router.put('/:id', updateUserById);

export default router;
