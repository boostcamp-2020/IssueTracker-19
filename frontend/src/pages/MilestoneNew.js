import React from 'react';
import styled from 'styled-components';
import { Header, MilestoneEditBox, MilestoneNewHeader } from '@components';
import { numerics } from '@styles/variables';

const Container = styled.div`
  margin: 32px ${numerics.marginHorizontal};
`;

export default function MilestoneNew() {
  return (
    <>
      <Header />
      <Container>
        <MilestoneNewHeader />
        <MilestoneEditBox isNew={true} />
      </Container>
    </>
  );
}
