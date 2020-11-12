import { API } from '@api';

export const commentService = {
  addComment({ issueNo, content }) {
    return API.post('/api/comments', { issueNo, content });
  },
  updateComment({ no, content }) {
    return API.patch(`/api/comments/${no}`, { content });
  },
};
