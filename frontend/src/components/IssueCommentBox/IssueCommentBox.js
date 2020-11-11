import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flexColumn } from '@styles/utils';

const MainContainer = styled.div`
  width: calc(70% - 10rem);
  margin-left: 10rem;
  ${flexColumn}
`;

export default function IssueCommentBox() {
  return <MainContainer>123</MainContainer>;
}
