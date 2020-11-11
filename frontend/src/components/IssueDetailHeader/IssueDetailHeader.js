import React, { useContext, useState } from 'react';
import styled, { css } from 'styled-components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import { flexColumn, flex } from '@styles/utils';
import { numerics, colors } from '@styles/variables';
import { LabelTag, OpenIcon, ClosedIcon } from '@components';
import { SubmitButton, CancelButton } from '@shared';
import { Link } from 'react-router-dom';
import IssueTitleEditBox from './IssueTitleEditBox/IssueTitleEditBox';

const MainContainer = styled.div`
  ${css`
    width: ${css`calc(100% - ${numerics.marginHorizontal} * 2)`};
  `}
  margin: ${numerics.marginHorizontal};
  margin-bottom: 0;
`;

const Line = styled.div`
  height: 0.5px;
  width: 100%;
  margin-top: 1rem;
  background-color: ${colors.lighterGray};
`;

const TitleContainer = styled.div`
  width: calc(100% - 15rem);
  margin-left: 10rem;
  margin-right: 5rem;
  ${flexColumn}
`;

const IconContainer = styled.div`
  ${flex('flex-start', 'center')}
`;

const Title = styled.div`
  font-size: 2rem;
  ${flex('space-between', 'center')}
`;

const Controls = styled.div`
  ${flex()}
`;

const EditButton = styled(CancelButton)`
  font-size: 0.9rem;
  margin-right: 0.5rem;
  height: 2rem;
  padding: 0 0.9rem;
`;
const NewIssueButton = styled(SubmitButton)`
  font-size: 0.9rem;
  height: 2rem;
  padding: 0 0.9rem;
`;

const IssueNoText = styled.span`
  color: ${colors.black7};
  margin-left: 1rem;
  font-weight: lighter;
`;

const DescContainer = styled.div`
  width: 100%;
  margin-top: 0.7rem;
  ${flex('flex-start', 'center')}
`;

const DescText = styled.div`
  margin-left: 0.5rem;
`;

const NicknameText = styled.span`
  font-weight: bold;
  font-size: 1rem;
`;

const InfoText = styled.span`
  font-weight: 200;
  font-size: 0.9rem;
  color: ${colors.black5};
`;

export default function IssueDetailHeader() {
  const { issue, user } = useContext(IssueDetailContext);
  const { no, title, isOpened } = issue;

  const [editMode, setEditMode] = useState(false);

  return (
    <MainContainer>
      <TitleContainer>
        {editMode ? (
          <IssueTitleEditBox setEditMode={setEditMode} prevTitle={title} />
        ) : (
          <Title>
            <div>
              {title}
              <IssueNoText>#{no}</IssueNoText>
            </div>
            <Controls>
              <EditButton onClick={setEditMode}>Edit</EditButton>
              <Link to="/issues/new">
                <NewIssueButton>New issue</NewIssueButton>
              </Link>
            </Controls>
          </Title>
        )}
        <DescContainer>
          <LabelTag color={isOpened ? colors.issueGreen : colors.issueRed} display={'block'}>
            {isOpened ? (
              <IconContainer>
                <OpenIcon color={'white'} marginRight={'0.3rem'} />
                Open
              </IconContainer>
            ) : (
              <IconContainer>
                <ClosedIcon color={'white'} marginRight={'0.3rem'} />
                Closed
              </IconContainer>
            )}
          </LabelTag>
          <DescText>
            <NicknameText>{user.nickname}</NicknameText>{' '}
            <InfoText>{isOpened ? 'opened this issue' : 'closed this issue'}</InfoText>
          </DescText>
        </DescContainer>
        <Line />
      </TitleContainer>
    </MainContainer>
  );
}
