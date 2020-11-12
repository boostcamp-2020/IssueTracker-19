import React, { useState, useEffect } from 'react';
import marked from 'marked';
import styled from 'styled-components';
import { IssueCommentInputBox } from '@components';
import { colors } from '@styles/variables';
import { darken } from 'polished';
import { flex, flexColumn, toTimeAgoString } from '@styles/utils';

const Box = styled.div`
  position: relative;
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
  border: 2px solid ${darken(0.05, colors.myCommentColor)};
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

export default function IssueCommentItem({ comment, user }) {
  const isMine = comment.authorNo === user.no;
  const commentColor = isMine ? colors.myCommentColor : colors.otherCommentColor;

  const [editMode, setEditMode] = useState(false);

  const handleEditClick = () => {
    setEditMode(true);
  };

  return (
    <Box color={commentColor}>
      {editMode ? (
        <IssueCommentInputBox
          setEditMode={setEditMode}
          commentNo={comment.no}
          content={comment.content}
        />
      ) : (
        <>
          <CommentItemHeader color={commentColor}>
            <HeaderDiv>
              <HeaderAuthor>{comment.author}</HeaderAuthor>
              <HeaderTime>{`commented ${toTimeAgoString(comment.updatedAt)}`}</HeaderTime>
            </HeaderDiv>

            <HeaderDiv>
              {isMine ? (
                <>
                  <HeaderOwner>Owner</HeaderOwner>
                  <HeaderEditButton type="button" onClick={handleEditClick}>
                    Edit
                  </HeaderEditButton>
                </>
              ) : null}
            </HeaderDiv>
          </CommentItemHeader>
          <CommentItemContent
            className="markdown-body"
            dangerouslySetInnerHTML={{ __html: marked(comment.content) }}
          />
        </>
      )}
    </Box>
  );
}
