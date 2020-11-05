import React, { useEffect, useState } from 'react';
import styled from 'styled-components';
import { flex } from '@styles/utils';
import { userService } from '@services';
import FilterBox from './FilterBox/FilterBox';

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

export default function IssueFilterTab({ setIssues, issues, allChecked }) {
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
        <FilterBox name="Author" title="Filter by author" items={users} />
        <FilterBox name="Label" title="Filter by label" items={labels} />
        <FilterBox name="Milestones" title="Filter by milestone" items={milestones} />
        <FilterBox name="Assignees" title={`Filter by who's assigned`} items={users} />
      </FilterList>
    </Container>
  );
}
