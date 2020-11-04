import React, { useState } from 'react';
import styled from 'styled-components';
import { API } from '@api';
import { flex, flexCenter, flexColumn } from '@styles/utils';

const LoginForm = styled.form`
  display: flex;
  flex-direction: column;
`;

const InputBox = styled.div`
  display: flex;
  flex-direction: column;
`;

const Label = styled.label`
  font-weight: bold;
  margin-bottom: 0.25em;
`;

const Input = styled.input`
  padding: 0.4em;
  margin-bottom: 1em;
  outline: none;
  border: 1px solid lightgrey;
  border-radius: 0.25rem;
`;

const ButtonBox = styled.div`
  display: flex;
  justify-content: space-around;
`;

const Button = styled.button`
  padding: 1rem;
  margin: 1rem;
  display: block;
  font-size: inherit;
  font-weight: bold;
  border: none;
  cursor: pointer;
`;

const LoginButton = styled(Button)`
  background-color: #29b6af;
  color: white;
`;

const SignupButton = styled(Button)`
  color: #29b6af;
  border: 1.5px solid #29b6af;
  background-color: white;
`;

const ErrMsgSpan = styled.span`
  color: red;
`;

export default function LocalBox() {
  const [errMsg, setErrMsg] = useState(' ');
  const [form, setForm] = useState({ id: '', pw: '' });

  const handleSubmit = async e => {
    e.preventDefault();
    try {
      const { status } = await API.post('/api/auth/login', { id, pw });
      console.log(status);
      // TODO : Redirect to issue list page
    } catch (err) {
      setErrMsg('아이디와 비밀번호를 확인해주세요');
    }
  };

  const handleInputChange = ({ target }) => {
    const { name, value } = target;
    setForm({ ...form, [name]: value });
  };

  const handleSignup = e => {
    e.preventDefault();
    // TODO : 회원가입 처리 구현
  };

  const { id, pw } = form;

  return (
    <LoginForm onSubmit={handleSubmit}>
      <InputBox>
        <Label htmlFor="id">아이디</Label>
        <Input name="id" type="text" onChange={handleInputChange} value={id} />
        <Label htmlFor="pw">비밀번호</Label>
        <Input name="pw" type="password" onChange={handleInputChange} value={pw} />
        <ErrMsgSpan>{errMsg}</ErrMsgSpan>
      </InputBox>
      <ButtonBox>
        <LoginButton>로그인</LoginButton>
        <SignupButton onClick={handleSignup}>회원 가입</SignupButton>
      </ButtonBox>
    </LoginForm>
  );
}
