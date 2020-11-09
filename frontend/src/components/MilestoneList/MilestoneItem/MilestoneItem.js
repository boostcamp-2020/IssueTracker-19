import React from 'react';
import styled from 'styled-components';
import { API } from '@api';
import { flexColumn, flexCenter, flex } from '@styles/utils';
import { colors } from '@styles/variables';
import CalenderIcon from '@imgs/milestone-calendar.svg';
import ClockIcon from '@imgs/milestone-clock.svg';
const Container = styled.div`
  display: table-row;
  list-style: none;
`;
const Title = styled.div`
  width: 500px;
  display: table-cell;
  font-size: 0.75rem;
  vertical-align: top;
  padding: 15px 20px;
  border-left: 1px solid ${colors.borderColorSecondary};
  border-top: 1px solid ${colors.borderColorSecondary};
`;
const TitleHeader = styled.h2`
  margin-top: 0;
  margin-bottom: 5px;
  font-size: 1.5rem;
  font-weight: 400;
  line-height: 1.2;
`;
const Meta = styled.div`
  font-size: 14px;
`;
const MetaItem = styled.span`
  display: flex;
  align-items: flex-start;
  margin-right: 15px;
  color: ${colors.metaColor};
`;

const Img = styled.img`
  width: 16px;
  height: 16px;
  margin-right: 4px;
  padding-top: 3px;
`;
const Description = styled.div`
  font-size: 16px;
  color: '${colors.metaColor}';
`;
const Progress = styled.div`
  display: table-cell;
  font-size: 12px;
  vertical-align: top;
  border-right: 1px solid ${colors.borderColorSecondary};
  border-top: 1px solid ${colors.borderColorSecondary};
  padding: 15px 20px;
  width: 20px;
`;
export default function MilestoneItem() {
  return (
    <div>
      <Container>
        <Title>
          <TitleHeader>test</TitleHeader>
          <Meta>
            <MetaItem>
              <Img src={CalenderIcon} />
              Due by November 18, 2020
            </MetaItem>
            <Description>
              <p>Descirption</p>
            </Description>
          </Meta>
        </Title>
        <Progress></Progress>
      </Container>
    </div>
  );
}
