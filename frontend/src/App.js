import React from 'react';
import styled from 'styled-components';
import { API } from '@api';

const App = () => {
  const handleLogout = async e => {
    e.preventDefault();
    const { data, status } = await API.post('/api/auth/logout');
    console.log('logout', data, status);
  };

  return (
    <div className="container">
      <Button>
        <a href="/api/auth/github">github 로그인</a>
      </Button>
      <LogoutButton onClick={handleLogout}>로그아웃</LogoutButton>
    </div>
  );
};

const Button = styled.button`
  padding: 1rem;
  margin: 1rem;
  background-color: #29b6af;
  border: none;
  color: white;
  display: block;
  cursor: pointer;
`;

const LogoutButton = styled.button`
  padding: 1rem;
  margin: 1rem;
  color: #29b6af;
  border: 1px solid #29b6af;
  background-color: white;
  display: block;
  cursor: pointer;
`;

export default App;
