import React, { useState, useContext, useRef, useEffect } from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import { IssueContext, initialFilterOptions } from '@pages';
import { flex, flexCenter, borderNoneBox, skyblueBoxShadow } from '@styles/utils';
import { colors } from '@styles/variables';
import { SubmitButton } from '@shared';
import { LabelMilestoneControls } from '@components';
import downArrowIcon from '@imgs/down-arrow.svg';
import mGlass from '@imgs/m-glass.svg';

const SearchContainer = styled.div`
  margin-bottom: 1.4rem;
`;

const SearchBox = styled.div`
  width: 100%;
  height: 3rem;
  margin-bottom: 0.5rem;
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

const InputBox = styled.div`
  width: 100%;
  height: 100%;
  ${flexCenter}
  ${props => (props?.focused ? `${skyblueBoxShadow}; border-radius: 5px;` : null)}
`;

const FilterInput = styled.input`
  width: calc(100% - 16px);
  height: calc(100% - 16px);
  margin-left: 0.5rem;
  border-radius: 6px;
  border: none;
  outline: unset;
  background-color: ${colors.grayInputBg};
  color: ${colors.black3};
`;

const MGlassImg = styled.img`
  width: 35px;
  height: 20px;
`;

const DownArrowImg = styled.img`
  width: 8px;
  height: 8px;
  margin-top: 5px;
  margin-left: 7px;
`;

const ControlBox = styled.div`
  ${flex('flex-end', 'center')}
`;

const IssueSubmitButton = styled(SubmitButton)`
  margin-left: 1.5rem;
`;

const ClearBox = styled.div`
  margin-left: 0.2rem;
  cursor: pointer;
`;

const ClearButton = styled.button`
  background-color: white;
  ${borderNoneBox}
  cursor: pointer;
`;

const OptionBox = styled.div`
  font-size: 0.8rem;

  color: ${colors.black3};
  box-sizing: border-box;
  white-space: nowrap;
  ${flex('flex-start', 'center')}
`;

export default function IssueSearchBox() {
  const [focused, setFocused] = useState(false);
  const { filterOptions, setFilterOptions, filterOptionDatas } = useContext(IssueContext);
  const { users, labels, milestones } = filterOptionDatas;
  const optionBoxRef = useRef();

  const handleFocus = () => {
    setFocused(true);
  };

  const handleBlur = () => {
    setFocused(false);
  };

  const handleClear = () => {
    setFilterOptions(initialFilterOptions);
  };

  const isSame = () => JSON.stringify(filterOptions) === JSON.stringify(initialFilterOptions);

  const handleEnter = e => {
    if (e.key === 'Enter') {
      const keyword = e.target.value ?? null;
      setFilterOptions({ ...filterOptions, keyword: keyword === '' ? null : keyword });
    }
  };

  const handleSearchView = () => {
    const options = Object.entries(filterOptions).reduce((acc, [key, val]) => {
      if (key === 'isOpened' && val) {
        return acc + ' is:open';
      }
      if (key === 'author' && val) {
        return acc + ` author:${val}`;
      }
      if (key === 'label' && val.length) {
        return acc + val.reduce((acc, cur) => acc + ` label:${cur}`, '');
      }
      if (key === 'milestone' && val) {
        return acc + ` milestone:${val}`;
      }
      if (key === 'assignee' && val) {
        return acc + ` assignee:${val}`;
      }
      return acc;
    }, '');
    optionBoxRef.current.textContent = options;
  };

  useEffect(() => {
    handleSearchView();
  }, [filterOptions]);

  return (
    <SearchContainer>
      <SearchBox>
        <FilterBox>
          <SelectBox>
            Filters
            <DownArrowImg src={downArrowIcon} />
          </SelectBox>
          <InputBox focused={focused}>
            <MGlassImg src={mGlass} />
            <OptionBox ref={optionBoxRef}></OptionBox>
            <FilterInput
              type="text"
              onFocus={handleFocus}
              onBlur={handleBlur}
              tabIndex={0}
              placeholder={'Search all issues'}
              onKeyPress={handleEnter}
            />
          </InputBox>
        </FilterBox>
        <ControlBox>
          <LabelMilestoneControls labelCount={labels.length} milestoneCount={milestones.length} />
          <Link to="/issues/new">
            <IssueSubmitButton>New issue</IssueSubmitButton>
          </Link>
        </ControlBox>
      </SearchBox>
      {isSame() ? null : (
        <ClearBox onClick={handleClear}>
          ❎<ClearButton>Clear current search query, filters, and sorts</ClearButton>
        </ClearBox>
      )}
    </SearchContainer>
  );
}
