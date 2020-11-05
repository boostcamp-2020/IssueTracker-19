import { userModel } from '@models';

/**
 * GET /api/users
 */
export const getUsers = async (req, res, next) => {
  try {
    const [users] = await userModel.getUsers();
    res.json({ users });
  } catch (err) {
    next(err);
  }
};
