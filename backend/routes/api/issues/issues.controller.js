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
  const { title, assignee_no, milestone_no, label_no } = req.body;

  // TODO : 이슈 추가 로직 구현
  res.status(201).end();
};

/**
 * PATCH /api/issues/:no/close
 */
export const closeIssue = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};

/**
 * PATCH /api/issues/:no/open
 */
export const openIssue = (req, res, next) => {
  const { no } = req.params;
  // TODO : 로직 작성
  res.status(200).end();
};
