import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
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

const CustomLink = styled(Link)`
  color: ${colors.black6};
`;

export default function LabelItem({ no, name, description, color }) {
  return (
    <Box>
      <NameBox>
        <LabelTag {...{ name, color }} />
      </NameBox>
      <DescBox>{description}</DescBox>
      <ButtonBox>
        <CustomLink to="/">Edit</CustomLink>
        <CustomLink to="/">Delete</CustomLink>
      </ButtonBox>
    </Box>
  );
}
