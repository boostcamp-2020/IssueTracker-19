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
  addComment({ issueNo, userNo, content, isHead = '0' }) {
    const sql = `INSERT INTO comment (issue_no, author_no, content, is_head) VALUES (?, ?, ?, ?)`;
    return pool.execute(sql, [issueNo, userNo, content, isHead]);
  },
  changeComment({ no, content }) {
    const sql = `UPDATE comment SET content=? WHERE no=?`;
    return pool.execute(sql, [content, no]);
  },
  deleteComment({ no }) {
    const sql = `DELETE FROM comment WHERE no=?`;
    return pool.execute(sql, [no]);
  },
  getCommentAuthor({ no }) {
    const sql = `SELECT author_no as authorNo FROM comment WHERE no=?`;
    return pool.execute(sql, [no]);
  },
};
