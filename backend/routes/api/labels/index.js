import express from 'express';
import { authenticated } from '@middlewares/auth.middleware';
import * as labelsController from './labels.controller';

const router = express.Router({ mergeParams: true });

router.get('/', labelsController.getLabels);

router.use(authenticated);
router.post('/', labelsController.addLabel);
router.put('/:no', labelsController.changeLabel);
router.delete('/:no', labelsController.deleteLabel);

export default router;
