import express from 'express';
import * as assigneeController from './assignees.controller';

const router = express.Router();

router.post('/', assigneeController.addIssueAssignee);
router.delete('/:assigneeNo', assigneeController.deleteIssueAssignee);

export default router;
