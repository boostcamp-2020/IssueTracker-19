import { API } from '@api';

export const uploadService = {
  addImage(formdata) {
    return API.post('/api/uploads/image', formdata);
  },
};
