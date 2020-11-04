import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { NotFound, Issue, Login, Label } from './pages';

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Issue} />
        <Route path="/login" component={Login} />
        <Route path="/labels" component={Label} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
