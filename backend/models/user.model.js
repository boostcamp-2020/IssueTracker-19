import pool from '@lib/db';

export const userModel = {
  getUserById({ id }) {
    const sql = 'SELECT * FROM user WHERE id=?;';
    return pool.execute(sql, [id]);
  },
};
