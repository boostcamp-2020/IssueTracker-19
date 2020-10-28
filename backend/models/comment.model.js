import pool from '@lib/db';

export const commentModel = {
  getComments() {
    const sql = `SELECT c.no, c.issue_no as issueNo, u.nickname as author, c.content, c.is_head as isHead, 
    c.created_at as createdAt, c.updated_at as updatedAt 
    from comment c
    LEFT JOIN user u
    ON c.author_no = u.no
    ORDER BY issue_no;`;
    return pool.query(sql);
  },
};
