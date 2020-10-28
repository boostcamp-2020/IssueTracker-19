import pool from '@lib/db';

// TODO : 테스트 필요

export const issueModel = {
  /* prettier-ignore */
  getIssueList() {
    const sql = `SELECT i.no, u.nickname as author, i.title, i.is_opened as isOpened, i.created_at as createdAt, 
    i.closed_at as closedAt, m.title as milestone, (SELECT COUNT(comment.no) FROM comment WHERE issue_no=i.no) as commentCount 
    FROM issue i 
    LEFT JOIN milestone m ON m.no = i.milestone_no
    LEFT JOIN user u ON u.no = i.author_no
    ORDER BY i.no;`;
    return pool.query(sql);
  },
  getIssueByNo({ no }) {
    const sql = 'SELECT * FROM issue WHERE no=?;';
    return pool.execute(sql, [no]);
  },
  addIssue({ title, authorNo, milestoneNo }) {
    const sql =
      'INSERT INTO issue (title, author_no, milestone_no) VALUES (?, ?, ?);';
    return pool.execute(sql, [title, authorNo, milestoneNo]);
  },
  getIssuesLableList() {
    const sql = `SELECT il.issue_no as issueNo, l.no, l.name, l.description, l.color 
      FROM issue_label il 
      LEFT JOIN label l ON il.label_no = l.no 
      ORDER BY il.issue_no, l.no;`;
    return pool.query(sql);
  },
  getIssuesAssigneeList() {
    const sql = `SELECT a.issue_no as issueNo, a.user_no as userNo, u.nickname as nickname, u.pw, u.image 
      FROM assignee a 
      LEFT JOIN user u ON u.no = a.user_no
      ORDER BY a.issue_no, u.no;`;
    return pool.query(sql);
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
