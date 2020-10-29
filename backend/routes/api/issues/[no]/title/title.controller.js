import { issueModel } from '@models';

/**
 * PATCH /api/issues/:no/title
 */
export const changeTitle = async (req, res, next) => {
  try {
    const { no } = req.params;
    const { title } = req.body;

    await issueModel.changeIssueTitle({ no, title });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
