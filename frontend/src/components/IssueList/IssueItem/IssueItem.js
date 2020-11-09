import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import { LabelTag } from '@components';
import milestoneIcon from '@imgs/milestone.svg';

const Container = styled.div`
  border: 1px solid ${colors.lighterGray};
  ${flex('flex-start', 'center')}
`;

const CheckBox = styled.input`
  margin: 0 1rem;
`;

const OpenCloseIcon = styled.svg`
  fill: #22863a;
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

export default function IssueItem(props) {
  const {
    checked,
    issues,
    title,
    setIssues,
    labels,
    author,
    no,
    milestoneNo,
    milestoneTitle,
  } = props;

  const handleCheck = ({ target }) => {
    setIssues(
      issues.map(issue => (issue.title === title ? { ...issue, checked: target.checked } : issue)),
    );
  };

  console.log(props);

  return (
    <Container>
      <CheckBox type="checkbox" checked={checked} onChange={handleCheck} />
      <OpenCloseIcon
        className="open-close-icon"
        viewBox="0 0 16 16"
        version="1.1"
        width="16"
        height="16"
        aria-hidden="true"
      >
        <path
          fillRule="evenodd"
          d="M8 1.5a6.5 6.5 0 100 13 6.5 6.5 0 000-13zM0 8a8 8 0 1116 0A8 8 0 010 8zm9 3a1 1 0 11-2 0 1 1 0 012 0zm-.25-6.25a.75.75 0 00-1.5 0v3.5a.75.75 0 001.5 0v-3.5z"
        ></path>
      </OpenCloseIcon>
      <TitleContainer>
        <TopBox>
          <Title>{title}</Title>
          <TagBox>
            {labels.map(({ no, name, color, description }) => {
              console.log(no, name);
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
    </Container>
  );
}
