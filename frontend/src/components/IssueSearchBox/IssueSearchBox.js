import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import { flex, flexCenter, borderNoneBox, skyblueBoxShadow } from '@styles/utils';
import { colors } from '@styles/variables';
import { SubmitButton } from '@shared';
import { LabelMilestoneControls } from '@components';
import downArrowIcon from '@imgs/down-arrow.svg';
import mGlass from '@imgs/m-glass.svg';

const SearchContainer = styled.div`
  margin: 1.2rem 0;
`;

const SearchBox = styled.div`
  width: 100%;
  height: 3rem;
  padding: 0.5rem 0;
  ${flex('space-between', 'center')}
`;

const FilterBox = styled.div`
  ${flexCenter}
  flex: 1;
  height: 2.2rem;
  margin-right: 1.5rem;
  border: 1px solid ${colors.lightGray};
  border-radius: 6px;
  box-sizing: border-box;
  background-color: ${colors.grayInputBg};
  font-size: 0.9rem;
`;

const SelectBox = styled.div`
  ${flexCenter}
  height:100%;
  padding: 0 1.3rem;
  border-right: 0.5px solid ${colors.lightGray};
  box-sizing: border-box;
  color: ${colors.black3};
  cursor: pointer;
`;

const FilterInput = styled.input`
  width: calc(100% - 16px);
  height: calc(100% - 16px);
  padding: 8px;
  border-radius: 6px;
  border: none;
  outline: unset;
  background-color: ${colors.grayInputBg};
  color: ${colors.black3};
  &:focus {
    ${skyblueBoxShadow}
  }
`;

const SelectImg = styled.img`
  width: 8px;
  height: 8px;
  margin-top: 5px;
  margin-left: 7px;
`;

const MGlassImg = styled.img`
  width: 35px;
  height: 20px;
`;

const ControlBox = styled.div`
  ${flex('flex-end', 'center')}
`;

const IssueSubmitButton = styled(SubmitButton)`
  margin-left: 1.5rem;
`;

const ClearBox = styled.div`
  margin-left: 0.2rem;
`;

const ClearButton = styled.button`
  background-color: white;
  ${borderNoneBox}
  cursor: pointer;
`;

export default function IssueSearchBox() {
  return (
    <SearchContainer>
      <SearchBox>
        <FilterBox>
          <SelectBox>
            Filters
            <SelectImg src={downArrowIcon} />
          </SelectBox>
          <MGlassImg src={mGlass} />
          <FilterInput type="text" />
        </FilterBox>
        <ControlBox>
          <LabelMilestoneControls />
          <Link to="issues/new">
            <IssueSubmitButton>New issue</IssueSubmitButton>
          </Link>
        </ControlBox>
      </SearchBox>
      <ClearBox>
        ❎<ClearButton>Clear current search query, filters, and sorts</ClearButton>
      </ClearBox>
    </SearchContainer>
  );
}
