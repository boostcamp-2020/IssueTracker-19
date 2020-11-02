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
    const sql = `SELECT user_no as userNo, issue_no as issueNo 
    FROM assignee 
    WHERE issue_no = ?;`;
    return pool.execute(sql, [issueNo]);
  },
};
