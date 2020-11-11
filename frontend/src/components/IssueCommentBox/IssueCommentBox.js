import React, { useContext } from 'react';
import styled from 'styled-components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import { colors } from '@styles/variables';
import { flexColumn } from '@styles/utils';

const MainContainer = styled.div`
  width: calc(70% - 10rem);
  margin-left: 10rem;
  ${flexColumn}
`;

const CommentBox = styled.div``;

const imageItem = styled.img``;

export default function IssueCommentBox() {
  useContext(IssueDetailContext);

  return <MainContainer></MainContainer>;
}
