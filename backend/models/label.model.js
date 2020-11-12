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
    const sql = `SELECT label_no as labelNo, issue_no as issueNo, l.name, l.color, l.description
    FROM issue_label 
    LEFT JOIN label l
    ON l.no = issue_label.label_no
    WHERE issue_no = ?;`;
    return pool.execute(sql, [issueNo]);
  },
  addLabel({ name, description = null, color }) {
    const sql = 'INSERT INTO label (name, description, color) VALUES (?, ?, ?);';
    return pool.execute(sql, [name, description, color]);
  },
  changeLabel({ name, description = null, color, no }) {
    const sql = 'UPDATE label SET name=?, description=?, color=? WHERE no=?;';
    return pool.execute(sql, [name, description, color, no]);
  },
  deleteLabel({ no }) {
    const sql = 'DELETE FROM label WHERE no=?';
    return pool.execute(sql, [no]);
  },
};
