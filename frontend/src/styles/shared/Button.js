import styled from 'styled-components';
import { darken } from 'polished';
import { colors } from '@styles/variables';
import { flexCenter } from '@styles/common';

export const Button = styled.button`
  ${flexCenter}
  height: 2.2rem;
  padding: 0 1rem;
  font-size: 0.9rem;
  font-weight: bold;
  border-radius: 6px;
  border: none;
  box-sizing: border-box;
  cursor: pointer;
`;

export const SubmitButton = styled(Button)`
  color: white;
  background-color: ${colors.submitColor};
  border: none;
  &:hover {
    background-color: ${darken(0.02, colors.submitColor)};
  }
`;

export const CancelButton = styled(Button)`
  color: ${colors.black3};
  background-color: ${colors.semiWhite};
  border: 1px solid ${colors.lightGray};
  &:hover {
    background-color: ${darken(0.02, colors.semiWhite)};
  }
`;
