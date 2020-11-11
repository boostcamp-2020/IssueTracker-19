import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flex, mediumBoxShadow } from '@styles/utils';
import { LabelTag, OpenIcon, ClosedIcon } from '@components';
import milestoneIcon from '@imgs/milestone.svg';
import { Link } from 'react-router-dom';

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

const TitleContainer = styled.div`
  padding: 0.5rem;
`;
const TopBox = styled.div`
  ${flex()}
`;

const Title = styled.div`
  font-size: 1rem;
  font-weight: bold;
  cursor: pointer;
  &:hover {
    color: ${colors.resetFilterColor};
  }
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
  width: 1.5rem;
  height: 1.5rem;
  margin-right: -8px;
  background-color: #123;
  border-radius: 50%;
  ${mediumBoxShadow};
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
    image,
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
        {isOpened ? <OpenIcon /> : <ClosedIcon />}
        <TitleContainer>
          <TopBox>
            <Link to={`/issues/${no}`}>
              <Title>{title}</Title>
            </Link>
            <TagBox>
              {labels.map(({ no, name, color, description }) => {
                return (
                  <Label key={no}>
                    <LabelTag color={color} size={'0.7rem'}>
                      {name}
                    </LabelTag>
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
          <AssigneeIcon key={assignee.no} src={assignee.image}></AssigneeIcon>
        ))}
      </AssigneeBox>
    </Container>
  );
}
