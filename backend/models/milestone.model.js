import pool from '@lib/db';
import { AUTH } from '@lib/constants';

// TODO : 테스트 필요

export const milestoneModel = {
  getMilestoneList() {
    const sql =
      `select T.no, T.is_closed as isClosed, T.is_deleted, T.due_date, T.description,
      (SELECT count(*) FROM issue where is_opened=0 and milestone_no=T.no) as closedTasks, 
      (SELECT count(*) FROM issue where milestone_no=T.no) as totalTasks 
      from milestone as T 
      left outer join issue as I 
      on T.no=I.milestone_no 
      group by T.no;`;
    return pool.query(sql);
  },
  getMilestone({ no }) {
    const sql =
      `select T.no, T.is_closed, T.is_deleted, T.due_date, T.description, 
      (SELECT count(*) FROM issue WHERE milestone_no = ? AND is_opened=0 ) as closedTasks,
      (SELECT count(*) FROM issue WHERE milestone_no = ?) as totalTasks 
      from milestone as T 
      left outer join issue as I 
      on T.no=I.milestone_no 
      group by T.no 
      having T.no=?;`;
    return pool.execute(sql, [no, no, no]);
  },
  addMilestone({ title, description, dueDate }) {
    const sql =
      'INSERT INTO milestone (title, description, due_date ) VALUES (?, ?, ?);';
    return pool.execute(sql, [title, description, dueDate]);
  },
  changeMilestone({ title, description, dueDate, no }) {
    const sql =
      'UPDATE milestone SET title=?, description=?, due_date=? WHERE no=?;';
    return pool.execute(sql, [title, description, dueDate, no]);
  },
  deleteMilestone({ no }) {
    const sql = 'UPDATE milestone SET is_deleted=1 WHERE no=?;';
    return pool.execute(sql, [no]);
  },
  openMilestone({ no }) {
    const sql = 'UPDATE milestone SET is_closed=0 WHERE no=?'
    return pool.execute(sql, [no]);
  },
  closeMilestone({ no }) {
    const sql = 'UPDATE milestone SET is_closed=1 WHERE no=?'
    return pool.execute(sql, [no]);
  },
};
