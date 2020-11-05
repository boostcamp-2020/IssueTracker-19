import { API } from '@api';

export const userService = {
  login({ id, pw }) {
    return API.post('/api/auth/login', { id, pw });
  },
};
