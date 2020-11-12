import React from 'react';
import styled from 'styled-components';
import { Header, LabelMilestoneTab, MilestoneList } from '@components';
import { numerics } from '@styles/variables';

const Container = styled.div`
  margin: ${numerics.marginHorizontal};
`;

export default function Milestone() {
  return (
    <>
      <Header />
      <Container>
        <LabelMilestoneTab submit={true} buttonName={'New milestone'} />
        <MilestoneList />
      </Container>
    </>
  );
}
