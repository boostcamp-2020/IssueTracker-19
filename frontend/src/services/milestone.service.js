import { API } from '@api';

export const milestoneService = {
  getMilestones({ cancelToken } = {}) {
    return API.get('/api/milestones', {}, cancelToken);
  },
  closeMilestones(no) {
    return API.patch(`/api/milestones/${no}/close`);
  },
  openMilestones(no) {
    return API.patch(`/api/milestones/${no}/open`);
  },
  deleteMilestones(no) {
    return API.delete(`/api/milestones/${no}`);
  },
  addMilestones({ title, dueDate, description }) {
    return API.post('/api/milestones', { title, dueDate, description });
  },
  editMilestones({ no, title, dueDate, description }) {
    return API.put(`/api/milestones/${no}`, { title, description, dueDate });
  },
};
