import axios from 'axios';

const jsonHeader = { 'Content-Type': 'application/json;charset=utf-8' };
const instance = axios.create();

instance.interceptors.request.use(
  config => {
    return config;
  },
  err => {
    return Promise.reject(err);
  },
);

instance.interceptors.response.use(
  res => {
    if (res.status >= 400) {
      console.error('api 요청 실패', res.message);
    }
    return res;
  },
  err => {
    if (axios.isCancel(err)) {
      console.log('요청 취소', err);
    } else {
      console.error('api 에러', err);
    }
    return Promise.reject(err);
  },
);

export const apiClient = {
  get(url, headers, cancelToken) {
    return instance({
      url,
      method: 'GET',
      headers: { ...headers },
      cancelToken,
    });
  },
  post(url, data, headers, cancelToken) {
    return instance({
      url,
      method: 'POST',
      headers: { ...headers, ...jsonHeader },
      cancelToken,
      data,
    });
  },
  put(url, data, headers, cancelToken) {
    return instance({
      url,
      method: 'PUT',
      headers: { ...headers, ...jsonHeader },
      cancelToken,
      data,
    });
  },
  patch(url, data, headers, cancelToken) {
    return instance({
      url,
      method: 'PATCH',
      headers: { ...headers, ...jsonHeader },
      cancelToken,
      data,
    });
  },
  delete(url, headers, cancelToken) {
    return instance({
      url,
      method: 'DELETE',
      headers: { ...headers },
      cancelToken,
    });
  },
};
