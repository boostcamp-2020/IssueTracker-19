import React from 'react';
import styled from 'styled-components';

const AuthButton = styled.button`
  width: 100%;
  padding: 1rem;
  background-color: ${props => props.bgcolor};
  color: ${props => props.color};
  font-size: inherit;
  border: 1px solid black;
  display: block;
  cursor: pointer;
  margin-top: 1em;
`;

export function LoginOauth() {
  return (
    <div>
      <a href="/api/auth/github">
        <AuthButton color="white" bgcolor="black">
          Sign in with GitHub
        </AuthButton>
      </a>
      <a href="/api/auth/github">
        <AuthButton style={{ color: 'black', 'background-color': 'white' }}>
          Sign in with Apple
        </AuthButton>
      </a>
    </div>
  );
}
