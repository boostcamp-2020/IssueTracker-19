import React, { useState } from 'react';
import { Header, IssueInputBox, IssueSidebar } from '@components';
import styled from 'styled-components';
import { numerics } from '@styles/variables';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
  display: flex;
`;

export default function IssueNew({ user }) {
  const [assignees, setAssignees] = useState([]);
  const [labels, setLabels] = useState([]);
  const [milestone, setMilestone] = useState(null);

  const handleAssignToMe = () => {
    const { no, nickname } = user;
    setAssignees([{ no, nickname }]);
  };

  const handleClickAssignee = (e, user) => {
    setAssignees([...assignees, user]);
  };

  const handleClickLabel = (e, label) => {
    setLabels([...labels, label]);
  };

  const handleClickMilestone = (e, newMilestone) => {
    setMilestone(newMilestone);
  };

  const handleRemoveAssignee = (e, assignee) => {
    setAssignees(assignees.filter(({ no }) => no !== assignee.no));
  };

  const handleRemoveLabel = (e, label) => {
    setLabels(labels.filter(({ no }) => no !== label.no));
  };

  const handleRemoveMilestone = () => {
    setMilestone(undefined);
  };

  return (
    <>
      <Header />
      <IssueContainer>
        <IssueInputBox
          assigneeNos={assignees.map(a => a.no)}
          labelNos={labels.map(l => l.no)}
          milestoneNo={milestone?.no}
        />
        <IssueSidebar
          assignees={assignees}
          labels={labels}
          milestone={milestone}
          handleAssignToMe={handleAssignToMe}
          handleClickAssignee={handleClickAssignee}
          handleClickLabel={handleClickLabel}
          handleClickMilestone={handleClickMilestone}
          handleRemoveAssignee={handleRemoveAssignee}
          handleRemoveLabel={handleRemoveLabel}
          handleRemoveMilestone={handleRemoveMilestone}
        />
      </IssueContainer>
    </>
  );
}
