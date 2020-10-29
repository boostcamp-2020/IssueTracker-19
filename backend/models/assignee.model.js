import pool from '@lib/db';

export const assigneeModel = {
  bulkAddassignee({ assigneeNos, issueNo }) {
    const sql = assigneeNos.reduce(
      (acc, assigneeNo) =>
        acc +
        `INSERT INTO assignee (user_no, issue_no) VALUES (${assigneeNo}, ${issueNo});`,
      '',
    );
    return pool.query(sql);
  },
};
