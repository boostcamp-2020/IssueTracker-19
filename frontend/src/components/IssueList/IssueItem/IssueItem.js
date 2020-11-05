import React, { useState } from 'react';
import styled from 'styled-components';

const Container = styled.div`
  border: 1px solid gray;
`;

export default function IssueItem({ checked, issues, title, setCheckAll, setIssues }) {
  const handleCheck = ({ target }) => {
    setIssues(
      issues.map(issue => (issue.title === title ? { ...issue, checked: target.checked } : issue)),
    );
  };
  return (
    <Container>
      <input type="checkbox" checked={checked} onChange={handleCheck} />
      {title}
    </Container>
  );
}
