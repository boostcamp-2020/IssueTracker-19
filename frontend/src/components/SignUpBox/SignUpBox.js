import React, { useState } from 'react';
import styled from 'styled-components';
import { API } from '@api';
import { flexColumn } from '@styles/utils';
import { useHistory } from 'react-router-dom';
import { AUTH } from '@constants/index';

const SignUpArea = styled.div`
  background-color: #ecf0f1;
  ${flexColumn}
  flex: 1;
  align-items: center;
`;
const Title = styled.h1`
  color: #2d3436;
  margin-top: 2rem;
  font-size: 1.6rem;
`;
const Form = styled.form`
  width: 20rem;
  margin-top: 2rem;
  padding: 1rem 0;
  ${flexColumn}
  align-items: center;
  background-color: white;
  border-radius: 5px;
  border: 1px #b2bec3 solid;
`;
const InputBox = styled.div`
  width: 80%;
  padding: 0rem 1.5rem;
  margin-top: 1rem;
`;

const Input = styled.input`
  width: 100%;
  height: 2rem;
  padding-left: 0.5em;
  border-radius: 3px;
  border: 1px #b2bec3 solid;
`;
const SignUpButton = styled.button`
  width: 80%;
  padding: 0.7rem;
  margin: 1rem;
  background-color: #27ae60;
  border: none;
  border-radius: 3px;
  color: white;
  font-size: 1rem;
  cursor: pointer;
`;

export default function SignUpBox() {
  const [form, setForm] = useState({ id: '', nickname: '', pw: '' });
  const { id, nickname, pw } = form;

  const history = useHistory();

  const handleChange = ({ target }) => {
    const { name, value } = target;
    setForm({ ...form, [name]: value });
  };

  const handleSubmit = async e => {
    e.preventDefault();
    const data = { id, nickname, pw, auth: AUTH.DEFAULT };
    try {
      const { status } = await API.post('/api/auth/signup', data);
      if (status === 200) {
        history.push('/login');
      }
      // TODO 200 이외의 코드 에러 처리
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <SignUpArea>
      <Title>회원가입</Title>
      <Form onSubmit={handleSubmit}>
        <InputBox>
          <label>
            아이디
            <Input type="text" name="id" onChange={handleChange} value={id} required />
          </label>
        </InputBox>
        <InputBox>
          <label>닉네임</label>
          <Input type="text" name="nickname" onChange={handleChange} value={nickname} required />
        </InputBox>
        <InputBox>
          <label>비밀번호</label>
          <Input
            type="password"
            name="pw"
            onChange={handleChange}
            value={pw}
            autoComplete="true"
            required
          />
        </InputBox>
        <SignUpButton>회원가입</SignUpButton>
      </Form>
    </SignUpArea>
  );
}
