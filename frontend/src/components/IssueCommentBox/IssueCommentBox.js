import React, { useContext } from 'react';
import styled from 'styled-components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import IssueCommentItem from './IssueCommentItem/IssueCommentItem';
import { colors } from '@styles/variables';
import { flexColumn } from '@styles/utils';

const MainContainer = styled.div`
  width: calc(70% - 10rem);
  margin-left: 10rem;
  ${flexColumn}
`;

const CommentBox = styled.div``;

const ImageItem = styled.img`
  width: 30px;
`;

export default function IssueCommentBox() {
  const {
    issue: { comments },
  } = useContext(IssueDetailContext);

  return (
    <MainContainer>
      {comments?.map((comment, idx) => (
        <CommentBox key={idx}>
          <ImageItem src={comment.image} />
          <IssueCommentItem />
        </CommentBox>
      ))}
    </MainContainer>
  );
}
