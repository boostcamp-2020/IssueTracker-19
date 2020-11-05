import { check } from 'prettier';
import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  border: 1px solid gray;
`;

export default function IssueFilterTab({ setIssues, issues, setHeadCheck, headCheck }) {
  const handleCheck = ({ target: { checked } }) => {
    setIssues(issues.map(issue => ({ ...issue, checked })));
    setHeadCheck(checked);
  };
  return (
    <Container>
      <input type="checkbox" checked={headCheck} onChange={handleCheck} />
      Filter Tab
    </Container>
  );
}
