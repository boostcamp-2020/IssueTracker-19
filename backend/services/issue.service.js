import { issueModel, commentModel } from '@models';

const findIssuesLabels = labelList => {
  let labelIdx = 0;
  return issueNo => {
    const labels = [];
    while (true) {
      if (labelIdx >= labelList.length) break;
      const label = labelList[labelIdx];
      const { no, name, description, color } = label;

      if (+label.issueNo !== +issueNo) break;
      labels.push({ no, name, description, color });
      labelIdx += 1;
    }
    return labels;
  };
};

const findIssuesAssignees = assigneeList => {
  let assigneeIdx = 0;
  return issueNo => {
    const assignees = [];
    while (true) {
      if (assigneeIdx >= assigneeList.length) break;
      const assignee = assigneeList[assigneeIdx];
      const { userNo: no, nickname, image } = assignee;

      if (+assignee.issueNo !== +issueNo) break;
      assignees.push({ no, nickname, image });
      assigneeIdx += 1;
    }
    return assignees;
  };
};

const findIssuesComments = commentList => {
  let commentIdx = 0;
  return issueNo => {
    const comments = [];
    while (true) {
      if (commentIdx >= commentList.length) break;
      const comment = commentList[commentIdx];
      const { no, isHead } = comment;

      if (+comment.issueNo !== +issueNo) break;
      comments.push({ no, issueNo, isHead, author: comment.author });
      commentIdx += 1;
    }
    return comments;
  };
};

const getFilterdIssuesByOptions = (issues, nickname, options = {}) => {
  const { isOpened, author, assignee, milestone, comment, label } = options;
  return issues.filter(issue => {
    // 프론트 단에서 자기 자신일 때 @me로 안하고 그냥 nickname이나 user.no 넘겨주면 더 편할 것 같다고 생각(프론트 구현의 측면에서 볼 때)
    if (isOpened) {
      if (+issue.isOpened !== +isOpened) {
        return false;
      }
    }
    if (author) {
      const authorNickname = author === '@me' ? nickname : author;
      if (issue.author !== authorNickname) {
        return false;
      }
    }
    if (assignee) {
      const assigneeNickname = assignee === '@me' ? nickname : assignee;
      if (!issue.assignees.some(a => a.nickname === assigneeNickname)) {
        return false;
      }
    }
    if (milestone && issue.milestone !== milestone) {
      return false;
    }
    if (+comment) {
      // TODO : isHead인 코멘트를 내가 작성한 코멘트라고 할지 안할지에 따라 아래 조건이 수정됨
      const authorNickname = nickname;
      if (
        !issue.comments.some(
          issueComment => !+issueComment.isHead && issueComment.author === authorNickname,
        )
      ) {
        return false;
      }
    }

    if (label) {
      if (Array.isArray(label)) {
        // label 조건이 여러 조건일 때(배열로 올 때)
        if (!label.some(l => issue.labels.some(issueLabel => issueLabel.name === l))) {
          return false;
        }
      } else if (!issue.labels.some(issueLabel => issueLabel.name === label)) {
        // label 조건이 단일 조건일 때
        return false;
      }
    }
    return true;
  });
};

export const issueService = {
  async getFilterdIssues(options, nickname) {
    const [[issues], [labelList], [assigneeList], [commentList]] = await Promise.all([
      issueModel.getIssueList({ keyword: options.keyword ?? '' }),
      issueModel.getIssuesLableList(),
      issueModel.getIssuesAssigneeList(),
      commentModel.getComments(),
    ]);

    const getIssuesLabels = findIssuesLabels(labelList);
    const getIssuesAssignees = findIssuesAssignees(assigneeList);
    const getIssuesComments = findIssuesComments(commentList);

    const issuesWithLabelsAndAssignees = issues.map(issue => {
      const { no: issueNo, milestoneNo, milestoneTitle } = issue;
      const labels = getIssuesLabels(issueNo);
      const assignees = getIssuesAssignees(issueNo);
      const comments = getIssuesComments(issueNo);

      return {
        ...issue,
        labels,
        assignees,
        commentCount: comments.length,
        milestoneNo,
        milestoneTitle,
      };
    });

    return getFilterdIssuesByOptions(issuesWithLabelsAndAssignees, nickname, options);
  },
};
