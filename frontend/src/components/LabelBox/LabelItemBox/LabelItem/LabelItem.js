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
`;

const ButtonBox = styled.div`
  width: 15%;
  ${flex()};
  justify-content: space-around;
`;

const Button = styled.button`
  background-color: inherit;
  color: ${colors.black6};
  border: none;
  outline: none;
  cursor: pointer;
`;

export default function LabelItem({ no, name, description, color, reloadLabels }) {
  const handleDelete = async e => {
    if (!confirm(`${name} 레이블을 삭제 하시겠습니까?`)) return;

    try {
      const { status } = await labelService.deleteLabel({
        no,
      });
      reloadLabels();
    } catch ({ response: { status } }) {}
  };

  return (
    <Box>
      <NameBox>
        <LabelTag {...{ name, color }} />
      </NameBox>
      <DescBox>{description}</DescBox>
      <ButtonBox>
        <Button>Edit</Button>
        <Button onClick={handleDelete}>Delete</Button>
      </ButtonBox>
    </Box>
  );
}
