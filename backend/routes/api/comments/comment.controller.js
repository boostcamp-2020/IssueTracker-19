import { commentModel } from '@models';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';

// 유저 소유의 코멘트인지 확인하는 함수
const isCommentOwner = async (userNo, commentNo) => {
  const [row] = await commentModel.getCommentAuthor({
    no: commentNo,
  });
  if (userNo === row[0].authorNo) return true;
  return false;
};

/**
 * POST /api/comments
 */
export const addComment = async (req, res, next) => {
  try {
    const { issueNo, content } = req.body;

    if (verify([issueNo, content])) {
      await commentModel.addComment({
        issueNo,
        userNo: req.user.no,
        content,
      });
      res.status(201).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/comments/:no
 */
export const changeComment = async (req, res, next) => {
  const { no } = req.params;
  const { content } = req.body;

  try {
    // 유저 소유의 코멘트인지 확인
    if (!(await isCommentOwner(req.user.no, no))) {
      res.status(403).end();
      return;
    }
    if (verify([content])) {
      // 실제 코멘트 변경
      await commentModel.changeComment({ no, content });
      res.status(200).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/comments/:no
 */
export const deleteComment = async (req, res, next) => {
  const { no } = req.params;

  try {
    // 유저 소유의 코멘트인지 확인
    if (!(await isCommentOwner(req.user.no, no))) {
      res.status(403).end();
      return;
    }

    // 실제 코멘트 삭제
    await commentModel.deleteComment({ no });
    res.status(200).end();
  } catch (err) {
    next(err);
  }
};
