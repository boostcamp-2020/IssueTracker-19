import express from 'express';
import * as authController from './auth.controller';

const router = express();

router.post('/login', authController.login);
router.post('/logout', authController.logout);

export default router;
