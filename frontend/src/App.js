import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { withAuth } from '@hoc';
import {
  NotFound,
  Issue,
  IssueNew,
  IssueDetail,
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
        <Route path="/" exact component={withAuth(Issue)} />
        <Route path="/issues/new" exact component={withAuth(IssueNew)} />
        <Route path="/issues/:issueNo" component={withAuth(IssueDetail)} />
        <Route path="/login" component={Login} />
        <Route path="/signup" component={SignUp} />
        <Route path="/labels" component={withAuth(Label)} />
        <Route path="/milestones" exact component={withAuth(Milestone)} />
        <Route path="/milestones/new" component={withAuth(MilestoneNew)} />
        <Route path="/milestones/:no" component={withAuth(MilestoneEdit)} />
        <Route component={NotFound} />
      </Switch>
    </BrowserRouter>
  );
};

export default App;
