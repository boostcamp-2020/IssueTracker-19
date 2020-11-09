import React from 'react';
import { Header, IssueInputBox, IssueSidebar } from '@components';
import styled from 'styled-components';
import { numerics } from '@styles/variables';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
  display: flex;
`;

export default function IssueNew() {
  return (
    <>
      <Header />
      <IssueContainer>
        <IssueInputBox />
        <IssueSidebar />
      </IssueContainer>
    </>
  );
}
