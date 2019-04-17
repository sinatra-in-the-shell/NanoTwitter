import React from 'react';
import { Router, Route, Redirect } from 'react-router';
import { createBrowserHistory } from "history";

import { sessionHelper } from './helpers/session'
import SignIn from './components/login'
import Register from './components/register'
import UserHome from './components/home'
import UserMain from './components/userMain'
import Search from './components/search'
import Status from './components/test/status'

export const history = createBrowserHistory();

function App() {
  console.log(history);
  return (
    <Router history={history}>
      <div>
        <PrivateRoute exact path="/" component={UserHome} />
        <PrivateRoute path="/u/:username" component={UserMain} />
        <PrivateRoute path="/search" component={Search} />
        <Route path="/login" component={SignIn} />
        <Route path='/register' component={Register} />
        <Route path='/test/status' component={Status} />
      </div>
    </Router>
  )
}

function PrivateRoute({ component: Component, ...rest }) {
  return (
    <Route {...rest}
      render={props =>
        sessionHelper.isLoggedIn() ? (
          <Component {...props} />
        ) : (
          <Redirect
            to={{
              pathname: "/login",
              state: { from: props.location }
            }}
          />
        )
      }
    />
  );
}

export default App;
