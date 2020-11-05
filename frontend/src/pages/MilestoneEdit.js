import React from 'react';
import { Header, MilestoneEditBox } from '@components';

export default function MilestoneEdit() {
  return (
    <>
      <Header />
      <MilestoneEditBox isNew={false} />
    </>
  );
}
