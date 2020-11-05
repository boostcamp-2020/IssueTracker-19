import React, { useEffect, useState } from 'react';
import { issueService } from '@services';
import IssueFilterTab from './IssueFilterTab/IssueFilterTab';
import IssueItem from './IssueItem/IssueItem';
import { useHistory } from 'react-router-dom';

export default function IssueList() {
  const [issues, setIssues] = useState([]);
  const [headCheck, setHeadCheck] = useState(false);
  const history = useHistory();

  const setFilterdIssues = async options => {
    try {
      const {
        data: { issues },
        status,
      } = await issueService.getIssues(options);
      if (status === 200) {
        setIssues(issues.map(issue => ({ ...issue, checked: false })));
      }
    } catch (err) {
      history.push('/login');
    }
  };

  useEffect(() => {
    setFilterdIssues();
  }, []);

  return (
    <>
      <IssueFilterTab
        issues={issues}
        setIssues={setIssues}
        headCheck={headCheck}
        setHeadCheck={setHeadCheck}
      />
      {issues.map(({ title, checked }, idx) => (
        <IssueItem
          key={idx}
          title={title}
          checked={checked}
          issues={issues}
          setIssues={setIssues}
          setHeadCheck={setHeadCheck}
        />
      ))}
    </>
  );
}
