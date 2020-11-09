import React, { useContext } from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import { colors } from '@styles/variables';
import FilterBox from './FilterBox/FilterBox';
import { ListItem } from '@components';
import { IssueContext } from '@pages';
import { issueService } from '@services';

const Container = styled.div`
  border: 1px solid ${colors.lighterGray};
  background-color: ${colors.filterTabColor};
  ${flex('space-between', 'center')}
`;

const FilterList = styled.div`
  ${flex()}
`;

const LabelIcon = styled.div`
  width: 18px;
  height: 18px;
  border-radius: 50%;
  margin-right: 0.5rem;
  background-color: ${props => props.color};
`;

const CheckBox = styled.input`
  margin: 1rem;
`;

const CheckCount = styled.span`
  font-size: 0.9rem;
`;

export default function IssueFilterTab({ setIssues, issues }) {
  const {
    filterOptions,
    setFilterOptions,
    filterOptionDatas,
    allChecked,
    selectedCount,
    selectedIssues,
  } = useContext(IssueContext);
  const { users, labels, milestones } = filterOptionDatas;

  const handleCheck = ({ target: { checked } }) => {
    if (!issues.length) return;
    setIssues(issues.map(issue => ({ ...issue, checked })));
  };

  const handleAuthorFilter = e => {
    const author = e?.target?.textContent;
    setFilterOptions({ ...filterOptions, author });
  };

  const handleMilestoneFilter = e => {
    const milestone = e?.target?.textContent ?? null;
    if (milestone === 'Issues with no milestone') {
      setFilterOptions({ ...filterOptions, milestone: null });
      return;
    }
    setFilterOptions({ ...filterOptions, milestone });
  };

  const handleAssigneeFilter = e => {
    const assignee = e?.target?.textContent;
    if (assignee === 'Assigned to nobody') {
      setFilterOptions({ ...filterOptions, assignee: null });
      return;
    }
    setFilterOptions({ ...filterOptions, assignee });
  };

  const handleLabelFilter = e => {
    const label = e?.target?.textContent;
    if (label === 'Unlabeled') {
      setFilterOptions({ ...filterOptions, label: [] });
      return;
    }
    setFilterOptions({ ...filterOptions, label: [...new Set([...filterOptions.label, label])] });
  };

  const handleOpenIssues = async () => {
    try {
      const issueNos = selectedIssues.map(i => i.no);
      const { status } = await issueService.openIssues({ issueNos });
      if (status === 200) {
        setFilterOptions({ ...filterOptions });
      }
    } catch (err) {
      console.error(err);
    }
  };

  const handleCloseIssues = async () => {
    try {
      const issueNos = selectedIssues.map(i => i.no);
      const { status } = await issueService.closeIssues({ issueNos });
      if (status === 200) {
        setFilterOptions({ ...filterOptions });
      }
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <Container>
      <div>
        <CheckBox type="checkbox" onChange={handleCheck} checked={allChecked} />
        <CheckCount>{selectedCount ? `${selectedCount} selected` : ''}</CheckCount>
      </div>
      <FilterList>
        {selectedCount ? (
          <FilterBox name="Mark as" title="Actions">
            <ListItem key={'Open'} onClick={handleOpenIssues}>
              {'Open'}
            </ListItem>
            <ListItem key={'Closed'} onClick={handleCloseIssues}>
              {'Closed'}
            </ListItem>
          </FilterBox>
        ) : (
          <>
            <FilterBox name="Author" title="Filter by author">
              {users.map(({ nickname }) => (
                <ListItem key={nickname} onClick={handleAuthorFilter}>
                  {nickname}
                </ListItem>
              ))}
            </FilterBox>
            <FilterBox name="Label" title="Filter by label">
              {[{ name: 'Unlabeled' }].concat(labels).map(({ no, name, color }) => (
                <ListItem key={no ?? name} onClick={handleLabelFilter}>
                  <LabelIcon color={color} />
                  {name}
                </ListItem>
              ))}
            </FilterBox>
            <FilterBox name="Milestones" title="Filter by milestone">
              {[{ no: 'no-milestone', title: 'Issues with no milestone' }]
                .concat(milestones)
                .map(({ no, title }) => (
                  <ListItem key={no} onClick={handleMilestoneFilter}>
                    {title}
                  </ListItem>
                ))}
            </FilterBox>
            <FilterBox name="Assignees" title={`Filter by who's assigned`}>
              {[{ nickname: 'Assigned to nobody' }].concat(users).map(({ nickname }) => (
                <ListItem key={nickname} onClick={handleAssigneeFilter}>
                  {nickname}
                </ListItem>
              ))}
            </FilterBox>
          </>
        )}
      </FilterList>
    </Container>
  );
}
