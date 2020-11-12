import { API } from '@api';

export const userService = {
  login({ id, pw }) {
    return API.post('/api/auth/login', { id, pw });
  },
  logout() {
    return API.post('/api/auth/logout');
  },
  signup({ id, nickname, pw, auth }) {
    return API.post('/api/auth/signup', { id, nickname, pw, auth });
  },
  getUsers({ cancelToken } = {}) {
    return API.get('/api/users', {}, cancelToken);
  },
  checkLogin({ cancelToken } = {}) {
    return API.get('/api/auth/check', {}, cancelToken);
  },
};
