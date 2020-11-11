import React from 'react';
import styled from 'styled-components';
import { labelService } from '@services';
import { flex } from '@styles/utils';
import { colors } from '@styles/variables';
import { LabelTag } from '@components';

const Box = styled.div`
  ${flex('flex-start', 'center')};
  padding: 1rem;
`;

const NameBox = styled.div`
  width: 30%;
`;

const DescBox = styled.div`
  width: 55%;
  font-size: 12px;
  font-weight: 400;
  color: ${colors.resetDefaultColor};
`;

const ButtonBox = styled.div`
  width: 15%;
  ${flex()};
  justify-content: space-around;
`;

const Button = styled.button`
  background-color: inherit;
  color: ${colors.resetDefaultColor};
  font-size: 12px;
  font-weight: 400;
  border: none;
  outline: none;
  cursor: pointer;
`;

export default function LabelItem({
  no,
  name,
  description,
  color,
  reloadLabels,
  setEditingLabels,
  editingLabels,
}) {
  const handleDelete = async () => {
    if (!confirm(`${name} 레이블을 삭제 하시겠습니까?`)) return;

    try {
      const { status } = await labelService.deleteLabel({
        no,
      });
      reloadLabels();
    } catch ({ response: { status } }) {}
  };

  const handleSetEditing = () => {
    setEditingLabels(new Set([...editingLabels, no]));
  };

  return (
    <Box>
      <NameBox>
        <LabelTag color={color}>{name}</LabelTag>
      </NameBox>
      <DescBox>{description}</DescBox>
      <ButtonBox>
        <Button onClick={handleSetEditing}>Edit</Button>
        <Button onClick={handleDelete}>Delete</Button>
      </ButtonBox>
    </Box>
  );
}
