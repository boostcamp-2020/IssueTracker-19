import express from 'express';
import * as titleController from './title.controller';

const router = express.Router({ mergeParams: true });

router.patch('/', titleController.changeTitle);

export default router;
