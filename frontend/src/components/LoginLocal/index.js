import React, { useState } from 'react';
import styled from 'styled-components';
import { API } from '@api';

const LoginLocalForm = styled.div`
  display: flex;
  flex-direction: column;
`;

const LoginLocalFormInputDiv = styled.div`
  display: flex;
  flex-direction: column;
`;

const LoginLocalFormLabel = styled.label`
  font-weight: bold;
  margin-bottom: 0.25em;
`;

const LoginLocalFormInput = styled.input`
  padding: 0.4em;
  margin-bottom: 1em;
  outline: none;
  border: 1px solid lightgrey;
  border-radius: 0.25rem;
`;

const LoginLocalFormButtonDiv = styled.div`
  display: flex;
  justify-content: space-around;
`;

const Button = styled.button`
  padding: 1rem;
  margin: 1rem;
  font-size: inherit;
  background-color: #29b6af;
  border: none;
  color: white;
  display: block;
  cursor: pointer;
`;

const ErrMsgSpan = styled.span`
  color: red;
`;

export function LoginLocal() {
  const [errMsg, setErrMsg] = useState(' ');

  const handleSubmit = async e => {
    e.preventDefault();

    try {
      await API.post('/api/auth/login', {
        id: e.target.id.value,
        pw: e.target.pw.value,
      });

      // TODO : Redirect to issue list page
    } catch (err) {
      setErrMsg('아이디와 비밀번호를 확인해주세요');
    }
  };

  return (
    <LoginLocalForm onSubmit={handleSubmit}>
      <LoginLocalFormInputDiv>
        <LoginLocalFormLabel htmlFor="id">아이디</LoginLocalFormLabel>
        <LoginLocalFormInput type="text" name="id" id="id" />
        <LoginLocalFormLabel htmlFor="pw">비밀번호</LoginLocalFormLabel>
        <LoginLocalFormInput type="password" name="pw" id="pw" />
        <ErrMsgSpan>{errMsg}</ErrMsgSpan>
      </LoginLocalFormInputDiv>
      <LoginLocalFormButtonDiv>
        <Button>로그인</Button>
        <Button
          type="button"
          onClick={() => {
            /*Redirect to Register page */
          }}
        >
          회원 가입
        </Button>
      </LoginLocalFormButtonDiv>
    </LoginLocalForm>
  );
}
