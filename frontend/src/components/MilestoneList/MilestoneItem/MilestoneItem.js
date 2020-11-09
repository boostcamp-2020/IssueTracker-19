import React, { useState } from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import CalenderIcon from '@imgs/milestone-calendar.svg';
import { Link } from 'react-router-dom';
const Container = styled.div`
  width: 100%;
  display: flex;
  justify-content: space-between;
`;
const Title = styled.div`
  width: 500px;
  display: table-cell;
  font-size: 0.75rem;
  vertical-align: top;
  padding: 15px 20px;
  border-left: 1px solid ${colors.borderColorSecondary};
  border-top: 1px solid ${colors.borderColorSecondary};
`;
const TitleHeader = styled.h2`
  margin-top: 0;
  margin-bottom: 5px;
  font-size: 1.5rem;
  font-weight: 400;
  line-height: 1.2;
`;
const Meta = styled.div`
  font-size: 14px;
`;
const MetaItem = styled.span`
  display: table-row;
  margin-right: 15px;
  color: ${colors.metaColor};
`;

const Img = styled.img`
  width: 16px;
  height: 16px;
  margin-right: 4px;
  padding-top: 3px;
`;
const Description = styled.div`
  font-size: 16px;
  color: ${colors.metaColor};
`;
const ProgressBox = styled.div`
  display: table-cell;
  font-size: 12px;
  vertical-align: top;
  border-right: 1px solid ${colors.borderColorSecondary};
  border-top: 1px solid ${colors.borderColorSecondary};
  padding: 15px 20px;
  width: 420px;
`;
const ProgressBar = styled.progress`
  height: 20px;
  width: 420px;
`;
const Status = styled.div`
  display: inline-block;
  margin-right: 1.5rem;
  font-size: 14px;
  font-weight: 600;
  line-height: 1.2;
  color: #24292e;
`;
const Label = styled.span`
  margin-left: 4px;
  font-weight: 400;
  color: #586069;
`;
const StatusButtonBox = styled.div`
  margin-top: 0.5rem;
  font-size: 14px;
`;
const StatusEdit = styled.span`
  display: inline-block;
  margin-right: 1rem;
  color: ${colors.checkedColor};
  text-decoration: none;
`;
const StatusForm = styled.form`
  display: inline-block;
  font-size: 14px;
`;
const StatusButton = styled.div`
  display: inline-block;
  margin-right: 1rem;
  text-decoration: none;
`;
const CloseButton = styled(StatusButton)`
  color: ${colors.checkedColor};
`;
const DeleteButton = styled(StatusButton)`
  color: #cb2431;
`;
export default function MilestoneItem({ title, dueDate, description, totalTasks, closedTasks }) {
  const percentage = totalTasks === 0 ? 0 : Math.floor((closedTasks / totalTasks) * 100);
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  const date = new Date(dueDate);
  return (
    <Container>
      <Title>
        <TitleHeader>{title}</TitleHeader>
        <Meta>
          <MetaItem>
            <Img src={CalenderIcon} />
            Due by {monthNames[date.getMonth()]} {date.getDate()}, {date.getFullYear()}
          </MetaItem>
          <Description>
            <p>{description}</p>
          </Description>
        </Meta>
      </Title>
      <ProgressBox>
        <ProgressBar max="100" value={percentage}></ProgressBar>
        <div>
          <Status>
            <span>{percentage}%</span>
            <Label>complete</Label>
          </Status>
          <Status>
            <span>{totalTasks - closedTasks}</span>
            <Label>open</Label>
          </Status>
          <Status>
            <span>{closedTasks}</span>
            <Label>closed</Label>
          </Status>
        </div>
        <StatusButtonBox>
          <Link to="/milestones/edit">
            <StatusEdit>Edit</StatusEdit>
          </Link>
          <StatusForm>
            <CloseButton>Close</CloseButton>
          </StatusForm>
          <StatusForm>
            <DeleteButton>Delete</DeleteButton>
          </StatusForm>
        </StatusButtonBox>
      </ProgressBox>
    </Container>
  );
}
