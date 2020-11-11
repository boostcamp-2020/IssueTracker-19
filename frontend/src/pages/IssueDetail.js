import React, { useEffect, useState } from 'react';
import { Header, IssueDetailHeader, IssueCommentBox, IssueSidebar } from '@components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import { issueService } from '@services';
import styled from 'styled-components';
import { numerics } from '@styles/variables';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
  display: flex;
`;

export default function IssueDetail({
  user,
  match: {
    params: { issueNo },
  },
}) {
  const [assignees, setAssignees] = useState([]);
  const [labels, setLabels] = useState([]);
  const [milestone, setMilestone] = useState(undefined);
  const [issue, setIssue] = useState({});

  useEffect(async () => {
    try {
      const {
        data: { issue: fetchedIssue },
        status,
      } = await issueService.getIssue({ issueNo });
      if (status === 200) {
        setIssue(fetchedIssue);
        console.log(fetchedIssue);
      }
    } catch (err) {
      console.log('error');
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  }, []);

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
    <IssueDetailContext.Provider value={{ issue, user }}>
      <Header />
      <IssueDetailHeader />
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
