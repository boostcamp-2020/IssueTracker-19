import pool from '@lib/db';

export const assigneeModel = {
  bulkAddassignee({ assigneeNos, issueNo }) {
    const assigneesLength = assigneeNos.length;
    const sql = assigneeNos.reduce(
      (acc, assigneeNo, idx) =>
        acc + `(${assigneeNo}, ${issueNo})${idx === assigneesLength - 1 ? ';' : ', '}`,
      'INSERT INTO assignee (user_no, issue_no) VALUES ',
    );
    console.log(sql);
    return pool.query(sql);
  },
  deleteIssueAssignee({ issueNo, assigneeNo }) {
    const sql = 'DELETE FROM assignee WHERE issue_no=? AND user_no=?;';
    return pool.execute(sql, [issueNo, assigneeNo]);
  },
};
