import express from 'express';
import * as milestoneController from './milestone.controller';

const router = express.Router();

router.patch('/', milestoneController.changeMilestone);

export default router;
