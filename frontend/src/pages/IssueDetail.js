import React, { useEffect, useState } from 'react';
import { Header, IssueDetailHeader, IssueCommentBox, IssueSidebar } from '@components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import { issueService } from '@services';
import styled from 'styled-components';
import { numerics } from '@styles/variables';
import { useParams } from 'react-router-dom';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
  display: flex;
`;

export default function IssueDetail(props) {
  const { user } = props;

  const { issueNo } = useParams();

  const [issue, setIssue] = useState({});

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

  useEffect(async () => {
    try {
      const {
        data: { issue: fetchedIssue },
        status,
      } = await issueService.getIssue({ issueNo });
      if (status === 200) {
        setIssue(fetchedIssue);
        setMilestone(fetchedIssue.milestone);
        setLabels(fetchedIssue.labels.map(l => ({ ...l, no: l.labelNo })));
        setAssignees(fetchedIssue.assignees.map(a => ({ ...a, no: a.userNo })));

        console.log(fetchedIssue);
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  }, []);

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
          handleRemoveAssignee={handleRemoveAssignee}
          handleRemoveLabel={handleRemoveLabel}
          handleRemoveMilestone={handleRemoveMilestone}
        />
      </IssueContainer>
    </IssueDetailContext.Provider>
  );
}
