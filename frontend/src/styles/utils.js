import { css } from 'styled-components';

export const flex = (justifyContent = 'flex-start', alignItems = 'stretch') => css`
  display: flex;
  justify-content: ${justifyContent};
  align-items: ${alignItems};
`;

export const flexCenter = css`
  display: flex;
  justify-content: center;
  align-items: center;
`;

export const flexColumn = css`
  display: flex;
  flex-direction: column;
`;

export const borderNoneBox = css`
  border: none;
  box-sizing: border-box;
`;

export const skyblueBoxShadow = css`
  box-shadow: 0 0 0 3px #b3d1f3;
`;

// 배경색에 따라서 글자색을 검은색 혹은 흰색을 결정
export const calcFontColor = backgroundColor => {
  const d = document.createElement('div');
  d.style.color = backgroundColor;

  // Invalid value
  if (d.style.color === '') return 'black';

  const [R, G, B] = d.style.color.match(/\d+/g).map(color => parseInt(color));

  // https://stackoverflow.com/a/36888120
  const luma = (0.299 * R + 0.587 * G + 0.114 * B) / 255;
  return luma > 0.5 ? 'black' : 'white';
};
