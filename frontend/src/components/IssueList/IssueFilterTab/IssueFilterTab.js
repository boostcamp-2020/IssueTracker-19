import React from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import downArrowIcon from '@imgs/down-arrow.svg';
import { colors } from '@styles/variables';

const Container = styled.div`
  border: 1px solid gray;
  ${flex('space-between', 'center')}
`;

const FilterBox = styled.div`
  ${flex()}
`;

const Filter = styled.div`
  padding: 1rem 1.5rem;
  margin-right: 0.2rem;
  cursor: pointer;
  color: ${colors.black5};
  &:hover {
    color: ${colors.black1};
  }
`;

const ArrowImg = styled.img`
  width: 8px;
  height: 8px;
  margin-left: 5px;
`;

export default function IssueFilterTab({ setIssues, issues, allChecked }) {
  const handleCheck = ({ target: { checked } }) => {
    setIssues(issues.map(issue => ({ ...issue, checked })));
  };
  return (
    <Container>
      <input type="checkbox" onChange={handleCheck} checked={allChecked} />
      <FilterBox>
        <Filter>
          Author
          <ArrowImg src={downArrowIcon} />
        </Filter>
        <Filter>
          Label
          <ArrowImg src={downArrowIcon} />
        </Filter>
        <Filter>
          Milestones
          <ArrowImg src={downArrowIcon} />
        </Filter>
        <Filter>
          Assignee
          <ArrowImg src={downArrowIcon} />
        </Filter>
      </FilterBox>
    </Container>
  );
}
