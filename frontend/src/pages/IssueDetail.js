import React, { useState } from 'react';
import { Header, IssueTitleBox, IssueCommentBox, IssueSidebar } from '@components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
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
  const [milestone, setMilestone] = useState(undefined);

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

  return (
    <IssueDetailContext.Provider value={{}}>
      <Header />
      <IssueTitleBox />
      <IssueContainer>
        <IssueCommentBox />
        {/* IssueInputBox */}
        <IssueSidebar
          assignees={assignees}
          labels={labels}
          milestone={milestone}
          handleAssignToMe={handleAssignToMe}
          handleClickAssignee={handleClickAssignee}
          handleClickLabel={handleClickLabel}
          handleClickMilestone={handleClickMilestone}
        />
      </IssueContainer>
    </IssueDetailContext.Provider>
  );
}
