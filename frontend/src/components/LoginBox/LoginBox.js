import React from 'react';
import styled from 'styled-components';
import LocalBox from './LocalBox/LocalBox';
import OauthBox from './OauthBox/OauthBox';
import { flex, flexCenter } from '@styles/utils';

const LoginDiv = styled.div`
  height: 100%;
  ${flexCenter}
  flex-direction: column;
  flex: 1;
  background-color: var(--lighter-gray-bg);
`;

const LoginMethodBox = styled.div`
  ${flex()}
  flex-direction: column;
  padding: 2rem;
  background-color: white;
  border: 1px solid lightgrey;
  border-radius: 0.5em;
`;

export default function LoginBox() {
  return (
    <LoginDiv>
      <LoginMethodBox>
        <LocalBox />
        <OauthBox />
      </LoginMethodBox>
    </LoginDiv>
  );
}
