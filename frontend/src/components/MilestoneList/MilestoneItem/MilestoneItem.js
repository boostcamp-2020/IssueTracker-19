import React, { useState } from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import CalenderIcon from '@imgs/milestone-calendar.svg';
import { useHistory } from 'react-router-dom';
import { milestoneService } from '@services';
import { getFormattedDueDate, getPercentage } from '@lib/utils';

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
  cursor: pointer;
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
`;

const Description = styled.div`
  font-size: 16px;
  color: ${colors.metaColor};
  white-space: pre-wrap;
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
  color: ${colors.submitColor};
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
  cursor: pointer;
`;

const StatusForm = styled.form`
  display: inline-block;
  font-size: 14px;
`;

const StatusButton = styled.div`
  display: inline-block;
  margin-right: 1rem;
  text-decoration: none;
  cursor: pointer;
`;

const CloseButton = styled(StatusButton)`
  color: ${colors.checkedColor};
`;

const DeleteButton = styled(StatusButton)`
  color: #cb2431;
`;

const DueDate = styled.p`
  display: flex;
  align-items: center;
  margin-top: 3px;
  margin-bottom: 3px;
`;

export default function MilestoneItem({
  no,
  title,
  dueDate,
  description,
  totalTasks,
  closedTasks,
  isClosed,
  fetchMilestones,
}) {
  const [closed, setClosed] = useState(isClosed);
  const [isDeleted, setIsDeleted] = useState(false);
  const history = useHistory();
  const percentage = getPercentage(totalTasks, closedTasks);

  const handleClose = async () => {
    await milestoneService.closeMilestones(no);
    fetchMilestones();
    setClosed(true);
  };

  const handleOpen = async () => {
    milestoneService.openMilestones(no);
    fetchMilestones();
    setClosed(false);
  };

  const handleDelete = async () => {
    if (confirm(`[${title}] 마일스톤을 삭제하시겠습니까?`)) {
      milestoneService.deleteMilestones(no);
      fetchMilestones();
      setIsDeleted(true);
    }
  };

  const handleClickEdit = () => {
    const editLink = `/milestones/${no}/edit`;
    history.push({
      pathname: editLink,
      state: {
        no,
        isClosed,
        title,
        dueDate,
        description,
      },
    });
  };

  let showDesription = description ? description.split('\n')[0] : ' ';

  return (
    <>
      {!isDeleted ? (
        <Container>
          <Title>
            <TitleHeader>{title}</TitleHeader>
            <Meta>
              <MetaItem>
                {dueDate ? (
                  <DueDate>
                    <Img src={CalenderIcon} />
                    {getFormattedDueDate(new Date(dueDate))}
                  </DueDate>
                ) : (
                  <DueDate>No due date</DueDate>
                )}
              </MetaItem>
              <Description>
                <p>{showDesription}</p>
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
              <StatusEdit onClick={handleClickEdit}>Edit</StatusEdit>
              <StatusForm>
                {!closed ? (
                  <CloseButton onClick={handleClose}>Close</CloseButton>
                ) : (
                  <CloseButton onClick={handleOpen}>Open</CloseButton>
                )}
              </StatusForm>
              <StatusForm>
                <DeleteButton onClick={handleDelete}>Delete</DeleteButton>
              </StatusForm>
            </StatusButtonBox>
          </ProgressBox>
        </Container>
      ) : null}
    </>
  );
}
