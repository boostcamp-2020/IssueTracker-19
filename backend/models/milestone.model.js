import pool from '@lib/db';

export const milestoneModel = {
  getMilestoneList() {
    const sql = `SELECT M.no, M.title, M.is_closed AS isClosed, M.is_deleted AS isDeleted, M.due_date AS dueDate, M.description,
      (SELECT COUNT(*) FROM issue WHERE is_opened=0 AND milestone_no=M.no) AS closedTasks, 
      (SELECT COUNT(*) FROM issue WHERE milestone_no=M.no) AS totalTasks 
      FROM milestone AS M 
      LEFT OUTER JOIN issue AS I 
      ON M.no=I.milestone_no 
      GROUP BY M.no;`;
    return pool.query(sql);
  },
  getMilestoneDetail({ no }) {
    const sql = `SELECT M.no, M.title, M.is_closed AS isClosed, M.is_deleted AS isDeleted, M.due_date AS dueDate, M.description, 
      (SELECT COUNT(*) FROM issue WHERE milestone_no = ? AND is_opened=0 ) AS closedTasks,
      (SELECT COUNT(*) FROM issue WHERE milestone_no = ?) AS totalTasks 
      FROM milestone AS M 
      LEFT OUTER JOIN issue AS I 
      ON M.no=I.milestone_no 
      GROUP BY M.no 
      HAVING M.no=?;`;
    return pool.execute(sql, [no, no, no]);
  },
  addMilestone({ title, description, dueDate }) {
    const sql = 'INSERT INTO milestone (title, description, due_date) VALUES (?, ?, ?);';
    return pool.execute(sql, [title, description, dueDate]);
  },
  changeMilestone({ title, description, dueDate, no }) {
    const sql = 'UPDATE milestone SET title=?, description=?, due_date=? WHERE no=?;';
    return pool.execute(sql, [title, description, dueDate, no]);
  },
  deleteMilestone({ no }) {
    const sql = 'UPDATE milestone SET is_deleted=1 WHERE no=?;';
    return pool.execute(sql, [no]);
  },
  openMilestone({ no }) {
    const sql = 'UPDATE milestone SET is_closed=0 WHERE no=?;';
    return pool.execute(sql, [no]);
  },
  closeMilestone({ no }) {
    const sql = 'UPDATE milestone SET is_closed=1 WHERE no=?;';
    return pool.execute(sql, [no]);
  },
};
