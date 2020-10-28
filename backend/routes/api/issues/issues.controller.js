import { issueModel, commentModel } from '@models';
/**
 * GET /api/issues
 */
export const getIssues = async (req, res, next) => {
  const { isOpened, author, assignee, milestone, comment, label } = req.query;

  const [
    [issues],
    [labelList],
    [assigneeList],
    [commentList],
  ] = await Promise.all([
    issueModel.getIssueList(),
    issueModel.getIssuesLableList(),
    issueModel.getIssuesAssigneeList(),
    commentModel.getComments(),
  ]);

  let labelIdx = 0;
  let assigneeIdx = 0;
  let commentIdx = 0;

  // TODO : 이 부분 서비스 코드로 분리하기
  const issuesWithLabelsAndMileStones = issues.map(issue => {
    const { no: issueNo } = issue;
    const labels = [];
    const assignees = [];
    const comments = [];
    while (true) {
      if (labelIdx >= labelList.length) break;
      const label = labelList[labelIdx];
      const { no, name, description, color } = label;

      if (+label.issueNo !== +issueNo) break;
      labels.push({ no, name, description, color });
      labelIdx += 1;
    }

    while (true) {
      if (assigneeIdx >= assigneeList.length) break;
      const assignee = assigneeList[assigneeIdx];
      const { userNo: no, nickname, image } = assignee;

      if (+assignee.issueNo !== +issueNo) break;
      assignees.push({ no, nickname, image });
      assigneeIdx += 1;
    }

    while (true) {
      if (commentIdx >= commentList.length) break;
      const comment = commentList[commentIdx];
      const { no } = comment;

      if (+comment.issueNo !== +issueNo) break;
      comments.push({ no, issueNo: comment.issueNo });
      commentIdx += 1;
    }
    return { ...issue, labels, assignees, commentCount: comments.length };
  });

  const filterdIssues = issuesWithLabelsAndMileStones.filter(issue => {
    // 프론트 단에서 자기 자신일 때 @me로 안하고 그냥 nickname이나 user.no 넘겨주면 더 편할 것 같다고 생각(프론트 구현의 측면에서 볼 때)
    if (isOpened) {
      if (+issue.isOpened !== +isOpened) {
        return false;
      }
    }
    if (author) {
      const authorNickname = author === '@me' ? req.user : author;
      if (issue.author !== authorNickname) {
        return false;
      }
    }
    if (assignee) {
      const assigneeNickname = assignee === '@me' ? req.user : assignee;
      if (!issue.assignees.some(a => a.nickname === assigneeNickname)) {
        return false;
      }
    }
    if (milestone && issue.milestone !== milestone) {
      return false;
    }
    // TODO : comment 조건 필터링!! 내가 댓글을 작성한 이슈인지 -> 이거 구현이 애매해서 잠시 보류
    if (label) {
      if (Array.isArray(label)) {
        // label 조건이 여러 조건일 때(배열로 올 때)
        if (
          !label.some(l =>
            issue.labels.some(issueLabel => issueLabel.name === l),
          )
        ) {
          return false;
        }
      } else if (!issue.labels.some(issueLabel => issueLabel.name === label)) {
        // label 조건이 단일 조건일 때
        return false;
      }
    }
    return true;
  });

  // TODO : 해당 조건으로 검색하는 로직 구현
  // 검색 조건 + '검색어'로 검색이 가능해야함! -> 이 조건은 mysql 쿼리 던질 때 WHERE title LIKE '%keyword%' 옵션으로 검색하는게 좋을 듯

  res.json({ issues: filterdIssues });
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
