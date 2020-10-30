import { milestoneModel } from '@models';
/**
 * GET /api/milestones
 */
export const getMilestoneList = async (req, res, next) => {
  try {
    const [milestones] = await milestoneModel.getMilestoneList();
    res.json({ milestones });
  } catch (err) {
    next(err);
  }
};

/**
 * GET /api/milestones/:no
 */
export const getMilestone = async (req, res, next) => {
  try {
    const { no } = req.params;
    const [milestone] = await milestoneModel.getMilestone({ no });
    res.json({ milestone });
  } catch (err) {
    next(err);
  }
};

/**
 * POST /api/milestones
 */
export const addMilestone = async (req, res, next) => {
  try {
    const { title, description, dueDate } = req.body;
    await milestoneModel.addMilestone({ title, description, dueDate });
    res.status(201).end();
  } catch (err) {
    next(err);
  }
};

/**
 * PUT /api/milestones/:no
 */
export const changeMilestone = async (req, res, next) => {
  try {
    const { no } = req.params;
    const { title, description, dueDate } = req.body;
    await milestoneModel.changeMilestone({ title, description, dueDate, no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/milestones/:no
 */
export const deleteMilestone = async (req, res, next) => {
  try {
    const { no } = req.params;
    await milestoneModel.deleteMilestone({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/milestones/:no/open
 */
export const openMilestone = async (req, res, next) => {
  try {
    const { no } = req.params;
    await milestoneModel.openMilestone({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/milestones/:no/close
 */
export const closeMilestone = async (req, res, next) => {
  try {
    const { no } = req.params;
    await milestoneModel.closeMilestone({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
