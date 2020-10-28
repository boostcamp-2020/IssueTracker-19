import passport from 'passport';

export const login = passport.authenticate('github');

export const handleAuth = passport.authenticate('github', {
  failureRedirect: '/api/github/failure',
});

export const success = (req, res, next) => {
  res.redirect('/');
};

export const failure = (req, res, next) => {
  // TODO : failed 페이지로 리다이렉트
  res.send('failed');
  // res.status(401).json({ message: 'github auth failed' });
};
