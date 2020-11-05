import { API } from '@api';

export const issueService = {
  getIssues() {
    return API.get('/api/issues');
  },
};
