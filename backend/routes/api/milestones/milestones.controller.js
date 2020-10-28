/**
 * GET /api/milestones
 */
export const getMilestones = (req, res, next) => {
  // TODO : 로직 작성
  res.json({ milestones: [] });
};

/**
 * POST /api/milestones
 */
export const addMilestone = (req, res, next) => {
  // TODO : 로직 작성
  const { title, description, dueDate } = req.body;
  res.status(201).end();
};

/**
 * PUT /api/milestones/:no
 */
export const changeMilestone = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * DELETE /api/milestones/:no
 */
export const deleteMilestone = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
