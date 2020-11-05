import React from 'react';
import styled from 'styled-components';
import { flexColumn } from '@styles/utils';
import { numerics } from '@styles/variables';
import LabelEditBox from './LabelEditBox/LabelEditBox';
import LabelMilestoneTab from './LabelMilestoneTab/LabelMilestoneTab';

const LabelDiv = styled.div`
  flex: 1;
  ${flexColumn};
  margin: ${numerics.marginHorizontal};
`;

export default function LabelBox() {
  return (
    <LabelDiv>
      <LabelMilestoneTab />
      <LabelEditBox />
    </LabelDiv>
  );
}
