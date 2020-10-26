import React, { useContext, useState } from 'react';
import { useHistory } from 'react-router-dom';
import styled, { css } from 'styled-components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import IssueCommentItem from './IssueCommentItem/IssueCommentItem';
import { colors } from '@styles/variables';
import { flexColumn, flex } from '@styles/utils';
import { Line, SubmitButton as SB, CancelButton } from '@shared';
import { CommentInputBox, OpenIcon, ClosedIcon } from '@components';
import { issueService, commentService } from '@services';

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
  width: 40px;
  height: 40px;
  margin: 20px;
`;

const ImageItem = styled.img`
  width: 40px;
  height: 40px;
  object-fit: scale-down;
`;

const MyCommentBox = styled.div`
  ${flex()};
  margin-top: 1rem;
`;

const ControlBox = styled.div`
  ${flex('flex-end', 'center')}
  margin:0.5rem;
`;

const SubmitButton = styled(SB)`
  margin-left: 0.5rem;
  &:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
  &:disabled:hover {
    background-color: ${colors.submitColor};
  }
`;

export default function IssueCommentBox() {
  const { issue, user, fetchIssueDetails } = useContext(IssueDetailContext);
  const { comments, isOpened } = issue;
  const history = useHistory();

  const [content, setContent] = useState('');

  const openIssue = async () => {
    try {
      const { status } = await issueService.openIssue({ no: issue.no });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  const closeIssue = async () => {
    try {
      const { status } = await issueService.closeIssue({ no: issue.no });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  const handleIssueOpenClose = async e => {
    e.preventDefault();
    if (isOpened) {
      closeIssue();
      return;
    }
    openIssue();
    return;
  };

  const handleSubmit = async e => {
    e.preventDefault();
    try {
      const { status } = await commentService.addComment({ issueNo: issue.no, content });
      if (status === 201) {
        fetchIssueDetails();
        setContent('');
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

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
      <MyCommentBox>
        <ImageBox>
          <ImageItem src={user.image} />
        </ImageBox>
        <CommentInputBox
          handleSubmit={handleSubmit}
          content={content}
          setContent={setContent}
          controlBox={
            <ControlBox>
              <CancelButton type={'button'} onClick={handleIssueOpenClose}>
                {isOpened ? (
                  <>
                    <ClosedIcon />
                    Close issue
                  </>
                ) : (
                  <>
                    <OpenIcon />
                    Reopen issue
                  </>
                )}
              </CancelButton>
              <SubmitButton disabled={content === '' ? true : false}>Comment</SubmitButton>
            </ControlBox>
          }
        />
      </MyCommentBox>
      <Line />
    </MainContainer>
  );
}
