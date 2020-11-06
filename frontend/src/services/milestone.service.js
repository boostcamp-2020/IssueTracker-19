import { API } from '@api';

export const milestoneService = {
  getMilestones() {
    return API.get('/api/milestones');
  },
};
