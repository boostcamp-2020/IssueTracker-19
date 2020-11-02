import pool from '@lib/db';

export const issueLabelModel = {
  addIssueLabel({ issueNo, labelNo }) {
    const sql = `INSERT INTO issue_label (label_no, issue_no) VALUES (?, ?);`;
    return pool.execute(sql, [labelNo, issueNo]);
  },
  deleteIssueLabel({ issueNo, labelNo }) {
    const sql = `DELETE FROM issue_label WHERE label_no=? AND issue_no=?;`;
    return pool.execute(sql, [labelNo, issueNo]);
  },
};
