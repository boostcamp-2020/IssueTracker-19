import React, { useState } from 'react';
import styled from 'styled-components';

const Header = styled.h2`
  margin-bottom: 8px;
  padding: 0 10px;
  font-size: 24px;
  font-weight: 400;
`;
const HeaderDescriptsion = styled.div`
  padding: 0 10px;
  font-size: 14px;
  font-weight: 400;
  color: #586069;
`;

export default function MilestoneNewHeader() {
  return (
    <>
      <Header>New milestone</Header>
      <HeaderDescriptsion>Create a new milestone to help organize your issues.</HeaderDescriptsion>
    </>
  );
}
