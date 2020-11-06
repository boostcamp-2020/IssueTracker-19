import React from 'react';
import { Header, MilestoneEditBox, MilestoneNewHeader } from '@components';

export default function MilestoneNew() {
  return (
    <>
      <Header />
      <MilestoneNewHeader />
      <MilestoneEditBox isNew={true} />
    </>
  );
}
