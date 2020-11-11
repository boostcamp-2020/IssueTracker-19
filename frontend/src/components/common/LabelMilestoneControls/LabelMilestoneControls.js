import React from 'react';
import styled from 'styled-components';
import { darken } from 'polished';
import { flex, flexCenter } from '@styles/utils';
import { colors } from '@styles/variables';
import labelIcon from '@imgs/label.svg';
import milestoneIcon from '@imgs/milestone.svg';
import labelWhiteIcon from '@imgs/label-white.svg';
import milestoneWhiteIcon from '@imgs/milestone-white.svg';
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
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
  ${props => (props.labelChecked ? `background-color:${colors.checkedColor}; color:white;` : '')}
  &:hover {
    ${props => (props.labelChecked ? `background-color:${colors.checkedColor};` : '')}
  }
`;
const MilestoneBox = styled(ItemBox)`
  border-top-right-radius: 5px;
  border-bottom-right-radius: 5px;
  ${props =>
    props.milestoneChecked ? `background-color:${colors.checkedColor}; color:white;` : ''}
  &:hover {
    ${props => (props.milestoneChecked ? `background-color:${colors.checkedColor};` : '')}
  }
`;

const ImgIcon = styled.img`
  width: 22px;
  height: 22px;
  margin-right: 0.15rem;
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

export default function LabelMilestoneControls({
  labelCount,
  milestoneCount,
  labelChecked,
  milestoneChecked,
}) {
  return (
    <Container>
      <Link to="/labels">
        <LabelBox labelChecked={labelChecked}>
          <ImgIcon src={labelChecked ? labelWhiteIcon : labelIcon} />
          <div>Labels</div>
          {labelCount ? (
            <CountBox>
              <Count>{labelCount}</Count>
            </CountBox>
          ) : null}
        </LabelBox>
      </Link>
      <Link to="/milestones">
        <MilestoneBox milestoneChecked={milestoneChecked}>
          <ImgIcon src={milestoneChecked ? milestoneWhiteIcon : milestoneIcon} />
          <div>Milestones</div>
          {milestoneCount ? (
            <CountBox>
              <Count>{milestoneCount}</Count>
            </CountBox>
          ) : null}
        </MilestoneBox>
      </Link>
    </Container>
  );
}
