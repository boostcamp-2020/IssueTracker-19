import React from 'react';
import styled from 'styled-components';

const GithubButton = styled.button`
  width: 100%;
  padding: 1rem;
  border: 1px solid black;
  display: block;
  margin-top: 1em;
  color: white;
  background-color: black;
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
`;

export default function OauthBox() {
  return (
    <a href="/api/auth/github">
      <GithubButton>Sign in with GitHub</GithubButton>
    </a>
  );
}
