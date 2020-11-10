import styled from 'styled-components';
import { flex } from '@styles/utils';
import { colors } from '@styles/variables';

export const ListItem = styled.div`
  ${flex('flex-start', 'center')}
  font-size: 0.8rem;
  padding: 0.5rem 0 0.5rem 0.7rem;
  border-bottom: 1px solid ${colors.lightGray};
  cursor: pointer;
`;
