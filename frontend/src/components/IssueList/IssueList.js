import React from 'react';
import styled from 'styled-components';
import IssueFilterTab from './IssueFilterTab/IssueFilterTab';
import IssueItem from './IssueItem/IssueItem';
import { flexCenter } from '@styles/utils';
import { colors } from '@styles/variables';

const NoResultBox = styled.div`
  border: 1px solid ${colors.lighterGray};
  padding: 4rem 0;
  ${flexCenter};
  flex-direction: column;
`;

const NoReultIcon = styled.div`
  ${flexCenter};
  margin-bottom: 1rem;
`;

export default function IssueList({ issues, setIssues, allChecked, selectedCount }) {
  return (
    <>
      <IssueFilterTab
        issues={issues}
        setIssues={setIssues}
        allChecked={allChecked}
        selectedCount={selectedCount}
      />
      {issues.length ? (
        issues.map(props => <IssueItem key={props.no} {...props} />)
      ) : (
        <NoResultBox>
          <NoReultIcon>
            <svg height="32" viewBox="0 0 24 24" version="1.1" width="32" aria-hidden="true">
              <path d="M12 7a.75.75 0 01.75.75v4.5a.75.75 0 01-1.5 0v-4.5A.75.75 0 0112 7zm1 9a1 1 0 11-2 0 1 1 0 012 0z"></path>
              <path
                fillRule="evenodd"
                d="M12 1C5.925 1 1 5.925 1 12s4.925 11 11 11 11-4.925 11-11S18.075 1 12 1zM2.5 12a9.5 9.5 0 1119 0 9.5 9.5 0 01-19 0z"
              ></path>
            </svg>
          </NoReultIcon>
          검색된 이슈가 없습니다.
        </NoResultBox>
      )}
    </>
  );
}
