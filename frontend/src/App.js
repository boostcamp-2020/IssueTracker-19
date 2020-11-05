import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { NotFound, Issue, Login, SignUp, MilestoneNew } from './pages';

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Issue} />
        <Route path="/login" component={Login} />
        <Route path="/signup" component={SignUp} />
        <Route path="/milestone/new" component={MilestoneNew} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
