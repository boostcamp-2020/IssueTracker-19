import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { NotFound, Issue, Login } from './pages';

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Issue} />
        <Route path="/login" component={Login} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
