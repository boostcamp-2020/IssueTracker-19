import { issueModel } from '@models';
/**
 * GET /api/issues
 */
export const getIssues = async (req, res, next) => {
  const { isOpened, author, assignee, milestone, comment, label } = req.query;

  // let filterOptionSql = 'WHERE ';
  // const options = [];
  // if(author) options.push(`u.nickname = ${author}`);
  // if(assignee) {
  //   // options.push(`assignee = ${author}`);
  // }
  // if(milestone) options.push(`m.title = ${milestone}`);
  // if(comment) options.push(`author = ${author}`);
  // if(author) options.push(`author = ${author}`);

  const [issues] = await issueModel.getIssueList();
  const [labelList] = await issueModel.getIssuesLableList();
  const [assigneeList] = await issueModel.getIssuesAssigneeList();

  let labelIdx = 0;
  let assigneeIdx = 0;

  // TODO : 이 부분 서비스 코드로 분리하기
  const issuesWithLabelsAndMileStones = issues.map(issue => {
    const { no: issueNo } = issue;
    const labels = [];
    const assignees = [];
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
    return { ...issue, labels, assignees };
  });

  // TODO : 여기에 필터조건 걸기
  // TODO ::: 여기서 필터링하는 것보다 mysql 쿼리로 필터링을 거는게 좀 더 유연하게 될 듯..

  const filterdIssues = issuesWithLabelsAndMileStones.filter(issue => {
    if (author && issue.author !== author) {
      return false;
    }
    if (assignee && !issue.assignees.some(a => a === assignee)) {
      return false;
    }
    // if (label) {
    //   if (Array.isArray(label) && label) {
    //     return;
    //   }
    //   return;
    // }
    return true;
  });

  // TODO : 해당 조건으로 검색하는 로직 구현
  // 검색 조건 + '검색어'로 검색이 가능해야함!

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
