import React, { useState, useEffect } from 'react';
import MilestoneHeader from './MilestoneHeader/MilestoneHeader';
import MilestoneItem from './MilestoneItem/MilestoneItem';
import { milestoneService } from '@services';
import styled from 'styled-components';
import { colors } from '@styles/variables';

const MilestoneListBox = styled.div`
  border-bottom: 1px solid ${colors.borderColorSecondary};
`;

export default function MilestoneList() {
  const [milestoneList, setMilestoneList] = useState([]);
  const [count, setCount] = useState({ open: 0, closed: 0 });
  const fetchMilestones = async () => {
    const {
      data: { milestones },
    } = await milestoneService.getMilestones();
    const { open, closed } = milestones.reduce(
      (acc, { isClosed, isDeleted }) => {
        if (isClosed && !isDeleted) {
          return { open: acc.open, closed: acc.closed + 1 };
        }
        if (!isClosed && !isDeleted) {
          return { open: acc.open + 1, closed: acc.closed };
        }
        return acc;
      },
      { open: 0, closed: 0 },
    );

    setCount({ open, closed });
    setMilestoneList(milestones);
  };

  useEffect(() => {
    fetchMilestones();
  }, []);
  console.log(milestoneList);
  return (
    <MilestoneListBox>
      <MilestoneHeader openCount={count.open} closeCount={count.closed} />
      {milestoneList.map(milestone => {
        const {
          no,
          title,
          dueDate,
          description,
          totalTasks,
          closedTasks,
          isDeleted,
          isClosed,
        } = milestone;
        if (!isDeleted) {
          return (
            <MilestoneItem
              key={no}
              no={no}
              title={title}
              dueDate={dueDate}
              description={description}
              totalTasks={totalTasks}
              closedTasks={closedTasks}
              isClosed={isClosed}
            />
          );
        }
      })}
    </MilestoneListBox>
  );
}
