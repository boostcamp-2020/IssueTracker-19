import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { withAuth } from '@hoc';
import {
  NotFound,
  Issue,
  IssueNew,
  Login,
  SignUp,
  Label,
  Milestone,
  MilestoneNew,
  MilestoneEdit,
} from './pages';

const App = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact render={() => withAuth(Issue)} />
        <Route path="/issues/new" exact render={() => withAuth(IssueNew)} />
        <Route path="/login" component={Login} />
        <Route path="/signup" component={SignUp} />
        <Route path="/labels" render={() => withAuth(Label)} />
        <Route path="/milestones" exact render={() => withAuth(Milestone)} />
        <Route path="/milestones/new" render={() => withAuth(MilestoneNew)} />
        <Route path="/milestones/:no" render={() => withAuth(MilestoneEdit)} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
