/**
 * GET /api/issues/:no/comments
 */
export const getComments = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.json({ comments: [] });
};

/**
 * POST /api/issues/:no/comments
 */
export const addComment = (req, res, next) => {
  const { no } = req.params;
  const { issueNo, content, isHead } = req.body;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * PATCH /api/issues/:no/comments/:commentNo
 */
export const changeComment = (req, res, next) => {
  const { no, commentNo } = req.params;
  const { content } = req.body;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * DELETE /api/issues/:no/comments/:commentNo
 */
export const deleteComment = (req, res, next) => {
  const { no, commentNo } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
