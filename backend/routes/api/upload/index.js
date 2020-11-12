import express from 'express';
import * as uploadController from './upload.controller';

const router = express.Router({ mergeParams: true });

router.post('/images', uploadController.uploadImage);

export default router;
