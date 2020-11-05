import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  border: 1px solid gray;
`;

export default function IssueFilterTab() {
  return (
    <Container>
      <input type="checkbox" />
      Filter Tab
    </Container>
  );
}
