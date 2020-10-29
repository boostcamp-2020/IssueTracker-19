import express from 'express';
import authRouter from './auth';
import commentRouter from './comments';
import issueRouter from './issues';
import labelRouter from './labels';
import milestoneRouter from './milestones';

const router = express.Router({ mergeParams: true });

router.use('/auth', authRouter);
router.use('/comments', commentRouter);
router.use('/issues', issueRouter);
router.use('/labels', labelRouter);
router.use('/milestones', milestoneRouter);

export default router;
