import React from 'react';
import styled, { css } from 'styled-components';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import { LabelTag } from '@components';
import milestoneIcon from '@imgs/milestone.svg';

const Container = styled.div`
  border: 1px solid ${colors.lighterGray};
  ${flex('space-between', 'center')}
`;

const IssueDiv = styled.div`
  width: 65%;
  ${flex('flex-start', 'center')}
`;

const CheckBox = styled.input`
  margin: 0 1rem;
`;

const OpenIcon = styled.svg`
  fill: ${colors.openedIssueColor};
  margin-right: 0.5rem;
`;

const ClosedIcon = styled.svg`
  fill: ${colors.closedIssueColor};
  margin-right: 0.5rem;
`;

const TitleContainer = styled.div`
  padding: 0.5rem;
`;
const TopBox = styled.div`
  ${flex()}
`;

const Title = styled.div`
  font-size: 1rem;
  font-weight: bold;
`;

const TagBox = styled.div`
  margin-left: 0.4rem;
`;

const BottomBox = styled.div`
  margin-top: 0.1rem;
  color: ${colors.black5};
  display: flex;
`;

const Label = styled.div`
  display: inline-flex;
  margin: 0 0.1rem;
`;

const AuthorBox = styled.div`
  font-size: 0.75rem;
  font-weight: 300;
`;

const MilestoneBox = styled.div`
  ${flex('flex-start', 'center')}
  margin-left: 0.4rem;
  font-size: 0.7rem;
`;

const MilestoneImg = styled.img`
  width: 14px;
  height: 14px;
  margin-right: 0.2rem;
`;

const AssigneeIcon = styled.img`
  width: 1.25rem;
  height: 1.25rem;
  margin-right: -8px;
  background-color: #123;
  border-radius: 50%;
  border: 1px solid #fff;
`;

const AssigneeBox = styled.div`
  ${flex('space-around', 'center')}
  margin-right: 5rem;
  &:hover img:not(:last-child) {
    transition: margin-right ease 0.3s 0s;
    margin-right: 3px;
  }
  div {
    transition: margin-right ease 0.3s 0s;
    margin-right: -8px;
  }
`;

export default function IssueItem(props) {
  const {
    isOpened,
    checked,
    issues,
    title,
    setIssues,
    labels,
    author,
    no,
    milestoneNo,
    milestoneTitle,
    assignees,
  } = props;
  const handleCheck = ({ target }) => {
    setIssues(
      issues.map(issue => (issue.title === title ? { ...issue, checked: target.checked } : issue)),
    );
  };

  return (
    <Container>
      <IssueDiv>
        <CheckBox type="checkbox" checked={checked} onChange={handleCheck} />
        {isOpened ? (
          <OpenIcon viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
            <path
              fillRule="evenodd"
              d="M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z"
            ></path>
          </OpenIcon>
        ) : (
          <ClosedIcon viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
            <path
              fillRule="evenodd"
              d="M1.5 8a6.5 6.5 0 0110.65-5.003.75.75 0 00.959-1.153 8 8 0 102.592 8.33.75.75 0 10-1.444-.407A6.5 6.5 0 011.5 8zM8 12a1 1 0 100-2 1 1 0 000 2zm0-8a.75.75 0 01.75.75v3.5a.75.75 0 11-1.5 0v-3.5A.75.75 0 018 4zm4.78 4.28l3-3a.75.75 0 00-1.06-1.06l-2.47 2.47-.97-.97a.749.749 0 10-1.06 1.06l1.5 1.5a.75.75 0 001.06 0z"
            ></path>
          </ClosedIcon>
        )}
        <TitleContainer>
          <TopBox>
            <Title>{title}</Title>
            <TagBox>
              {labels.map(({ no, name, color, description }) => {
                return (
                  <Label key={no}>
                    <LabelTag name={name} color={color} size={'0.7rem'}></LabelTag>
                  </Label>
                );
              })}
            </TagBox>
          </TopBox>
          <BottomBox>
            <AuthorBox>
              #{no} opened by {author}
            </AuthorBox>
            {milestoneNo ? (
              <MilestoneBox>
                <MilestoneImg src={milestoneIcon} />
                {milestoneTitle}
              </MilestoneBox>
            ) : null}
          </BottomBox>
        </TitleContainer>
      </IssueDiv>
      <AssigneeBox>
        {assignees.map(assignee => (
          <AssigneeIcon key={assignee.no}></AssigneeIcon>
        ))}
      </AssigneeBox>
    </Container>
  );
}
