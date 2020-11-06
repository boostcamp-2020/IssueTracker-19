import React from 'react';
import styled from 'styled-components';
import { colors } from '@styles/variables';
import closeDarkIcon from '@imgs/close-dark.svg';
import { flex } from '@styles/utils';

const Container = styled.div`
  width: 18.5rem;
  border: 1px solid ${colors.lightGray};
  border-radius: 5px;
  background-color: white;
  color: ${colors.black4};
`;

const Header = styled.div`
  font-size: 0.8rem;
  font-weight: bold;
  border-bottom: 1px solid ${colors.lightGray};
  padding: 0.5rem 0 0.5rem 0.5rem;
  ${flex('space-between', 'center')}
`;

const CloseImg = styled.img`
  width: 1.1rem;
  height: 1.1rem;
  margin-right: 0.4rem;
  cursor: pointer;
`;

const ListBox = styled.div`
  max-height: 20rem;
  overflow-y: scroll;
`;

const ListItem = styled.div`
  font-size: 0.8rem;
  padding: 0.5rem 0 0.5rem 0.7rem;
  border-bottom: 1px solid ${colors.lightGray};
  cursor: pointer;
`;

export default function OptionSelectModal({ visiable, setVisiable, title, items }) {
  const handleClose = () => {
    setVisiable(false);
  };

  return (
    <>
      {visiable ? (
        <Container>
          <Header>
            <span>{title}</span>
            <CloseImg src={closeDarkIcon} onClick={handleClose} />
          </Header>
          {/* TODO 여기서 ListBox를 외부에서 주입받아야 함. Author, Label,.. 등등 각각의 값이 다름 */}
          <ListBox>
            {items.map(({ nickname }, idx) => (
              <ListItem key={idx}>{nickname}</ListItem>
            ))}
          </ListBox>
        </Container>
      ) : null}
    </>
  );
}
