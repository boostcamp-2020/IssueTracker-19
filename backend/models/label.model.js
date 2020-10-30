import pool from '@lib/db';

// TODO : 테스트 필요

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
