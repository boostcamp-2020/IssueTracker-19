import React from 'react';
import styled from 'styled-components';
import { Header, IssueList, IssueSearchBox } from '@components';

const IssueContainer = styled.div`
  width: calc(100% - 160px);
  margin: 0 auto;
`;

export default function Issue() {
  return (
    <>
      <Header />
      <IssueContainer>
        <IssueSearchBox />
        <IssueList />
      </IssueContainer>
    </>
  );
}
