import express from 'express';
import { authenticated } from '@middlewares/auth.middleware';
import * as milestonesController from './milestones.controller';

const router = express.Router({ mergeParams: true });

router.get('/', milestonesController.getMilestoneList);
router.get('/:no', milestonesController.getMilestone);

router.use(authenticated);
router.post('/', milestonesController.addMilestone);
router.put('/:no', milestonesController.changeMilestone);
router.delete('/:no', milestonesController.deleteMilestone);
router.patch('/:no/open', milestonesController.openMilestone);
router.patch('/:no/close', milestonesController.closeMilestone);

export default router;
