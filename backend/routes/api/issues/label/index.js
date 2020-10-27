import express from 'express';
import * as labelController from './label.controller';

const router = express.Router();

router.post('/', labelController.addIssueLabel);
router.delete('/', labelController.deleteIssueLabel);

export default router;
