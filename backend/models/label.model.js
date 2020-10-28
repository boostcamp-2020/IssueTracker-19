import pool from '@lib/db';

// TODO : 테스트 필요

export const labelModel = {
  bulkAddIssueLabel({ labelNos, issueNo }) {
    const sql = labelNos.reduce(
      (acc, labelNo) =>
        acc +
        `INSERT INTO issue_label (label_no, issue_no) VALUES (${labelNo}, ${issueNo});`,
      '',
    );
    return pool.query(sql);
  },
};
