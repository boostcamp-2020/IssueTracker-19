import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';
import { flexCenter } from '@styles/utils';
import { colors } from '@styles/variables';

const HeaderBox = styled.header`
  width: 100%;
  height: 4rem;
  color: white;
  background-color: ${colors.black3};
  ${flexCenter}
  flex-shrink:0;
`;

export default function Header() {
  return (
    <HeaderBox>
      <Link to="/">Issue Tracker</Link>
    </HeaderBox>
  );
}
