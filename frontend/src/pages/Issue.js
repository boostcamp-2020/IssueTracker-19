import React, { useState, useEffect, createContext } from 'react';
import styled from 'styled-components';
import { Header, IssueList, IssueSearchBox } from '@components';
import { numerics } from '@styles/variables';
import { issueService, userService, labelService, milestoneService } from '@services';
import { useHistory } from 'react-router-dom';
import axios from 'axios';

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
  const source = axios.CancelToken.source();
  const history = useHistory();
  const [filterOptions, setFilterOptions] = useState({ ...initialFilterOptions, isOpened: 1 });
  const [issues, setIssues] = useState([]);
  const [filterOptionDatas, setFilterOptionDatas] = useState({
    users: [],
    labels: [],
    milestones: [],
  });

  const allChecked = issues.every(i => i.checked) && issues.length;
  const selectedIssues = issues.filter(i => i.checked);

  const setFilterdIssues = async options => {
    try {
      const {
        data: { issues },
        status,
      } = await issueService.getIssues(options, { cancelToken: source.token });
      if (status === 200) {
        setIssues(issues.map(issue => ({ ...issue, checked: 0 })));
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

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
        userService.getUsers({ cancelToken: source.token }),
        labelService.getLabels({ cancelToken: source.token }),
        milestoneService.getMilestones({ cancelToken: source.token }),
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
    return () => {
      source.cancel('fetchFilterOptionDatas 요청 취소');
    };
  }, []);

  useEffect(() => {
    setFilterdIssues(filterOptions);
    return () => {
      source.cancel('filter Options 요청 취소');
    };
  }, [filterOptions]);

  return (
    <IssueContext.Provider
      value={{
        filterOptions,
        setFilterOptions,
        filterOptionDatas,
        selectedIssues,
        selectedCount: selectedIssues.length,
        allChecked,
      }}
    >
      <Header />
      <IssueContainer>
        <IssueSearchBox />
        <IssueList issues={issues} setIssues={setIssues} />
      </IssueContainer>
    </IssueContext.Provider>
  );
}
