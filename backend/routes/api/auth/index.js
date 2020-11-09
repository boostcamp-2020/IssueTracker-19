import express from 'express';
import { authenticated } from '@middlewares/auth.middleware';
import githubRouter from './github';
import * as authController from './auth.controller';

const router = express.Router({ mergeParams: true });

router.use('/github', githubRouter);
router.post('/login', authController.login);
router.post('/logout', authController.logout);
router.post('/signup', authController.signup);
router.get('/check', authenticated, authController.checkLogin);

export default router;
