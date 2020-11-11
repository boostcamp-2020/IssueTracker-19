import { API } from '@api';

export const uploadService = {
  addImage(formData) {
    return API.post('/api/upload/images', formData);
  },
};
