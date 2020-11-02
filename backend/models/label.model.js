import pool from '@lib/db';

export const labelModel = {
  bulkAddIssueLabel({ labelNos, issueNo }) {
    const sql = labelNos.reduce(
      (acc, labelNo) =>
        acc + `INSERT INTO issue_label (label_no, issue_no) VALUES (${labelNo}, ${issueNo});`,
      '',
    );
    return pool.query(sql);
  },
  getLabels() {
    const sql = 'SELECT * FROM label;';
    return pool.query(sql);
  },
  getLabelByIssueNo({ issueNo }) {
    const sql = `SELECT label_no as labelNo, issue_no as issueNo 
    FROM issue_label 
    WHERE issue_no = ?;`;
    return pool.execute(sql, [issueNo]);
  },
  addLabel({ name, description, color }) {
    const sql = 'INSERT INTO label (name, description, color) VALUES (?, ?, ?);';
    return pool.execute(sql, [name, description, color]);
  },
  changeLabel({ name, description, color, no }) {
    const sql = 'UPDATE label SET name=?, description=?, color=? WHERE no=?;';
    return pool.execute(sql, [name, description, color, no]);
  },
  deleteLabel({ no }) {
    const sql = 'DELETE FROM label WHERE no=?';
    return pool.execute(sql, [no]);
  },
};
