/**
 * GET /api/issues
 */
export const getIssues = (req, res, next) => {
  const { open, author, assignee, milestone, comment, label } = req.query;

  // TODO : 해당 조건으로 검색하는 로직 구현
  // 검색 조건 + '검색어'로 검색이 가능해야함!

  res.json({ issues: [] });
};

/**
 * POST /api/issues
 */
export const addIssue = (req, res, next) => {
  // TODO : camelCase로 변경하는 것을 프론트에서 할지 여기서 할 지 결정
  const { title, assigneeNo, milestoneNo, labelNo } = req.body;

  // TODO : 이슈 추가 로직 구현
  res.status(201).end();
};
