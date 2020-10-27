import express from 'express';
import githubRouter from './github';
import * as authController from './auth.controller';

const router = express();

router.use('/github', githubRouter);
router.post('/login', authController.login);
router.post('/logout', authController.logout);

export default router;
