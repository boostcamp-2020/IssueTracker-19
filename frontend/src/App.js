import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { NotFound, Issue, Login } from './pages';

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Login} />
        <Route path="/issues" exact component={Issue} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
