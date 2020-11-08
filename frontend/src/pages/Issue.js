import React, { useState, createContext } from 'react';
import styled from 'styled-components';
import { Header, IssueList, IssueSearchBox } from '@components';
import { numerics } from '@styles/variables';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
`;

const initialFilterOptions = {
  isOpened: 1,
  author: null,
  label: [],
  milestone: null,
  assignee: null,
};

export const IssueContext = createContext();

export default function Issue() {
  const [filterOptions, setFilterOptions] = useState(initialFilterOptions);

  return (
    <IssueContext.Provider value={{ filterOptions, setFilterOptions }}>
      <Header />
      <IssueContainer>
        <IssueSearchBox />
        <IssueList />
      </IssueContainer>
    </IssueContext.Provider>
  );
}
