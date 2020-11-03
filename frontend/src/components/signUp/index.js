import React, { useState } from 'react';
import styled from 'styled-components';
import { API } from '@api';

export const SignUp = () => {
  const [ID, setID] = useState('');
  const [nickname, setNickname] = useState('');
  const [password, setPassword] = useState('');

  const handleChangeId = e => {
    setID(e.target.value);
  };
  const handleChangeNickname = e => {
    setNickname(e.target.value);
  };
  const handleChangePassword = e => {
    setPassword(e.target.value);
  };
  const SubmitData = async () => {};
  return (
    <Background>
      <SignUpArea>
        <Title>회원가입</Title>
        <SignUpBox>
          <Input>
            <InputText>아이디</InputText>
            <InputTextBox type="text" onChange={handleChangeId} />
          </Input>
          <Input>
            <InputText>닉네임</InputText>
            <InputTextBox type="text" onChange={handleChangeNickname} />
          </Input>
          <Input>
            <InputText>비밀번호</InputText>
            <InputTextBox type="password" onChange={handleChangePassword} />
          </Input>
          <SignUpButton>회원가입</SignUpButton>
        </SignUpBox>
      </SignUpArea>
    </Background>
  );
};

const Background = styled.body`
  background-color: #ecf0f1;
`;
const SignUpArea = styled.div`
  display: flex;
  padding: 8rem;
  flex-direction: column;
  align-items: center;
`;
const Title = styled.h1`
  color: #2d3436;

  font-size: 2.5rem;
`;
const SignUpBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;

  width: 40%;

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
  margin: 0rem 0rem;
  padding-left: 0.5em;

  width: 100%;
  height: 2rem;

  border-radius: 3px;
  border: 1px #b2bec3 solid;
`;
const SignUpButton = styled.button`
  padding: 0.7rem;
  margin: 2rem;

  width: 80%;
  background-color: #29b6af;
  border: none;
  border-radius: 3px;
  color: white;

  font-size: 1.3rem;

  cursor: pointer;
`;
