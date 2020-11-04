import React, { useState } from 'react';
import styled from 'styled-components';
import { API } from '@api';
import { flexColumn } from '@styles/utils';
import { useHistory } from 'react-router-dom';
import { AUTH } from '@constants/index';

const SignUpArea = styled.div`
  background-color: #ecf0f1;
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: center;
`;
const Title = styled.h1`
  color: #2d3436;
  margin-top: 2rem;
  font-size: 2.5rem;
`;
const Box = styled.form`
  width: 35%;
  margin-top: 2rem;
  ${flexColumn}
  align-items: center;
  background-color: white;
  border-radius: 5px;
  border: 1px #b2bec3 solid;
`;
const Input = styled.div`
  width: 80%;
  padding: 0rem 1.5rem;
`;
const InputText = styled.div`
  padding: 1.5rem 1rem 0.5rem 0rem;
`;
const InputTextBox = styled.input`
  width: 100%;
  height: 2rem;
  margin: 0rem 0rem;
  padding-left: 0.5em;
  border-radius: 3px;
  border: 1px #b2bec3 solid;
`;
const SignUpButton = styled.button`
  width: 80%;
  padding: 0.7rem;
  margin: 2rem;
  background-color: #27ae60;
  border: none;
  border-radius: 3px;
  color: white;
  font-size: 1.3rem;
  cursor: pointer;
`;

export default function SignUpBox() {
  const [form, setForm] = useState({ id: '', nickname: '', pw: '' });

  const history = useHistory();

  const handleChange = ({ target }) => {
    const { name, value } = target;
    setForm({ ...form, [name]: value });
  };
  const SubmitData = async e => {
    e.preventDefault();
    const data = {
      id: form.id,
      nickname: form.nickname,
      pw: form.pw,
      auth: AUTH.DEFAULT,
    };
    try {
      const { status } = await API.post('/api/auth/signup', data);
      if (status === 200) {
        history.push('/login');
      }
    } catch (err) {
      console.error(err);
    }
  };
  return (
    <SignUpArea>
      <Title>회원가입</Title>
      <Box>
        <Input>
          <InputText>아이디</InputText>
          <InputTextBox type="text" name="id" onChange={handleChange} value={form.id} />
        </Input>
        <Input>
          <InputText>닉네임</InputText>
          <InputTextBox type="text" name="nickname" onChange={handleChange} value={form.nickname} />
        </Input>
        <Input>
          <InputText>비밀번호</InputText>
          <InputTextBox type="password" name="pw" onChange={handleChange} value={form.pw} />
        </Input>
        <SignUpButton onClick={SubmitData}>회원가입</SignUpButton>
      </Box>
    </SignUpArea>
  );
}
