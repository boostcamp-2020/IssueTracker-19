import React from 'react';
import styled from 'styled-components';
import { flex, flexColumn, calFontColor } from '@styles/utils';
import { colors } from '@styles/variables';

const Box = styled.div`
  ${flexColumn};
  background-color: ${colors.lightGray};
`;

const EditHeader = styled.div`
  ${flex('space-between')}
`;

const EditBody = styled.div`
  ${flex('space-between')}
`;

const ItemBox = styled.div`
  ${flexColumn}
`;

export default function LabelEditBox({ no, name, description, color }) {
  return (
    <Box>
      <EditHeader>
        <ItemBox>{/* 레이블 미리보기 */}</ItemBox>
        <ItemBox>{/* 지우기 버튼 */}</ItemBox>
      </EditHeader>
      <EditBody>
        <ItemBox>{/* 이름 */}</ItemBox>
        <ItemBox>{/* 설명 */}</ItemBox>
        <ItemBox>{/* 색 */}</ItemBox>
        <ItemBox>{/* 버튼들 */}</ItemBox>
      </EditBody>
    </Box>
  );
}
