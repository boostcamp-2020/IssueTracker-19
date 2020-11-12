import React from 'react';
import styled, { css } from 'styled-components';
import { calcFontColor } from '@styles/utils';

const Tag = styled.span`
  ${props =>
    props.display &&
    css`
      display: ${props.display};
    `}
  padding: 0.25em 0.7em;
  border-radius: 999em;
  background-color: ${props => props.color};
  color: ${props => calcFontColor(props.color)};
  font-size: ${props => props.size};
  font-weight: 500;
`;

export default function LabelTag({ color, size = '1rem', children, display }) {
  return (
    <Tag color={color} size={size} display={display}>
      {children}
    </Tag>
  );
}
