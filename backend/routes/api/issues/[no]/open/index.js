import express from 'express';
import * as openController from './open.controller';

const router = express.Router({ mergeParams: true });

router.patch('/', openController.openIssue);

export default router;
