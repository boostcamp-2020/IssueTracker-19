import React from 'react';
import { Header, IssueSearchBox } from '@components';
import styled from 'styled-components';

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
      </IssueContainer>
    </>
  );
}
