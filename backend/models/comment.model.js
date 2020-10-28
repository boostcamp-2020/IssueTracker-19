import pool from '@lib/db';

export const commentModel = {
  getComments() {
    const sql = `SELECT no, issue_no as issueNo, author_no as authorNo, content, is_head as isHead, 
    created_at as createdAt, updated_at as updatedAt 
    from comment ORDER BY issue_no;`;
    return pool.query(sql);
  },
};
