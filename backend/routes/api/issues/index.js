import express from 'express';
import { authenticated } from '@middlewares/auth.middleware';
import * as issuesController from './issues.controller';
import issueNoRouter from './[no]';

const router = express.Router({ mergeParams: true });

router.get('/', issuesController.getIssues);
router.post('/', authenticated, issuesController.addIssue);
router.patch('/open', authenticated, issuesController.openMultipleIssues);
router.patch('/close', authenticated, issuesController.closeMultipleIssues);

router.use('/:no', issueNoRouter);

export default router;
