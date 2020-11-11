import React, { useContext } from 'react';
import styled, { css } from 'styled-components';
import { IssueDetailContext } from '@contexts/IssueDetailContext';
import { flexColumn } from '@styles/utils';
import { numerics, colors } from '@styles/variables';
import { LabelTag, OpenIcon, ClosedIcon } from '@components';

const MainContainer = styled.div`
  ${css`
    width: ${css`calc(100% - ${numerics.marginHorizontal} * 2)`};
  `}
  margin: ${numerics.marginHorizontal};
  display: flex;
`;

const TitleContainer = styled.div`
  width: 100%;
  margin-left: 10rem;
  margin-right: 5rem;
  ${flexColumn}
`;

export default function IssueDetailHeader() {
  const { issue } = useContext(IssueDetailContext);
  const { title, isOpened } = issue;

  return (
    <MainContainer>
      <TitleContainer>
        <LabelTag color={isOpened ? colors.issueGreen : colors.issueRed}>
          {isOpened ? (
            <div>
              <OpenIcon color={'white'} />
              Open
            </div>
          ) : (
            <div>
              <ClosedIcon color={'white'} />
              Closed
            </div>
          )}
        </LabelTag>
        {title}
      </TitleContainer>
    </MainContainer>
  );
}
