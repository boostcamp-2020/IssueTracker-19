import express from 'express';
import * as closeController from './close.controller';

const router = express.Router({ mergeParams: true });

router.patch('/', closeController.closeIssue);

export default router;
