import pool from '@lib/db';

export const issueModel = {
  getIssueList({ keyword }) {
    const sql = `SELECT i.no, u.nickname as author, i.title, i.is_opened as isOpened, i.created_at as createdAt, 
    i.closed_at as closedAt, m.title as milestoneTitle, m.no as milestoneNo
    FROM issue i 
    LEFT JOIN milestone m ON m.no = i.milestone_no
    LEFT JOIN user u ON u.no = i.author_no
    WHERE i.title LIKE '%${keyword}%'
    ORDER BY i.no;`;
    return pool.query(sql);
  },
  getIssueByNo({ no }) {
    const sql = `SELECT i.no, u.nickname as author, i.title, i.is_opened as isOpened, i.created_at as createdAt, 
    i.closed_at as closedAt, i.milestone_no as milestoneNo
    FROM issue i 
    LEFT JOIN user u ON u.no = i.author_no
    WHERE i.no = ?;`;
    return pool.execute(sql, [no]);
  },
  addIssue({ title, authorNo, milestoneNo = null }) {
    const sql = 'INSERT INTO issue (title, author_no, milestone_no) VALUES (?, ?, ?);';
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
    const sql = `SELECT a.issue_no as issueNo, a.user_no as userNo, u.nickname as nickname, u.image 
      FROM assignee a 
      LEFT JOIN user u ON u.no = a.user_no
      ORDER BY a.issue_no, u.no;`;
    return pool.query(sql);
  },
  changeIssueTitle({ no, title }) {
    const sql = 'UPDATE issue SET title=? WHERE no=?;';
    return pool.execute(sql, [title, no]);
  },
  changeIssueMilestone({ no, milestoneNo = null }) {
    const sql = 'UPDATE issue SET milestone_no=? WHERE no=?;';
    return pool.execute(sql, [milestoneNo, no]);
  },
  openIssue({ no }) {
    const sql = 'UPDATE issue SET is_opened=1 WHERE no=?;';
    return pool.execute(sql, [no]);
  },
  closeIssue({ no }) {
    const sql = 'UPDATE issue SET is_opened=0 WHERE no=?;';
    return pool.execute(sql, [no]);
  },
};
