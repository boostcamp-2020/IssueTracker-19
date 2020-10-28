import express from 'express';
import * as githubController from './github.controller';

const router = express.Router({ mergeParams: true });
router.get('/', githubController.login);
router.get('/callback', githubController.handleAuth, githubController.success);
router.get('/failure', githubController.failure);

export default router;
