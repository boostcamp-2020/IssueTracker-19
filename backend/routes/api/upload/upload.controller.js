import formidable from 'formidable';

/**
 * POST /api/upload/images
 */

export const uploadImage = (req, res, next) => {
  try {
    const form = formidable({
      multiples: false, // file 여러개 옵션
      uploadDir: './public/imgs/',
      keepExtensions: true, // 확장자 표시
    });

    form.on('fileBegin', (name, file) => {
      const imgSrc = `${Date.now()}_${file.name}`;
      file.path = `${form.uploadDir}${imgSrc}`;
    });

    const port = req.app.get('port');
    const prefix = `${req.protocol}://${req.hostname}${port !== 80 ? `:${port}` : ''}`;
    form.parse(req, async (err, fields, files) => {
      if (err) {
        next(err);
      }
      const fileList = Object.values(files).reduce((acc, { path }) => {
        return acc.concat(prefix + path.match(/.imgs.*/i)[0]);
      }, []);
      res.json({ fileList });
    });
  } catch (err) {
    next(err);
  }
};
