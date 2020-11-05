import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import { flex, calFontColor } from '@styles/utils';
import { colors } from '@styles/variables';

const Box = styled.div`
  ${flex('flex-start', 'center')};
  padding: 1rem;
  border-bottom: 2px solid ${colors.lightGray};

  &:last-child {
    border-bottom: none;
  }
`;

const NameBox = styled.div`
  flex-grow: 2;
`;

const DescBox = styled.div`
  flex-grow: 5;
`;

const ButtonBox = styled.div`
  flex-grow: 1;
  ${flex()};
  justify-content: space-around;
`;

const CustomLink = styled(Link)`
  color: ${colors.black6};
`;

// const Name = styled.span`
//   background-color: ${color};
//   color: ${calFontColor(color)};
// `;

const Name = styled.span``;

export default function LabelItem({ no, name, description, color }) {
  return (
    <Box>
      <NameBox>
        <Name style={{ backgroundColor: color, color: calFontColor(color) }}>{name}</Name>
      </NameBox>
      <DescBox>{description}</DescBox>
      <ButtonBox>
        <CustomLink to="/">Edit</CustomLink>
        <CustomLink to="/">Delete</CustomLink>
      </ButtonBox>
    </Box>
  );
}
