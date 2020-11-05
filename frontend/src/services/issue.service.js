import { API } from '@api';

export const issueService = {
  getIssues(options) {
    return API.get('/api/issues', options);
  },
};
