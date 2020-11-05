import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';
import { flexCenter } from '@styles/utils';

const HeaderBox = styled.header`
  width: 100%;
  height: 4rem;
  color: white;
  background-color: var(--black3, #333);
  ${flexCenter}
`;

export default function Header() {
  return (
    <HeaderBox>
      <Link to="/">Issue Tracker</Link>
    </HeaderBox>
  );
}
