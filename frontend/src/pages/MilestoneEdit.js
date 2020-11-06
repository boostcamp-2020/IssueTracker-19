import React from 'react';
import styled from 'styled-components';
import { Header, MilestoneEditBox, LabelMilestoneTab } from '@components';
import { numerics } from '@styles/variables';

const Container = styled.div`
  margin: 32px ${numerics.marginHorizontal};
`;

export default function MilestoneEdit() {
  return (
    <>
      <Header />
      <Container>
        <LabelMilestoneTab Submit={false} ButtonName={''} />
        <MilestoneEditBox isNew={false} />
      </Container>
    </>
  );
}
