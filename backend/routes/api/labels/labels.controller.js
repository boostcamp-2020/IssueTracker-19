import { labelModel } from '@models';
/**
 * GET /api/labels
 */
export const getLabels = async (req, res, next) => {
  try {
    const [row] = await labelModel.getLabels();
    res.json({ lables: row });
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
    await labelModel.addLabel({ name, description, color });
    res.status(201).end();
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
    await labelModel.changeLabel({ name, description, color, no });
    res.status(200).end();
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
