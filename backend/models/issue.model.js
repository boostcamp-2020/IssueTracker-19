import pool from '@lib/db';

// TODO : 테스트 필요

export const issueModel = {
  /* prettier-ignore */
  getIssueList({ isOpened, author, assignee, milestone, comment, label, keyword }) {
    const sql = 'SELECT * FROM issue WHERE open=?;';
    return pool.execute(sql, [open]);
  },
  getIssueByNo({ no }) {
    const sql = 'SELECT * FROM issue WHERE no=';
    return pool.execute(sql);
  },
  addIssue({ authorNo, title, milestoneNo }) {
    const issueSql =
      'INSERT INTO issue (title, author_no, milestone_no) VALUES (?, ?, ?);';
    return pool.execute(issueSql, [title, authorNo, milestoneNo]);
  },
  changeIssueTitle({}) {},
  addIssueAssignee({}) {},
  deleteIssueAssignee({}) {},
  addIssueLabel({}) {},
  deleteIssueLabel({}) {},
  changeIssueMilestone({}) {},
  openIssue({}) {},
  closeIssue({}) {},
  addIssueComment({}) {},
  changeIssueComment({}) {},
  deleteIssueComment({}) {},
};
