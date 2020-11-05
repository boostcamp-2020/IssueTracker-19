import React, { useState } from 'react';
import IssueSearchBox from './IssueSearchBar/IssueSearchBar';
import IssueFilterTab from './IssueFilterTab/IssueFilterTab';
import IssueItem from './IssueItem/IssueItem';

export default function IssueList() {
  const [checkAll, setCheckAll] = useState(false);
  const tempIssues = ['a', 'b', 'c'];
  return (
    <>
      <IssueSearchBox />
      <IssueFilterTab />
      {tempIssues.map((item, idx) => (
        <IssueItem key={idx} />
      ))}
    </>
  );
}
