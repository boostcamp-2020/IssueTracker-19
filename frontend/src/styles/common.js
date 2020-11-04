const { css, createGlobalStyle } = require('styled-components');

export const GlobalStyle = createGlobalStyle`
  body {
    --black1 : #111;
    --black2 : #222;
    --black3 : #333;
    --black4 : #444;
    --black5 : #555;
    --black6 : #666;

    --light-gray: #d0d0d0;
    --lighter-gray: #e0e0e0;
    --lightest-gray: #f0f0f0;

    --lighter-gray-bg: #eee;
  }
`;
