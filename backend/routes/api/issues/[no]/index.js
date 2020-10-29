import express from 'express';
import titleRouter from './title';
import assigneeRouter from './assignees';
import labelRouter from './labels';
import milestoneRouter from './milestone';
import openRouter from './open';
import closeRouter from './close';
import * as issueNoController from './no.controller';

const router = express.Router({ mergeParams: true });

router.use('/title', titleRouter);
router.use('/assignees', assigneeRouter);
router.use('/labels', labelRouter);
router.use('/milestone', milestoneRouter);
router.use('/open', openRouter);
router.use('/close', closeRouter);

router.use('/', issueNoController.getIssue);

export default router;
