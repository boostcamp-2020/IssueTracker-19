import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';

const Container = styled.div`
  border: 1px solid ${colors.lighterGray};
`;

const CheckBox = styled.input`
  margin: 0 1rem;
`;

export default function IssueItem({ checked, issues, title, setIssues }) {
  const handleCheck = ({ target }) => {
    setIssues(
      issues.map(issue => (issue.title === title ? { ...issue, checked: target.checked } : issue)),
    );
  };

  return (
    <Container>
      <CheckBox type="checkbox" checked={checked} onChange={handleCheck} />
      {title}
    </Container>
  );
}
