import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';

const ProgressBarBackground = styled.span`
  width: 100%;
  height: 10px;
  display: flex;
  overflow: hidden;
  background-color: ${colors.borderColor};
  border-radius: 6px;
  margin-bottom: 8px;
  margin-top: 4px;
`;

const Progress = styled.span`
  width: ${props => props.width};
  background-color: ${colors.issueGreen};
`;

export default function ProgressBar({ percentage }) {
  return (
    <ProgressBarBackground>
      <Progress width={`${percentage}%`}></Progress>
    </ProgressBarBackground>
  );
}
