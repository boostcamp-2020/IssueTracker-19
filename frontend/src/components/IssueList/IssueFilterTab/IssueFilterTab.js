import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import { userService, labelService, milestoneService } from '@services';
import FilterBox from './FilterBox/FilterBox';
import { ListItem } from '@components';

const Container = styled.div`
  border: 1px solid gray;
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

const filterState = {
  users: [],
  labels: [],
  milestones: [],
};

export default function IssueFilterTab({ setIssues, issues, allChecked, markMode }) {
  const handleCheck = ({ target: { checked } }) => {
    setIssues(issues.map(issue => ({ ...issue, checked })));
  };

  const [filterList, setFilterList] = useState(filterState);
  const { users, labels, milestones } = filterList;

  const fetchAllDatas = async () => {
    try {
      const [
        {
          data: { users },
        },
        {
          data: { labels },
        },
        {
          data: { milestones },
        },
      ] = await Promise.all([
        userService.getUsers(),
        labelService.getLabels(),
        milestoneService.getMilestones(),
      ]);
      setFilterList({ users, labels, milestones });
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  useEffect(() => {
    fetchAllDatas();
  }, []);

  return (
    <Container>
      <input type="checkbox" onChange={handleCheck} checked={allChecked} />
      <FilterList>
        {markMode ? (
          <FilterBox name="Mark as" title="Actions">
            {['Open', 'Closed'].map((item, idx) => (
              <ListItem key={idx + item}>{item}</ListItem>
            ))}
          </FilterBox>
        ) : (
          <>
            <FilterBox name="Author" title="Filter by author">
              {users.map(({ nickname }, idx) => (
                <ListItem key={idx + nickname}>{nickname}</ListItem>
              ))}
            </FilterBox>
            <FilterBox name="Label" title="Filter by label">
              {[<ListItem key={'Unlabeled'}>{'Unlabeled'}</ListItem>].concat(
                labels.map(({ no, name, color }) => (
                  <ListItem key={no}>
                    <LabelIcon color={color} />
                    {name}
                  </ListItem>
                )),
              )}
            </FilterBox>
            <FilterBox name="Milestones" title="Filter by milestone">
              {[<ListItem key={'no-milestone'}>{'Issues with no milestone'}</ListItem>].concat(
                milestones.map(({ no, title }) => <ListItem key={no}>{title}</ListItem>),
              )}
            </FilterBox>
            <FilterBox name="Assignees" title={`Filter by who's assigned`}>
              {[<ListItem key={'nobody'}>{'Assigned to nobody'}</ListItem>].concat(
                users.map(({ nickname }, idx) => (
                  <ListItem key={idx + nickname}>{nickname}</ListItem>
                )),
              )}
            </FilterBox>
          </>
        )}
      </FilterList>
    </Container>
  );
}
