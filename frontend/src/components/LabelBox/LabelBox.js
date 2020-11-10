import React, { useState } from 'react';
import styled from 'styled-components';
import { flexColumn } from '@styles/utils';
import { numerics } from '@styles/variables';
import LabelItemBox from './LabelItemBox/LabelItemBox';
import LabelMilestoneTab from './LabelMilestoneTab/LabelMilestoneTab';
import { LabelBoxContext } from './LabelBoxContext';

const Box = styled.div`
  flex: 1;
  ${flexColumn};
  margin: ${numerics.marginHorizontal};
`;

export default function LabelBox() {
  const [isAdding, setIsAdding] = useState(false);

  const toggleIsAdding = () => {
    setIsAdding(!isAdding);
  };

  return (
    <LabelBoxContext.Provider
      value={{
        isAdding,
        toggleIsAdding,
      }}
    >
      <Box>
        <LabelMilestoneTab />
        <LabelItemBox />
      </Box>
    </LabelBoxContext.Provider>
  );
}
