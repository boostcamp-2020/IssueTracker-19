import express from 'express';
import * as closeController from './close.controller';

const router = express.Router();

router.patch('/', closeController.closeIssue);

export default router;
