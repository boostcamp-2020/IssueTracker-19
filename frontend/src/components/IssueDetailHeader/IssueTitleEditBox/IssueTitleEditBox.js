import React, { useContext, useState } from 'react';
import styled from 'styled-components';
import { flex, skyblueBoxShadow } from '@styles/utils';
import { colors } from '@styles/variables';
import { CancelButton } from '@shared';
import { issueService } from '@services';
import { useHistory } from 'react-router-dom';
import { IssueDetailContext } from '@contexts';

const Form = styled.form`
  ${flex('flex-start', 'center')}
`;

const EditInput = styled.input`
  ${flex()}
  flex:1;
  font-size: 1rem;
  outline: 0;
  padding: 0.4rem 0 0.4rem 0.4rem;
  border-radius: 5px;
  box-sizing: border-box;
  border: 1px solid ${colors.lighterGray};
  background-color: ${colors.semiWhite};
  &:focus {
    ${skyblueBoxShadow}
  }
`;

const Cancel = styled.span`
  border: none;
  color: ${colors.resetFilterColor};
  font-weight: 200;
  padding: 0 0.7rem;
  cursor: pointer;
  &:hover {
    text-decoration: underline;
  }
`;

const Save = styled(CancelButton)`
  margin-left: 1rem;
`;

export default function IssueTitleEditBox({ setEditMode, prevTitle }) {
  const [title, setTitle] = useState(prevTitle);
  const history = useHistory();
  const { issue, fetchIssueDetails } = useContext(IssueDetailContext);

  const handleChange = e => {
    const { value } = e.target;
    setTitle(value);
  };

  const handleSubmit = async e => {
    e.preventDefault();
    try {
      const { status } = await issueService.changeIssueTitle({ no: issue.no, title });
      if (status === 200) {
        setEditMode(false);
        fetchIssueDetails();
      }
    } catch (err) {
      if (err?.response?.status === 401) {
        history.push('/login');
      }
      console.error(err);
    }
  };

  return (
    <Form onSubmit={handleSubmit}>
      <EditInput value={title} onChange={handleChange} />
      <Save>Save</Save>
      <Cancel type="button" onClick={() => setEditMode(false)}>
        Cancel
      </Cancel>
    </Form>
  );
}
