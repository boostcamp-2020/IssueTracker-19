import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import { userService } from '@services';
import FilterBox from './FilterBox/FilterBox';
import { ListBox, ListItem } from '@components';

const Container = styled.div`
  border: 1px solid gray;
  ${flex('space-between', 'center')}
`;

const FilterList = styled.div`
  ${flex()}
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
      ] = await Promise.all([userService.getUsers()]);
      setFilterList({ ...filterList, users });
    } catch ({ response: { status } }) {
      if (status === 401) {
        history.push('/login');
      }
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
            <FilterBox name="Label" title="Filter by label"></FilterBox>
            <FilterBox name="Milestones" title="Filter by milestone"></FilterBox>
            <FilterBox name="Assignees" title={`Filter by who's assigned`}>
              {users.map(({ nickname }, idx) => (
                <ListItem key={idx + nickname}>{nickname}</ListItem>
              ))}
            </FilterBox>
          </>
        )}
      </FilterList>
    </Container>
  );
}
