import { issueModel } from '@models';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';

/**
 * PATCH /api/issues/:no/title
 */
export const changeTitle = async (req, res, next) => {
  try {
    const { no } = req.params;
    const { title } = req.body;

    if (verify([title])) {
      await issueModel.changeIssueTitle({ no, title });
      res.status(200).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};
