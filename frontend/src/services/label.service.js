import { API } from '@api';

export const labelService = {
  getLabels({ cancelToken } = {}) {
    return API.get('/api/labels', {}, cancelToken);
  },

  addLabel({ name, description, color }) {
    return API.post('/api/labels', { name, description, color });
  },

  editLabel({ no, name, description, color }) {
    return API.put(`/api/labels/${no}`, { name, description, color });
  },

  deleteLabel({ no }) {
    return API.delete(`/api/labels/${no}`);
  },
};
