/**
 * PATCH /api/issues/:no/milestone
 */
export const changeMilestone = (req, res, next) => {
  const { no } = req.params;
  const { milestoneNo } = req.body;
  // TODO : 로직 작성
  res.status(200).end();
};
