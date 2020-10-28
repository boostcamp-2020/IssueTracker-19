import express from 'express';
import * as milestonesController from './milestones.controller';

const router = express.Router();

router.get('/', milestonesController.getMilestones);
router.post('/', milestonesController.addMilestone);
router.put('/:no', milestonesController.changeMilestone);
router.delete('/:no', milestonesController.deleteMilestone);

export default router;
