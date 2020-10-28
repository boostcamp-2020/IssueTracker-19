import express from 'express';
import * as assigneeController from './assignee.controller';

const router = express.Router();

router.post('/', assigneeController.addIssueAssignee);
router.delete('/', assigneeController.deleteIssueAssignee);

export default router;
