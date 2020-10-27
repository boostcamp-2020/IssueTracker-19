import express from 'express';
import * as issuesController from './issues.controller';
import titleRouter from './title';
import assigneeRouter from './assignee';
import labelRouter from './label';
import milestoneRouter from './milestone';

const router = express.Router();

router.use('/title', titleRouter);
router.use('/assignee', assigneeRouter);
router.use('/label', labelRouter);
router.use('/milestone', milestoneRouter);

router.get('/', issuesController.getIssues);
router.post('/', issuesController.addIssue);
router.patch('/:no/close', issuesController.closeIssue);
router.patch('/:no/open', issuesController.openIssue);

export default router;
