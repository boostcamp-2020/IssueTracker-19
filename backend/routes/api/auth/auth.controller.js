import passport from 'passport';
import { verify } from '@lib/utils';
import { errorMessage } from '@lib/constants';
import { userModel } from '@models';
import bcrypt from 'bcrypt';

/* 
	POST /api/auth/login
*/
export const login = async (req, res, next) => {
  passport.authenticate('local', (err, user, info) => {
    if (err) {
      next(err);
      return;
    }
    if (!user) {
      res.status(401).json({ message: '아이디 또는 비밀번호를 확인하세요.' });
      return;
    }
    req.logIn(user, err => {
      if (err) {
        next(err);
        return;
      }
      res.json({ id: user.id });
    });
  })(req, res, next);
};

/*
	POST /api/auth/logout
*/
export const logout = async (req, res) => {
  req.logout();
  req.session.save(() => {
    res.status(200).end();
  });
};

/*
	POST /api/auth/signup
*/
export const signup = async (req, res, next) => {
  try {
    const { id, nickname, pw, auth } = req.body;
    if (verify([id, nickname, pw, auth])) {
      const hashPw = await bcrypt.hash(pw, 10);
      await userModel.addUser({ id, nickname, pw: hashPw, auth });
      res.status(200).end();
      return;
    }
    res.status(400).json({ message: errorMessage.MISSING_REQUIRED_VALUE });
  } catch (err) {
    next(err);
  }
  // TODO signup 구현
};
