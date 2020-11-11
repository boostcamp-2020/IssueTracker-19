import React from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';

import { SubmitButton } from '@shared';
import { LabelMilestoneControls } from '@components';
import { Link } from 'react-router-dom';

const Box = styled.div`
  ${flex()};
  justify-content: space-between;
`;

export default function LabelMilestoneTab({ submit, buttonName }) {
  return (
    <Box>
      <LabelMilestoneControls milestoneChecked={true} />
      {submit ? (
        <Link to="/milestones/new">
          <SubmitButton>{buttonName}</SubmitButton>
        </Link>
      ) : null}
    </Box>
  );
}
