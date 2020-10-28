import express from 'express';
import * as labelsController from './labels.controller';

const router = express.Router({ mergeParams: true });

router.get('/', labelsController.getLabels);
router.post('/', labelsController.addLabel);
router.put('/:no', labelsController.changeLabel);
router.delete('/:no', labelsController.deleteLabel);

export default router;
