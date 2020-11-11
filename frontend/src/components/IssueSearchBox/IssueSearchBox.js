import React, { useState, useContext, useRef, useEffect } from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import { IssueContext, initialFilterOptions } from '@pages';
import { flex, flexCenter, borderNoneBox, skyblueBoxShadow } from '@styles/utils';
import { colors } from '@styles/variables';
import { SubmitButton, ListItem } from '@shared';
import { LabelMilestoneControls, OptionSelectModal } from '@components';
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
  position: relative;
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

const InputContainer = styled.div`
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

const ClearContainer = styled.div`
  margin-left: 0.2rem;
  &:hover {
    span {
      color: ${colors.resetFilterColor};
    }
    svg {
      background-color: ${colors.resetFilterColor};
    }
  }
`;

const ClearBox = styled.div`
  background-color: white;
  ${borderNoneBox}
  cursor: pointer;
  font-size: 0.9rem;
  ${flex('flex-start', 'center')}
`;

const ClearIcon = styled.svg`
  border-radius: 5px;
  margin-right: 5px;
  background-color: ${colors.resetDefaultColor};
  fill: white;
`;

const OptionBox = styled.div`
  font-size: 0.8rem;

  color: ${colors.black3};
  box-sizing: border-box;
  white-space: nowrap;
  ${flex('flex-start', 'center')}
`;

const Modal = styled.div`
  position: absolute;
  top: 2.7rem;
  left: 0;
  outline: 0;
  z-index: 2;
`;

export default function IssueSearchBox() {
  const [focused, setFocused] = useState(false);
  const [visiable, setVisiable] = useState(false);

  const { filterOptions, setFilterOptions, filterOptionDatas } = useContext(IssueContext);
  const { users, labels, milestones } = filterOptionDatas;
  const optionBoxRef = useRef();
  const inputRef = useRef();
  const modal = useRef();

  const openModal = () => {
    setVisiable(true);
    modal.current.focus();
  };

  const closeFilterModal = () => setVisiable(false);

  const handleFocus = () => {
    setFocused(true);
  };

  const handleBlur = () => {
    setFocused(false);
  };

  const handleClear = () => {
    setFilterOptions(initialFilterOptions);
    inputRef.current.value = '';
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
      if (key === 'isOpened') {
        if (val === 1) {
          return acc + ' is:open';
        }
        if (val === 0) {
          return acc + ' is:closed';
        }
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
      if (key === 'comment' && val) {
        return acc + ` comment:@me`;
      }
      return acc;
    }, '');
    optionBoxRef.current.textContent = options;
  };

  useEffect(() => {
    handleSearchView();
  }, [filterOptions]);

  const handleOpenFilter = () => {
    setFilterOptions({ ...filterOptions, isOpened: 1 });
  };

  const handleMyIssuesFilter = () => {
    setFilterOptions({ ...filterOptions, author: '@me' });
  };

  const handleAssignedToMeFilter = () => {
    setFilterOptions({ ...filterOptions, assignee: '@me' });
  };

  const handleMyCommentIssuesFilter = () => {
    setFilterOptions({ ...filterOptions, comment: 1 });
  };

  const handleClosedFilter = () => {
    setFilterOptions({ ...filterOptions, isOpened: 0 });
  };

  return (
    <SearchContainer>
      <SearchBox>
        <FilterBox>
          <SelectBox onClick={openModal}>
            Filters
            <DownArrowImg src={downArrowIcon} />
          </SelectBox>
          <Modal tabIndex={0} ref={modal} onBlur={closeFilterModal}>
            <OptionSelectModal
              visiable={visiable}
              setVisiable={setVisiable}
              title={'Filter issues'}
            >
              <ListItem onClick={handleOpenFilter}>열린 이슈들</ListItem>
              <ListItem onClick={handleMyIssuesFilter}>내가 작성한 이슈들</ListItem>
              <ListItem onClick={handleAssignedToMeFilter}>나한테 할당된 이슈들</ListItem>
              <ListItem onClick={handleMyCommentIssuesFilter}>내가 댓글을 남긴 이슈들</ListItem>
              <ListItem onClick={handleClosedFilter}>닫힌 이슈들</ListItem>
            </OptionSelectModal>
          </Modal>
          <InputContainer focused={focused}>
            <MGlassImg src={mGlass} />
            <OptionBox ref={optionBoxRef}></OptionBox>
            <FilterInput
              type="text"
              onFocus={handleFocus}
              onBlur={handleBlur}
              tabIndex={0}
              placeholder={isSame() ? 'Search all issues' : ''}
              onKeyPress={handleEnter}
              ref={inputRef}
            />
          </InputContainer>
        </FilterBox>
        <ControlBox>
          <LabelMilestoneControls labelCount={labels.length} milestoneCount={milestones.length} />
          <Link to="/issues/new">
            <IssueSubmitButton>New issue</IssueSubmitButton>
          </Link>
        </ControlBox>
      </SearchBox>
      {isSame() ? null : (
        <ClearContainer>
          <ClearBox onClick={handleClear}>
            <ClearIcon viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
              <path
                fillRule="evenodd"
                d="M3.72 3.72a.75.75 0 011.06 0L8 6.94l3.22-3.22a.75.75 0 111.06 1.06L9.06 8l3.22 3.22a.75.75 0 11-1.06 1.06L8 9.06l-3.22 3.22a.75.75 0 01-1.06-1.06L6.94 8 3.72 4.78a.75.75 0 010-1.06z"
              ></path>
            </ClearIcon>
            <span>Clear current search query, filters, and sorts</span>
          </ClearBox>
        </ClearContainer>
      )}
    </SearchContainer>
  );
}
