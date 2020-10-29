import { commentModel } from '@models';

/**
 * POST /api/comments
 */
export const addComment = async (req, res, next) => {
  const { issueNo, content } = req.body;

  try {
    await commentModel.addComment({
      issueNo,
      userNo: req.user.id,
      content,
    });
    res.status(201).end();
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/comments/:commentNo
 */
export const changeComment = (req, res, next) => {
  const { no, commentNo } = req.params;
  const { content } = req.body;

  // TODO : 유저 수요의 코멘트인지 확인
  try {
    await commentModel.changeComment();
    res.status(200).end();
  } catch (err) {
    next(err);
  }
  
};

/**
 * DELETE /api/comments/:commentNo
 */
export const deleteComment = (req, res, next) => {
  const { no, commentNo } = req.params;

  // TODO : 유저 수요의 코멘트인지 확인
  // TODO : 로직 작성
  res.status(200).end();
};
