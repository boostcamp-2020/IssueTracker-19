import { API } from '@api';
import qs from 'qs';

export const issueService = {
  getIssues(options) {
    return API.get(`/api/issues?${qs.stringify(options)}`);
  },
  openIssues({ issueNos }) {
    return API.patch('/api/issues/open', { issueNos });
  },
  closeIssues({ issueNos }) {
    return API.patch('/api/issues/close', { issueNos });
  },
  addIssue({ title, content, assigneeNos, milestoneNo, labelNos }) {
    return API.post('/api/issues', { title, content, assigneeNos, milestoneNo, labelNos });
  },
};
