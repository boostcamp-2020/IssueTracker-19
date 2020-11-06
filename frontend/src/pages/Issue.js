import React from 'react';
import styled from 'styled-components';
import { Header, IssueList, IssueSearchBox } from '@components';
import { numerics } from '@styles/variables';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
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
