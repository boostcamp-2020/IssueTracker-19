import { issueModel, commentModel, labelModel, assigneeModel } from '@models';

/**
 * GET /api/issues
 */
export const getIssues = async (req, res, next) => {
  try {
    const {
      isOpened,
      author,
      assignee,
      milestone,
      comment,
      label,
      keyword,
    } = req.query;

    const [
      [issues],
      [labelList],
      [assigneeList],
      [commentList],
    ] = await Promise.all([
      issueModel.getIssueList({ keyword: keyword ?? '' }),
      issueModel.getIssuesLableList(),
      issueModel.getIssuesAssigneeList(),
      commentModel.getComments(),
    ]);

    let labelIdx = 0;
    let assigneeIdx = 0;
    let commentIdx = 0;

    // TODO : 이 부분 서비스 코드로 분리하기
    const issuesWithLabelsAndAssignees = issues.map(issue => {
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
        const { no, isHead } = comment;

        if (+comment.issueNo !== +issueNo) break;
        comments.push({
          no,
          issueNo,
          isHead,
          author: comment.author,
        });
        commentIdx += 1;
      }
      return {
        ...issue,
        labels,
        assignees,
        comments,
        commentCount: comments.length,
      };
    });

    const filterdIssues = issuesWithLabelsAndAssignees.filter(issue => {
      // 프론트 단에서 자기 자신일 때 @me로 안하고 그냥 nickname이나 user.no 넘겨주면 더 편할 것 같다고 생각(프론트 구현의 측면에서 볼 때)
      if (isOpened) {
        if (+issue.isOpened !== +isOpened) {
          return false;
        }
      }
      if (author) {
        const authorNickname = author === '@me' ? req.user.nickname : author;
        if (issue.author !== authorNickname) {
          return false;
        }
      }
      if (assignee) {
        const assigneeNickname =
          assignee === '@me' ? req.user.nickname : assignee;
        if (!issue.assignees.some(a => a.nickname === assigneeNickname)) {
          return false;
        }
      }
      if (milestone && issue.milestone !== milestone) {
        return false;
      }
      if (+comment) {
        // TODO : isHead인 코멘트를 내가 작성한 코멘트라고 할지 안할지에 따라 아래 조건이 수정됨
        const authorNickname = req.user.nickname;
        if (
          !issue.comments.some(
            issueComment =>
              !+issueComment.isHead && issueComment.author === authorNickname,
          )
        ) {
          return false;
        }
      }

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
        } else if (
          !issue.labels.some(issueLabel => issueLabel.name === label)
        ) {
          // label 조건이 단일 조건일 때
          return false;
        }
      }
      return true;
    });

    // TODO : 해당 조건으로 검색하는 로직 구현
    // 검색 조건 + '검색어'로 검색이 가능해야함! -> 이 조건은 mysql 쿼리 던질 때 WHERE title LIKE '%keyword%' 옵션으로 검색하는게 좋을 듯

    res.json({ issues: filterdIssues });
  } catch (err) {
    next(err);
  }
};

/**
 * POST /api/issues
 */
export const addIssue = async (req, res, next) => {
  try {
    const { title, assigneeNos, milestoneNo, labelNos, content } = req.body;
    const { no: authorNo } = req.user;

    const [{ insertId: issueNo }] = await issueModel.addIssue({
      title,
      authorNo,
      milestoneNo,
    });

    // TODO :: commentModel의 addComment 호출해서 isHead = 1으로 추가할 것

    if (labelNos && labelNos.length) {
      await labelModel.bulkAddIssueLabel({ labelNos, issueNo });
    }

    if (assigneeNos && assigneeNos.length) {
      await assigneeModel.bulkAddassignee({ assigneeNos, issueNo });
    }
    res.status(201).end();
  } catch (err) {
    next(err);
  }
};
