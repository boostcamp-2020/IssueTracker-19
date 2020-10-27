export const changeTitle = (req, res, next) => {
  const { no } = req.params;

  // TODO : title 변경 로직 구현

  res.status(200).end();
};
