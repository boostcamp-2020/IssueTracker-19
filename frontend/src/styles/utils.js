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
