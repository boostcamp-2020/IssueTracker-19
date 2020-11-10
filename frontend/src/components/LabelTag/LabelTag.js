import React from 'react';
import styled from 'styled-components';
import { calcFontColor } from '@styles/utils';

const Tag = styled.span`
  padding: 0.25em 0.7em;
  border-radius: 999em;
`;

export default function LabelTag({ name, color, size = '1rem' }) {
  return (
    <Tag style={{ backgroundColor: color, color: calcFontColor(color), fontSize: size }}>
      {name}
    </Tag>
  );
}
