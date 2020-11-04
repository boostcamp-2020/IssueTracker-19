import { css } from 'styled-components';

export const flex = (justifyContent = 'center', alignItems = 'center') => css`
  display: flex;
  justify-content: ${justifyContent};
  align-items: ${alignItems};
`;
