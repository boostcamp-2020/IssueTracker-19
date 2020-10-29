import pool from '@lib/db';
import { AUTH } from '@lib/constants';

export const userModel = {
  getUserById({ id }) {
    const sql = 'SELECT * FROM user WHERE id=?;';
    return pool.execute(sql, [id]);
  },
  addUser({ id, nickname, auth }) {
    const sql = 'INSERT INTO user (id, nickname, auth) VALUES (?, ?, ?);';
    return pool.execute(sql, [id, nickname, auth ? auth : AUTH.DEFAULT]);
  },
};
