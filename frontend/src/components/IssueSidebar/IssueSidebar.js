import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import GearIcon from './GearIcon/GearIcon';

const MainContainer = styled.div`
  flex-direction: column;
  flex: 1;
  margin-right: 5rem;
  padding-left: 0.5rem;
`;

const Box = styled.div`
  padding: 1.5rem 1rem 0 1rem;
  font-size: 0.8rem;
  font-weight: bold;
  color: ${colors.black5};
`;

const Line = styled.div`
  height: 0.5px;
  width: 100%;
  margin-top: 1rem;
  background-color: ${colors.lighterGray};
`;

const AssigneeBox = styled(Box)``;
const LabelBox = styled(Box)``;
const MilestoneBox = styled(Box)``;

const Header = styled.div`
  ${flex('space-between', 'center')}
  cursor: pointer;
  &:hover {
    color: ${colors.resetFilterColor};
    svg {
      fill: ${colors.resetFilterColor};
    }
  }
`;

const Content = styled.div`
  font-weight: 300;
  font-size: 0.75rem;
  padding: 0.8rem 0 0 0;
`;

const AssigneeButton = styled.span``;

export default function IssueSidebar() {
  return (
    <MainContainer>
      <AssigneeBox>
        <Header>
          Assignees
          <GearIcon fillColor={colors.black8} />
        </Header>
        <Content>
          No one—<AssigneeButton>assign yourself</AssigneeButton>
          <Line />
        </Content>
      </AssigneeBox>
      <LabelBox>
        <Header>
          Labels
          <GearIcon fillColor={colors.black8} />
        </Header>
        <Content>None yet</Content>
        <Line />
      </LabelBox>

      <MilestoneBox>
        <Header>
          Milestone
          <GearIcon fillColor={colors.black8} />
        </Header>
        <Content>None yet</Content>
        <Line />
      </MilestoneBox>
    </MainContainer>
  );
}
