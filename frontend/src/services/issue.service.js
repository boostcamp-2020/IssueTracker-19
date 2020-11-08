import { API } from '@api';
import qs from 'qs';

export const issueService = {
  getIssues(options) {
    return API.get(`/api/issues?${qs.stringify(options)}`);
  },
};
