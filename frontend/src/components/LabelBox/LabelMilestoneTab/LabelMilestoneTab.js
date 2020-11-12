import React, { useContext } from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import { SubmitButton } from '@shared';
import { LabelMilestoneControls } from '@components';
import { LabelBoxContext } from '@components/LabelBox/LabelBoxContext';

const Box = styled.div`
  ${flex()};
  justify-content: space-between;
`;

export default function LabelMilestoneTab() {
  const { toggleIsAdding } = useContext(LabelBoxContext);
  return (
    <Box>
      <LabelMilestoneControls labelChecked={true} />
      <SubmitButton onClick={toggleIsAdding}>New Label</SubmitButton>
    </Box>
  );
}

// TODO : 공통 컴포넌트들에게 props 줘서 실제 작동하게 만들기
