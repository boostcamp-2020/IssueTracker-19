import { issueModel } from '@models';

/**
 * PATCH /api/issues/:no/milestone
 */
export const changeMilestone = async (req, res, next) => {
  try {
    const { no } = req.params;
    const { milestoneNo } = req.body;
    await issueModel.changeIssueMilestone({ no, milestoneNo });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
