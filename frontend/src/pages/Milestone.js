import React from 'react';
import styled from 'styled-components';
import { Header, LabelMilestoneTab } from '@components';
import { numerics } from '@styles/variables';

const Container = styled.div`
  margin: 32px ${numerics.marginHorizontal};
`;

export default function Milestone() {
  return (
    <>
      <Header />
      <Container>
        <LabelMilestoneTab Submit={true} ButtonName={'New milestone'} />
      </Container>
    </>
  );
}
