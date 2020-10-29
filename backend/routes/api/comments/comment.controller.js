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
export const changeComment = async (req, res, next) => {
  const { no } = req.params;
  const { content } = req.body;

  try {
    // 유저 소유의 코멘트인지 확인
    const { authorNo } = await commentModel.getCommentAuthor({ no });
    if (req.user.id !== authorNo) throw new Error('This guy is cheating!!!');

    // 실제 코멘트 변경
    await commentModel.changeComment({ no, content });
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
