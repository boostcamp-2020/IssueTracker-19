import 'module-alias/register';
import '@lib/env';
import createError from 'http-errors';
import express from 'express';
import path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import passport from 'passport';
import cors from 'cors';
import session from 'express-session';
import config from '@config';

import apiRouter from './routes/api/index';
import passportConfig from './lib/passport';

const app = express();
const port = process.env.PORT || 3000;

app.use(cors({ origin: 'http://localhost:8080', credentials: true }));
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, '../frontend/dist')));
app.use(session(config.session));
app.use((req, res, next) => {
  res.locals.session = req.session;
  next();
});
app.use(passport.initialize());
app.use(passport.session());
passportConfig();

app.use('/api', apiRouter);
app.all('*', (req, res) => {
  if (process.env.MODE === 'dev') {
    res.redirect(process.env.DEV_URL);
    return;
  }
  res.sendFile(path.join(__dirname, '../frontend/dist/index.html'));
});

app.use((req, res, next) => {
  next(createError(404));
});

app.use((err, req, res, next) => {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  console.error(err.message);

  res.status(err.status || 500);
  res.json({ message: err.message });
});

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});

export default app;
