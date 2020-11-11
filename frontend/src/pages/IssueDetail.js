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

  const handleAssignToMe = async () => {
    try {
      const { status } = await issueService.addIssuesAssignee({
        no: issueNo,
        assigneeNos: [user.no],
      });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleClickAssignee = async (e, user) => {
    try {
      const { status } = await issueService.addIssuesAssignee({
        no: issueNo,
        assigneeNos: [user.no],
      });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleClickLabel = async (e, label) => {
    try {
      const { status } = await issueService.addIssuesLabel({
        no: issueNo,
        labelNos: [label.no],
      });
      if (status === 201) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleClickMilestone = async (e, newMilestone) => {
    try {
      const { status } = await issueService.addIssuesMilestone({
        no: issueNo,
        milestoneNo: newMilestone.no,
      });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleRemoveAssignee = async (e, assignee) => {
    try {
      const { status } = await issueService.removeIssuesAssignee({
        no: issueNo,
        assigneeNo: assignee.no,
      });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleRemoveLabel = async (e, label) => {
    try {
      const { status } = await issueService.removeIssuesLabel({
        no: issueNo,
        labelNo: label.no,
      });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleRemoveMilestone = async () => {
    try {
      const { status } = await issueService.addIssuesMilestone({
        no: issueNo,
        milestoneNo: null,
      });
      if (status === 200) {
        fetchIssueDetails();
      }
    } catch (err) {
      console.error(err);
    }
  };

  const fetchIssueDetails = async () => {
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
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  useEffect(() => {
    fetchIssueDetails();
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
