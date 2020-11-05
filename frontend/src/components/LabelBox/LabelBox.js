import React from 'react';
import styled from 'styled-components';
import { flexColumn } from '@styles/utils';
import { numerics } from '@styles/variables';
import LabelItemBox from './LabelItemBox/LabelItemBox';
import LabelMilestoneTab from './LabelMilestoneTab/LabelMilestoneTab';

const Box = styled.div`
  flex: 1;
  ${flexColumn};
  margin: ${numerics.marginHorizontal};
`;

export default function LabelBox() {
  return (
    <Box>
      <LabelMilestoneTab />
      <LabelItemBox />
    </Box>
  );
}
