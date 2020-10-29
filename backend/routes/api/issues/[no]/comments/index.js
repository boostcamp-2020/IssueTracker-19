import express from 'express';
import * as commentController from './comment.controller';

const router = express.Router({ mergeParams: true });

router.post('/', commentController.addComment);
router.patch('/', commentController.changeComment);
router.delete('/', commentController.deleteComment);

export default router;
