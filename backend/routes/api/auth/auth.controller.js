import passport from 'passport';

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
