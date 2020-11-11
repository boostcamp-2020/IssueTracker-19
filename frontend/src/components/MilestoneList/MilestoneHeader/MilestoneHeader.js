import React, { useState } from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import MilestoneIcon from '@imgs/milestone.svg';
import CheckIcon from '@imgs/check.svg';
import MilestoneGrayIcon from '@imgs/milestone-gray.svg';
import CheckGrayIcon from '@imgs/check-gray.svg';

const Container = styled.div`
  margin-top: 1.25rem;
  width: 100%;
  background-color: #f6f8fa;
  border: 1px solid ${colors.borderColor};
  box-sizing: border-box;
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
const UnselectedButton = styled(ButtonBox)`
  font-weight: 400;
  color: #586069;
`;
const Img = styled.img`
  width: 20px;
  height: 20px;
  margin-right: 5px;
`;
export default function MilestoneHeader({ setOpenFilter, openCount, closeCount }) {
  const [isOpen, setIsOpen] = useState(true);
  const handleClickOpen = () => {
    setIsOpen(true);
    setOpenFilter(true);
  };
  const handleClickClose = () => {
    setIsOpen(false);
    setOpenFilter(false);
  };
  return (
    <Container>
      {isOpen ? (
        <ToggleBox>
          <ButtonBox onClick={handleClickOpen}>
            <Img src={MilestoneIcon} />
            {openCount} Open
          </ButtonBox>
          <UnselectedButton onClick={handleClickClose}>
            <Img src={CheckGrayIcon} />
            {closeCount} Closed
          </UnselectedButton>
        </ToggleBox>
      ) : (
        <ToggleBox>
          <UnselectedButton onClick={handleClickOpen}>
            <Img src={MilestoneGrayIcon} />
            {openCount} Open
          </UnselectedButton>
          <ButtonBox onClick={handleClickClose}>
            <Img src={CheckIcon} />
            {closeCount} Closed
          </ButtonBox>
        </ToggleBox>
      )}
    </Container>
  );
}
