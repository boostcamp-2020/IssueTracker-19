import express from 'express';
import * as usersController from './users.controller';

const router = express.Router({ mergeParams: true });

router.get('/', usersController.getUsers);

export default router;
