import React from 'react';
import styled from 'styled-components';
import { calcFontColor } from '@styles/utils';

const Tag = styled.span`
  padding: 0.25em 0.7em;
  border-radius: 999em;

  background-color: ${props => props.color};
  color: ${props => calcFontColor(props.color)};
  font-size: ${props => props.size};
`;

export default function LabelTag({ name, color, size = '1rem' }) {
  return (
    <Tag color={color} size={size}>
      {name ? name : 'Label preview'}
    </Tag>
  );
}
