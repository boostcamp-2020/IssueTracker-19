import React from 'react';
import styled from 'styled-components';
import { Header, MilestoneEditBox, LabelMilestoneTab } from '@components';
import { numerics } from '@styles/variables';

const Container = styled.div`
  margin: ${numerics.marginHorizontal};
`;

export default function MilestoneEdit() {
  return (
    <>
      <Header />
      <Container>
        <LabelMilestoneTab submit={false} buttonName={''} />
        <MilestoneEditBox isNew={false} />
      </Container>
    </>
  );
}
