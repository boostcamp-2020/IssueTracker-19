import { labelModel } from '@models';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';

/**
 * GET /api/labels
 */
export const getLabels = async (req, res, next) => {
  try {
    const [labels] = await labelModel.getLabels();
    res.json({ labels });
  } catch (err) {
    next(err);
  }
};

/**
 * POST	/api/labels
 */
export const addLabel = async (req, res, next) => {
  try {
    const { name, description, color } = req.body;
    if (verify([name, color])) {
      await labelModel.addLabel({ name, description, color });
      res.status(201).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * PUT /api/labels/:no
 */
export const changeLabel = async (req, res, next) => {
  try {
    const { no } = req.params;
    const { name, description, color } = req.body;
    if (verify([name, color])) {
      await labelModel.changeLabel({ name, description, color, no });
      res.status(200).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/labels/:no
 */
export const deleteLabel = async (req, res, next) => {
  try {
    const { no } = req.params;
    await labelModel.deleteLabel({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
