import React from 'react';
import styled from 'styled-components';
import { flex, flexColumn } from '@styles/utils';
import { colors } from '@styles/variables';

const Box = styled.div`
  ${flexColumn};
  background-color: ${colors.lightGray};
`;

const EditHeader = styled.div`
  ${flex('space-between')}
`;

const EditBody = styled.div`
  ${flex('space-between')}
`;

export default function LabelEditBox() {
  return (
    <Box>
      <EditHeader />
      <EditBody />
    </Box>
  );
}
