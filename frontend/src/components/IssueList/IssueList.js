import React from 'react';
import IssueFilterTab from './IssueFilterTab/IssueFilterTab';
import IssueItem from './IssueItem/IssueItem';

export default function IssueList({ issues, setIssues, allChecked, markMode }) {
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
