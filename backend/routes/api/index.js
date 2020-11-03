import express from 'express';
import { authenticated } from '@middlewares/auth.middleware';
import authRouter from './auth';
import commentRouter from './comments';
import issueRouter from './issues';
import labelRouter from './labels';
import milestoneRouter from './milestones';

const router = express.Router({ mergeParams: true });

router.use('/auth', authRouter);
router.use('/comments', authenticated, commentRouter);
router.use('/issues', authenticated, issueRouter);
router.use('/labels', authenticated, labelRouter);
router.use('/milestones', authenticated, milestoneRouter);

export default router;
