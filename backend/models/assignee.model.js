import pool from '@lib/db';

export const assigneeModel = {
  bulkAddassignee({ assigneeNos, issueNo }) {
    const assigneesLength = assigneeNos.length;
    const sql = assigneeNos.reduce(
      (acc, assigneeNo, idx) =>
        acc + `(${assigneeNo}, ${issueNo})${idx === assigneesLength - 1 ? ';' : ', '}`,
      'INSERT INTO assignee (user_no, issue_no) VALUES ',
    );
    return pool.query(sql);
  },
  getAssigneesByIssueNo({ issueNo }) {
    const sql = `SELECT a.user_no as userNo, a.issue_no as issueNo, u.nickname
    FROM assignee a
    LEFT JOIN user u
    ON u.no = a.user_no
    WHERE issue_no = ?;`;
    return pool.execute(sql, [issueNo]);
  },
  deleteIssueAssignee({ issueNo, assigneeNo }) {
    const sql = 'DELETE FROM assignee WHERE issue_no=? AND user_no=?;';
    return pool.execute(sql, [issueNo, assigneeNo]);
  },
};
