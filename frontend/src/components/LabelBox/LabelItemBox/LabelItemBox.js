import React, { useState, useEffect, useContext } from 'react';
import { API } from '@api';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import { flexColumn } from '@styles/utils';
import LabelItem from './LabelItem/LabelItem';
import LabelEditBox from './LabelEditBox/LabelEditBox';
import { LabelBoxContext } from '@components/LabelBox/LabelBoxContext';

const Box = styled.div`
  ${flexColumn};
  margin-top: 1.25rem;
`;

const TopBox = styled.div`
  border-radius: 6px 6px 0 0;
`;

const BottomBox = styled.div`
  ${flexColumn};
  border: 1px solid ${colors.lighterGray};
  border-radius: 6px 6px 0 0;

  & > * {
    border-bottom: 1px solid ${colors.lighterGray};
  }

  & > *:last-child {
    border-bottom: none;
  }
`;

const LabelHeader = styled.div`
  padding: 16px;
  background-color: ${colors.filterTabColor};
  font-size: 14px;
  font-weight: 600;
  border-radius: 6px 6px 0 0;
`;

export default function LabelItemBox() {
  const [labels, setLabels] = useState([]);
  const [editingLabels, setEditingLabels] = useState(new Set());
  const { isAdding } = useContext(LabelBoxContext);

  const getLabels = async () => {
    try {
      const { data, status } = await API.get('/api/labels');
      setLabels(data.labels);
    } catch (err) {
      console.log(err);
      // TODO : if error 401, redirect to login page
    }
  };

  useEffect(() => {
    getLabels();
  }, []);

  return (
    <Box>
      {isAdding ? (
        <TopBox>
          <LabelEditBox isNew={true} reloadLabels={getLabels} />
        </TopBox>
      ) : null}

      <BottomBox>
        <LabelHeader>{labels.length} Labels</LabelHeader>

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
