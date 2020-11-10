import React, { useState, useEffect } from 'react';
import { API } from '@api';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flexColumn } from '@styles/utils';
import LabelItem from './LabelItem/LabelItem';
import LabelEditBox from './LabelEditBox/LabelEditBox';

const Box = styled.div`
  ${flexColumn};
  margin-top: 2rem;
`;

const TopBox = styled.div`
  border: 2px solid ${colors.lightGray};
  border-radius: 0.25rem;
`;

const BottomBox = styled.div`
  margin-top: 2rem;
  ${flexColumn};
  border: 2px solid ${colors.lightGray};
  border-radius: 0.25rem;

  & > * {
    border-bottom: 2px solid ${colors.lightGray};
  }

  & > *:last-child {
    border-bottom: none;
  }
`;

const LabelHeader = styled.div`
  padding: 1rem;
  background-color: ${colors.lightestGray};
`;

export default function LabelItemBox() {
  const [labels, setLabels] = useState([]);
  const [newOpened, setNewOpened] = useState(true);
  const [editingLabels, setEditingLabels] = useState(new Set());

  const getLabels = async () => {
    try {
      const { data, status } = await API.get('/api/labels');
      setLabels(data.labels);
    } catch (err) {
      console.log(err);
      // TODO : if error 401, redirect to login page
    }
  };

  const handleNewOpened = () => {
    setNewOpened(!newOpened);
  };

  useEffect(() => {
    getLabels();
  }, []);

  return (
    <Box>
      {newOpened ? (
        <TopBox>
          <LabelEditBox reloadLabels={getLabels} />
        </TopBox>
      ) : null}

      <BottomBox>
        <LabelHeader>8 Labels</LabelHeader>

        {labels.map(label => {
          if (editingLabels.has(label.no))
            return (
              <LabelEditBox
                key={label.no}
                reloadLabels={getLabels}
                {...label}
                setEditingLabels={setEditingLabels}
                editingLabels={editingLabels}
              />
            );
          else
            return (
              <LabelItem
                key={label.no}
                {...label}
                reloadLabels={getLabels}
                setEditingLabels={setEditingLabels}
                editingLabels={editingLabels}
              />
            );
        })}
      </BottomBox>
    </Box>
  );
}
