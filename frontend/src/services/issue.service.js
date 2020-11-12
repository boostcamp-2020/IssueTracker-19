import { API } from '@api';
import qs from 'qs';

export const issueService = {
  getIssues(options, { cancelToken } = {}) {
    return API.get(`/api/issues?${qs.stringify(options)}`, {}, cancelToken);
  },
  getIssue({ issueNo }) {
    return API.get(`/api/issues/${issueNo}`);
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
  addIssuesAssignee({ no, assigneeNos, cancelToken }) {
    return API.post(`/api/issues/${no}/assignees`, { assigneeNos }, {}, cancelToken);
  },
  addIssuesLabel({ no, labelNos, cancelToken }) {
    return API.post(`/api/issues/${no}/labels`, { labelNos }, {}, cancelToken);
  },
  addIssuesMilestone({ no, milestoneNo, cancelToken }) {
    return API.patch(`/api/issues/${no}/milestone`, { milestoneNo }, {}, cancelToken);
  },
  removeIssuesAssignee({ no, assigneeNo, cancelToken }) {
    return API.delete(`/api/issues/${no}/assignees/${assigneeNo}`, {}, cancelToken);
  },
  removeIssuesLabel({ no, labelNo, cancelToken }) {
    return API.delete(`/api/issues/${no}/labels/${labelNo}`, {}, cancelToken);
  },
  changeIssueTitle({ no, title }) {
    return API.patch(`/api/issues/${no}/title	`, { title });
  },
  openIssue({ no }) {
    return API.patch(`/api/issues/${no}/open`);
  },
  closeIssue({ no }) {
    return API.patch(`/api/issues/${no}/close`);
  },
};
