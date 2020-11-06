import { API } from '@api';

export const labelService = {
  getLabels() {
    return API.get('/api/labels');
  },
};
