import React from 'react';
import styled from 'styled-components';

const App = () => {
  return (
    <div className="container">
      <Button>styled-components!!</Button>
    </div>
  );
};

const Button = styled.button`
  padding: 1rem;
  background-color: #29b6af;
  border: none;
  color: white;
  cursor: pointer;
`;

export default App;
