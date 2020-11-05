import React, { useState, useRef } from 'react';
import styled from 'styled-components';
import downArrowIcon from '@imgs/down-arrow.svg';
import { colors } from '@styles/variables';
import { OptionSelectModal } from '@components';

const FilterContainer = styled.div`
  position: relative;
  padding: 1rem 1.5rem;
  margin-right: 0.2rem;
`;

const FilterButton = styled.div`
  cursor: pointer;
`;

const FilterText = styled.span`
  color: ${colors.black5};
  &:hover {
    color: ${colors.black1};
  }
`;

const ArrowImg = styled.img`
  width: 8px;
  height: 8px;
  margin-left: 5px;
`;

const Modal = styled.div`
  position: absolute;
  top: 3rem;
  right: 1rem;
  outline: 0;
  z-index: 2;
`;

export default function FilterBox({ items, name, title }) {
  const modal = useRef();

  const [visiable, setVisiable] = useState(false);

  const openModal = () => {
    setVisiable(true);
    modal.current.focus();
  };

  const closeAuthorModal = () => setVisiable(false);

  return (
    <FilterContainer>
      <FilterButton onClick={openModal}>
        <FilterText>{name}</FilterText>
        <ArrowImg src={downArrowIcon} />
      </FilterButton>
      <Modal tabIndex={0} ref={modal} onBlur={closeAuthorModal}>
        <OptionSelectModal
          visiable={visiable}
          setVisiable={setVisiable}
          title={title}
          items={items}
        />
      </Modal>
    </FilterContainer>
  );
}
