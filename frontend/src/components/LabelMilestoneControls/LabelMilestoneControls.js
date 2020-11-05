import React from 'react';
import styled from 'styled-components';
import { darken } from 'polished';
import { flex, flexCenter } from '@styles/utils';
import { colors } from '@styles/variables';
import labelIcon from '@imgs/label.svg';
import MilestoneIcon from '@imgs/milestone.svg';
import { Link } from 'react-router-dom';

const Container = styled.div`
  ${flex('space-around', 'center')}
  border: 0.5px solid ${colors.lighterGray};
  border-radius: 6px;
  box-sizing: border-box;
`;

const ItemBox = styled.div`
  ${flexCenter}
  height: 2.2rem;
  padding: 0 1rem;
  font-size: 0.9rem;
  font-weight: bold;
  cursor: pointer;
  &:hover {
    background-color: ${darken(0.02, colors.semiWhite)};
  }
`;

const LabelBox = styled(ItemBox)`
  border-right: 0.5px solid ${colors.lighterGray};
`;
const MilestoneBox = styled(ItemBox)``;

const ImgIcon = styled.img`
  width: 22px;
  height: 22px;
`;

const CountBox = styled.div`
  ${flexCenter}
  width:1.6rem;
  height: 1.6rem;
  border-radius: 50%;
  background-color: ${colors.lighterGray};
  margin-left: 0.2rem;
`;

const Count = styled.div`
  ${flexCenter}
  font-size: 0.75rem;
`;

export default function LabelMilestoneControls() {
  return (
    <Container>
      <Link to="labels">
        <LabelBox>
          <ImgIcon src={labelIcon} />
          <div>Labels</div>
          <CountBox>
            <Count>15</Count>
          </CountBox>
        </LabelBox>
      </Link>
      <Link to="milestones">
        <MilestoneBox>
          <ImgIcon src={MilestoneIcon} />
          <div>Milestones</div>
          <CountBox>
            <Count>20</Count>
          </CountBox>
        </MilestoneBox>
      </Link>
    </Container>
  );
}
