import React from 'react';
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

const getLabels = async () => {
  try {
    const { data, status } = await API.get('/api/labels');
    return data;
  } catch (err) {
    console.log(err);
  }
};

const tempLabels = JSON.parse(
  '{"labels":[{"no":1,"name":"backend","description":"backend 작업","color":"#FFFFFF"},{"no":2,"name":"frontend","description":"frontend 작업","color":"#333333"}]}',
);

export default function LabelItemBox() {
  return (
    <Box>
      <LabelHeader>8 Labels</LabelHeader>
      {tempLabels.labels.map(label => (
        <LabelItem key={label.no} {...label} />
      ))}
    </Box>
  );
}
