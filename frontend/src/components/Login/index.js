import React from 'react';
import styled from 'styled-components';
import { LoginLocal } from '@components/LoginLocal';
import { LoginOauth } from '@components/LoginOauth';

const LoginDiv = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #eee;
  height: 100vh;
`;

const LoginBox = styled.div`
  display: flex;
  flex-direction: column;
  background-color: white;
  padding: 2rem;
  border: 1px solid lightgrey;
  border-radius: 0.5em;
`;

export function Login() {
  return (
    <LoginDiv>
      <h1 style={{ 'font-size': '3em', margin: '1rem 0' }}>이슈 트래커</h1>
      <LoginBox>
        <LoginLocal />
        <LoginOauth />
      </LoginBox>
    </LoginDiv>
  );
}
