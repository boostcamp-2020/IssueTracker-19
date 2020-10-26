import passport from 'passport';
import { Strategy as LocalStrategy } from 'passport-local';
import { Strategy as GitHubStrategy } from 'passport-github2';
import config from '@config';
import bcrypt from 'bcrypt';

export default () => {
  const {
    clientID,
    clientSecret,
    callbackURL,
    devClientID,
    devClientSecret,
    devCallbackURL,
  } = config.oauth.github;
  passport.use(
    new LocalStrategy(
      {
        usernameField: 'id',
        passwordField: 'pw',
      },
      (id, pw, done) => {
        /*  TODO
          ID, PW 검증 로직 작성 후 성공하면 done(null, user); 호출
          실패하면 done(err); 호출
        */
      },
    ),
  );

  passport.use(
    new GitHubStrategy(
      {
        clientID: process.env.MODE === 'dev' ? devClientID : clientID,
        clientSecret:
          process.env.MODE === 'dev' ? devClientSecret : clientSecret,
        callbackURL: process.env.MODE === 'dev' ? devCallbackURL : callbackURL,
      },
      async (accessToken, refreshToken, profile, done) => {
        /**
         * TODO
         * db에서 해당 id 조회 후 없으면 insert, 있으면 해당 아이디로 로그인 처리
         * 성공하면 done(null, 전달할 값); 호출
         * 실패하면 done(err); 호출
         */
      },
    ),
  );
};
