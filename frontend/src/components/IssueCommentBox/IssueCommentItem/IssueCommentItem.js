import React, { useState, useEffect } from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { darken } from 'polished';
import { flex, flexColumn } from '@styles/utils';

const myCommentColor = '#eef6ff';
const otherCommentColor = '#f7f7f7';

const Box = styled.div`
  ${flexColumn}
  width: 100%;
  border: 2px solid ${props => darken(0.1, props.color)};
`;

const CommentItemHeader = styled.div`
  ${flex()}
  justify-content: space-between;
  padding: 0.5rem 1rem;
  border-bottom: 2px solid ${props => darken(0.1, props.color)};
  background-color: ${props => props.color};
`;

const HeaderDiv = styled.div`
  ${flex()}
`;

const HeaderAuthor = styled.span`
  margin-right: 0.5rem;
  font-weight: bold;
`;

const HeaderTime = styled.span`
  color: ${colors.black5};
`;

const HeaderOwner = styled.span`
  margin-right: 0.5rem;
  padding: 0.125rem;
  font-size: 0.875rem;
  color: ${colors.black5};
  font-weight: bold;
  border: 2px solid ${darken(0.05, myCommentColor)};
  border-radius: 5px;
`;

const HeaderEditButton = styled.button`
  border: none;
  color: ${colors.black5};
  font-weight: bold;
  background-color: inherit;
  cursor: pointer;
`;

const CommentItemContent = styled.p`
  padding: 1rem;
  white-space: pre-wrap;
`;

const calcTimePassed = updatedAt => {
  return '22 mins ago';
};

export default function IssueCommentItem({ comment, user }) {
  const isMine = comment.authorNo === user.no;
  const commentColor = isMine ? myCommentColor : otherCommentColor;

  return (
    <Box color={commentColor}>
      <CommentItemHeader color={commentColor}>
        <HeaderDiv>
          <HeaderAuthor>{comment.author}</HeaderAuthor>
          <HeaderTime>{`commented ${calcTimePassed(comment.updatedAt)}`}</HeaderTime>
        </HeaderDiv>

        <HeaderDiv>
          {isMine ? (
            <>
              <HeaderOwner>Owner</HeaderOwner>
              <HeaderEditButton>Edit</HeaderEditButton>
            </>
          ) : null}
        </HeaderDiv>
      </CommentItemHeader>
      <CommentItemContent>{comment.content}</CommentItemContent>
    </Box>
  );
}
