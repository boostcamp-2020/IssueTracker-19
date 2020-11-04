import React from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import { SubmitButton } from '@shared';
import { LabelMilestoneControls } from '@components';

const SearchBox = styled.div`
  width: 80%;
  padding: 10%;
  height: 3rem;
  ${flex('space-between', 'center')}
`;

const FilterBox = styled.div`
  width: 100%;
  background-color: brown;
  ${flex()}
`;

const FilterInput = styled.input`
  width: 100%;
`;

const ControlBox = styled.div`
  width: 100%;
  ${flex('space-around', 'center')}
`;

export default function IssueSearchBar() {
  return (
    <SearchBox>
      <FilterBox>
        <select>
          <option>option 1</option>
          <option>option 2</option>
        </select>
        <FilterInput type="text" />
      </FilterBox>
      <ControlBox>
        <LabelMilestoneControls />
        <SubmitButton>New issue</SubmitButton>
      </ControlBox>
    </SearchBox>
  );
}
