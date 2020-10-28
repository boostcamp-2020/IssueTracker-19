import pool from '@lib/db';
import { AUTH } from '@lib/constants';

// TODO : 테스트 필요

export const milestoneModel = {
  getMilestoneList() {
    // const sql = 'SELECT * FROM milestone;';
    // return pool.execute(sql);
  },
  getMilestone({ no }) {
    // const sql = 'SELECT * FROM milestone where no=?;';
    // return pool.execute(sql, [no]);
  },
  addMilestone({ title, description, dueDate }) {
    const sql =
      'INSERT INTO milestone (title, due_date, description) VALUES (?, ?, ?);';
    return pool.execute(sql, [title, description, dueDate]);
  },
  changeMilestone({ title, description, dueDate, no }) {
    const sql =
      'UPDATE milestone SET title=?, due_date=?, description=? WHERE no=?;';
    return pool.execute(sql, [title, description, dueDate, no]);
  },
  deleteMilestone({ no }) {
    const sql = 'DELETE FROM milestone WHERE no=?;';
    return pool.execute(sql, [no]);
  },
  openMilestone() {},
  closeMilestone() {},
};
