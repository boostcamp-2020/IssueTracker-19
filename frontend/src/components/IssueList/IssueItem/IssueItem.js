import React, { useState } from 'react';
import styled from 'styled-components';

const Container = styled.div`
  border: 1px solid gray;
`;

export default function IssueItem() {
  return (
    <Container>
      <input type="checkbox" />
      Issue Item
    </Container>
  );
}
