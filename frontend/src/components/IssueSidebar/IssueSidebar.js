import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import GearIcon from './GearIcon/GearIcon';

const MainContainer = styled.div`
  flex-direction: column;
  flex: 1;
  margin-right: 5rem;
  border: 1px solid ${colors.lighterGray};
  border-radius: 5px;
`;

const Box = styled.div`
  ${flex('space-between', 'center')}
  padding:1rem;
  font-size: 0.8rem;
  font-weight: bold;
  color: ${colors.black8};
  &:hover {
    color: ${colors.resetFilterColor};
    svg {
      fill: ${colors.resetFilterColor};
    }
  }
`;

const AssigneeBox = styled(Box)``;
const LabelBox = styled(Box)``;
const MilestoneBox = styled(Box)``;

export default function IssueSidebar() {
  return (
    <MainContainer>
      <AssigneeBox>
        Assignees
        <GearIcon fillColor={colors.black8} />
      </AssigneeBox>
      <LabelBox>
        Labels
        <GearIcon fillColor={colors.black8} />
      </LabelBox>
      <MilestoneBox>
        Milestone
        <GearIcon fillColor={colors.black8} />
      </MilestoneBox>
    </MainContainer>
  );
}
