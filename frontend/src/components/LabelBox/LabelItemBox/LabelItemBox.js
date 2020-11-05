import React, { useState } from 'react';
import { API } from '@api';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flexColumn } from '@styles/utils';
import LabelItem from './LabelItem/LabelItem';

const Box = styled.div`
  ${flexColumn};
  margin-top: 2rem;
  border: 2px solid ${colors.lightGray};
  border-radius: 0.25rem;
`;

const LabelHeader = styled.div`
  padding: 1rem;
  border-bottom: 2px solid ${colors.lightGray};

  &:last-child {
    border-bottom: none;
  }
`;

const tempLabels = JSON.parse(
  '{"labels":[{"no":1,"name":"backend","description":"backend 작업","color":"#FFFFFF"},{"no":2,"name":"frontend","description":"frontend 작업","color":"#333333"}]}',
);

export default function LabelItemBox() {
  const [fetched, setFetched] = useState(false);
  const [labels, setLabels] = useState([]);

  const getLabels = async () => {
    try {
      const { data, status } = await API.get('/api/labels');
      setFetched(true);
      setLabels(data.labels);
    } catch (err) {
      console.log(err);
      // TODO : if error 401, redirect to login page
    }
  };

  if (!fetched) getLabels();

  return (
    <Box>
      <LabelHeader>8 Labels</LabelHeader>
      {labels.map(label => (
        <LabelItem key={label.no} {...label} />
      ))}
    </Box>
  );
}
