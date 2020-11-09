import React, { useState, useEffect, createContext } from 'react';
import styled from 'styled-components';
import { Header, IssueList, IssueSearchBox } from '@components';
import { numerics } from '@styles/variables';
import { issueService, userService, labelService, milestoneService } from '@services';
import { useHistory } from 'react-router-dom';

const IssueContainer = styled.div`
  ${`width: calc(100% - ${numerics.marginHorizontal} * 2)`};
  margin: ${numerics.marginHorizontal};
`;

export const initialFilterOptions = {
  isOpened: null,
  author: null,
  label: [],
  milestone: null,
  assignee: null,
  keyword: null,
  comment: null,
};

export const IssueContext = createContext();

export default function Issue() {
  const history = useHistory();
  const [filterOptions, setFilterOptions] = useState({ ...initialFilterOptions, isOpened: 1 });
  const [issues, setIssues] = useState([]);
  const [filterOptionDatas, setFilterOptionDatas] = useState({
    users: [],
    labels: [],
    milestones: [],
  });

  const allChecked = issues.every(i => i.checked) && issues.length;
  const selectedCount = issues.reduce((acc, cur) => acc + cur.checked, 0);

  const setFilterdIssues = async options => {
    try {
      const {
        data: { issues },
        status,
      } = await issueService.getIssues(options);
      if (status === 200) {
        setIssues(issues.map(issue => ({ ...issue, checked: false })));
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  useEffect(() => {
    setFilterdIssues(filterOptions);
  }, [filterOptions]);

  const fetchFilterOptionDatas = async () => {
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
      setFilterOptionDatas({ users, labels, milestones });
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  useEffect(() => {
    fetchFilterOptionDatas();
  }, []);

  return (
    <IssueContext.Provider value={{ filterOptions, setFilterOptions, filterOptionDatas }}>
      <Header />
      <IssueContainer>
        <IssueSearchBox />
        <IssueList
          issues={issues}
          setIssues={setIssues}
          allChecked={allChecked}
          selectedCount={selectedCount}
        />
      </IssueContainer>
    </IssueContext.Provider>
  );
}
