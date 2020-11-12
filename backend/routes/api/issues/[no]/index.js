import express from 'express';
import { authenticated } from '@middlewares/auth.middleware';
import titleRouter from './title';
import assigneeRouter from './assignees';
import labelRouter from './labels';
import milestoneRouter from './milestone';
import openRouter from './open';
import closeRouter from './close';
import * as issueNoController from './no.controller';

const router = express.Router({ mergeParams: true });

router.use('/title', authenticated, titleRouter);
router.use('/assignees', authenticated, assigneeRouter);
router.use('/labels', authenticated, labelRouter);
router.use('/milestone', authenticated, milestoneRouter);
router.use('/open', authenticated, openRouter);
router.use('/close', authenticated, closeRouter);

router.get('/', issueNoController.getIssue);
router.delete('/', issueNoController.deleteIssue);

export default router;
