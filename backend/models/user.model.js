import pool from '@lib/db';
import { AUTH } from '@lib/constants';

export const userModel = {
  getUserById({ id }) {
    const sql = 'SELECT * FROM user WHERE id=?;';
    return pool.execute(sql, [id]);
  },
  addUser({ id, nickname, pw = null, auth }) {
    const sql = 'INSERT INTO user (id, nickname, pw, auth) VALUES (?, ?, ?, ?);';
    return pool.execute(sql, [id, nickname, pw, auth ? auth : AUTH.DEFAULT]);
  },
};
