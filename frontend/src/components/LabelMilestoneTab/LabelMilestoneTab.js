import React from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';

import { SubmitButton } from '@shared';
import { LabelMilestoneControls } from '@components';

const Box = styled.div`
  ${flex()};
  justify-content: space-between;
`;

export default function LabelMilestoneTab({ submit, buttonName }) {
  return (
    <Box>
      <LabelMilestoneControls />
      {submit ? <SubmitButton>{buttonName}</SubmitButton> : null}
    </Box>
  );
}
