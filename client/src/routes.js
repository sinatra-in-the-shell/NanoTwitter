import React from 'react';
import { BrowserRouter as Router, Route, Redirect } from 'react-router-dom';
import SignIn from './components/user/login'
import Feed from './components/user/feed'
import Register from './components/user/register'
import { sessionHelper } from './helpers/session'

function Routes() {
  return (
    <Router>
      <div>
        <Route exact path="/login" component={SignIn} />
        <Route path='/register' component={Register} />
        <PrivateRoute path="/feed" component={Feed} />
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

export default Routes;
