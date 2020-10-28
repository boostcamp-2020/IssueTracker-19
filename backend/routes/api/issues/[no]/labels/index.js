import express from 'express';
import * as labelController from './label.controller';

const router = express.Router({ mergeParams: true });

router.post('/', labelController.addIssueLabel);
router.delete('/:labelNo', labelController.deleteIssueLabel);

export default router;
