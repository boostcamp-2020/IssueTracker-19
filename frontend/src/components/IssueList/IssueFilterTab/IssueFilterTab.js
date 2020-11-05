import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  border: 1px solid gray;
`;

export default function IssueFilterTab({ setIssues, issues, allChecked }) {
  const handleCheck = ({ target: { checked } }) => {
    setIssues(issues.map(issue => ({ ...issue, checked })));
  };
  return (
    <Container>
      <input type="checkbox" onChange={handleCheck} checked={allChecked} />
      Filter Tab
    </Container>
  );
}
