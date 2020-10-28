import express from 'express';
import authRouter from './auth';
import issueRouter from './issues';

const router = express.Router();

router.use('/auth', authRouter);
router.use('/issues', issueRouter);

export default router;
