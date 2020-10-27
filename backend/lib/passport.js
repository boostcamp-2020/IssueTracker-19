import passport from 'passport';
import { Strategy as LocalStrategy } from 'passport-local';
import { Strategy as GitHubStrategy } from 'passport-github2';
import { userModel } from '@models';
import config from '@config';
import bcrypt from 'bcrypt';

export default () => {
  passport.serializeUser((user, done) => {
    // 로그인 성공시 1번 호출되어 사용자의 식별자를 세션저장소에 저장, 두 번째 매개변수는 추후 req.user로 접근 가능
    done(null, user.id);
  });

  passport.deserializeUser((user, done) => {
    // 세션에 저장된 데이터를 기준으로 필요한 정보를 조회할 때 사용
    done(null, user);
  });

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
      async (id, pw, done) => {
        const [[user]] = await userModel.getUserById({ id });
        if (user) {
          try {
            const match = await bcrypt.compare(pw, user.pw);
            if (match) {
              done(null, user);
              return;
            }
          } catch (err) {
            done(err);
          }
        }
        done(null, false, {
          message: '아이디 또는 비밀번호가 일치하지 않습니다.',
        });
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
