import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  border: 1px solid gray;
`;

export default function IssueFilterTab({ setIssues, issues, setCheckAll, checkAll }) {
  const handleCheck = ({ target: { checked } }) => {
    setIssues(issues.map(issue => ({ ...issue, checked })));
    setCheckAll(checked);
  };
  return (
    <Container>
      <input type="checkbox" checked={checkAll} onChange={handleCheck} />
      Filter Tab
    </Container>
  );
}
