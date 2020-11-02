import { issueLabelModel } from '@models';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';

/**
 * POST /api/issues/:no/labels
 */
export const addIssueLabel = async (req, res, next) => {
  const { no } = req.params;
  const { labelNo } = req.body;

  try {
    if (verify([labelNo])) {
      await issueLabelModel.addIssueLabel({ issueNo: no, labelNo });
      res.status(201).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/issues/:no/labels/:labelNo
 */
export const deleteIssueLabel = async (req, res, next) => {
  const { no, labelNo } = req.params;
  try {
    await issueLabelModel.deleteIssueLabel({ issueNo: no, labelNo });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
