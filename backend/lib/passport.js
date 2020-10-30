import passport from 'passport';
import { Strategy as LocalStrategy } from 'passport-local';
import { Strategy as GitHubStrategy } from 'passport-github2';
import { userModel } from '@models';
import { AUTH } from '@lib/constants';
import config from '@config';
import bcrypt from 'bcrypt';

export default () => {
  passport.serializeUser((user, done) => {
    // 로그인 성공시 1번 호출되어 사용자의 식별자를 세션저장소에 저장, 두 번째 매개변수는 추후 req.user로 접근 가능
    const { nickname, id, no } = user;
    done(null, { nickname, id, no });
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
        clientSecret: process.env.MODE === 'dev' ? devClientSecret : clientSecret,
        callbackURL: process.env.MODE === 'dev' ? devCallbackURL : callbackURL,
      },
      async (accessToken, refreshToken, profile, done) => {
        const { username: nickname, id } = profile;
        const [[user]] = await userModel.getUserById({ id });
        if (user) {
          done(null, user);
          return;
        }
        await userModel.addUser({ id, nickname, auth: AUTH.GITHUB });
        done(null, user);
      },
    ),
  );
};
