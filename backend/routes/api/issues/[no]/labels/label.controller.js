import { issueLabelModel } from '@models';

/**
 * POST /api/issues/:no/labels
 */
export const addIssueLabel = async (req, res, next) => {
  const { no } = req.params;
  const { labelNo } = req.body;

  try {
    await issueLabelModel.addIssueLabel({ issueNo: no, labelNo });
    res.status(201).end();
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
