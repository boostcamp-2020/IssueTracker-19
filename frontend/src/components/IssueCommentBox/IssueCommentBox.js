import React, { useContext } from 'react';
import styled from 'styled-components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import IssueCommentItem from './IssueCommentItem/IssueCommentItem';
import { colors } from '@styles/variables';
import { flexColumn, flex } from '@styles/utils';

const MainContainer = styled.div`
  width: calc(70% - 10rem);
  margin-left: 10rem;
  ${flexColumn}
`;

const CommentBox = styled.div`
  ${flex()}
  margin: 1.5rem 0;
`;

const ImageBox = styled.div`
  margin: 20px;
  width: 40px;
  height: 40px;
`;

const ImageItem = styled.img`
  width: 100%;
  object-fit: scale-down;
`;

export default function IssueCommentBox() {
  const {
    issue: { comments },
    user,
  } = useContext(IssueDetailContext);

  return (
    <MainContainer>
      {comments?.map(comment => (
        <CommentBox key={comment.no}>
          <ImageBox>
            <ImageItem src={comment.image} />
          </ImageBox>
          <IssueCommentItem comment={comment} user={user} />
        </CommentBox>
      ))}
    </MainContainer>
  );
}
