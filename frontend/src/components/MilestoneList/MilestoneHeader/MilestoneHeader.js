import React from 'react';
import styled from 'styled-components';
import { API } from '@api';
import { flexColumn, flexCenter, flex } from '@styles/utils';
import { colors } from '@styles/variables';
import MilestoneIcon from '@imgs/milestone.svg';
import CheckIcon from '@imgs/check.svg';

const Container = styled.div`
  margin-top: 1.25rem;
  width: 100%;
  background-color: #f6f8fa;
  border: 1px solid ${colors.borderColor};
  border-radius: 6px 6px 0 0;
`;
const ToggleBox = styled.div`
  padding-left: 1rem;
  display: flex;
`;
const ButtonBox = styled.div`
  display: flex;
  align-items: flex-start;
  color: #24292e;
  font-weight: 600;
  font-size: 14px;
  padding: 13px 10px;
  cursor: pointer;
`;
const Img = styled.img`
  width: 20px;
  height: 20px;
  margin-right: 5px;
`;
export default function MilestoneHeader() {
  return (
    <div>
      <Container>
        <ToggleBox>
          <ButtonBox>
            <Img src={MilestoneIcon} />3 Open
          </ButtonBox>
          <ButtonBox>
            <Img src={CheckIcon} />1 Closed
          </ButtonBox>
        </ToggleBox>
      </Container>
    </div>
  );
}
