import { API } from '@api';

export const milestoneService = {
  getMilestones() {
    return API.get('/api/milestones');
  },
  closeMilestones(no) {
    return API.patch(`/api/milestones/${no}/close`);
  },
};
