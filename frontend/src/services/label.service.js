import { API } from '@api';

export const labelService = {
  getLabels() {
    return API.get('/api/labels');
  },

  addLabel({ name, description, color }) {
    return API.post('/api/labels', { name, description, color });
  },

  editLabel({ no, name, description, color }) {
    return API.put(`/api/labels/${no}`, { name, description, color });
  },
};
