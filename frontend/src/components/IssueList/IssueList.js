import React, { useEffect, useState, useContext } from 'react';
import { issueService } from '@services';
import { IssueContext } from '@pages';
import IssueFilterTab from './IssueFilterTab/IssueFilterTab';
import IssueItem from './IssueItem/IssueItem';
import { useHistory } from 'react-router-dom';

export default function IssueList() {
  const history = useHistory();

  const [issues, setIssues] = useState([]);
  const allChecked = issues.every(i => i.checked);
  const markMode = issues.some(i => i.checked);
  const { filterOptions } = useContext(IssueContext);

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
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  useEffect(() => {
    setFilterdIssues(filterOptions);
  }, [filterOptions]);

  return (
    <>
      <IssueFilterTab
        issues={issues}
        setIssues={setIssues}
        allChecked={allChecked}
        markMode={markMode}
      />
      {issues.map(({ no, title, checked }) => (
        <IssueItem key={no} title={title} checked={checked} issues={issues} setIssues={setIssues} />
      ))}
    </>
  );
}
