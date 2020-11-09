import React from 'react';
import styled from 'styled-components';
import { flex, flexColumn, calFontColor } from '@styles/utils';
import { colors } from '@styles/variables';
import { LabelTag } from '@components';
import { SubmitButton, CancelButton } from '@shared';

const Box = styled.div`
  ${flexColumn};
  background-color: ${colors.lightestGray};
  padding: 1.5rem;
`;

const InputLabel = styled.label`
  font-weight: bold;
`;

const InputBox = styled.input`
  padding: 0.25em;
  font-size: inherit;
  border: 1px solid ${colors.lightGray};
  border-radius: 2px;
  outline: none;

  &:focus {
    border: 1px solid skyblue;
    box-shadow: 0 0 5px 0 skyblue;
  }
`;

const EditHeader = styled.div`
  ${flex('space-between')}
  margin-bottom: 1.5rem;
`;

const EditBody = styled.div`
  ${flex('space-between')}
`;

const ItemBox = styled.div`
  ${flexColumn}
`;

const ItemBoxRow = styled.div`
  ${flex}
  margin-top: ${props => (props.marginTop ? 'auto' : 0)}
`;

const DeleteButton = styled.button`
  margin: auto;
  outline: none;
  border: none;
  cursor: pointer;
`;

export default function LabelEditBox({
  no = 1,
  name = 'Label preview',
  description,
  color = '#246',
}) {
  return (
    <Box>
      <EditHeader>
        <ItemBox>
          <LabelTag {...{ name, color }} />
        </ItemBox>
        <ItemBox>{no ? <DeleteButton>Delete</DeleteButton> : null}</ItemBox>
      </EditHeader>
      <EditBody>
        <ItemBox>
          <InputLabel>Label Name</InputLabel>
          <InputBox />
        </ItemBox>
        <ItemBox>
          <InputLabel>Description</InputLabel>
          <InputBox />
        </ItemBox>
        <ItemBox>
          <InputLabel>Color</InputLabel>
          <ItemBoxRow>
            <button>
              <svg viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
                <path
                  fill-rule="evenodd"
                  d="M8 2.5a5.487 5.487 0 00-4.131 1.869l1.204 1.204A.25.25 0 014.896 6H1.25A.25.25 0 011 5.75V2.104a.25.25 0 01.427-.177l1.38 1.38A7.001 7.001 0 0114.95 7.16a.75.75 0 11-1.49.178A5.501 5.501 0 008 2.5zM1.705 8.005a.75.75 0 01.834.656 5.501 5.501 0 009.592 2.97l-1.204-1.204a.25.25 0 01.177-.427h3.646a.25.25 0 01.25.25v3.646a.25.25 0 01-.427.177l-1.38-1.38A7.001 7.001 0 011.05 8.84a.75.75 0 01.656-.834z"
                ></path>
              </svg>
            </button>
            <InputBox />
          </ItemBoxRow>
        </ItemBox>
        <ItemBoxRow marginTop={true}>
          <CancelButton>Cancel</CancelButton>
          <SubmitButton>{no ? 'Save changes' : 'Create Label'}</SubmitButton>
        </ItemBoxRow>
      </EditBody>
    </Box>
  );
}
