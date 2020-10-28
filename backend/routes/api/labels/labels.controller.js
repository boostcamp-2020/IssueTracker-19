/**
 * GET /api/labels
 */
export const getLabels = (req, res, next) => {
  // TODO : 로직 작성
  res.json({ lables: [] });
};

/**
 * POST	/api/labels
 */
export const addLabel = (req, res, next) => {
  const { name, description, color } = req.body;
  // TODO : 로직 작성
  res.status(201).end();
};

/**
 * PUT /api/labels/:no
 */
export const changeLabel = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * DELETE /api/labels/:no
 */
export const deleteLabel = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
