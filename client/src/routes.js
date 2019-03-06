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
        <Route path='/test/status' component={Status} />
        <PrivateRoute path="/feed" component={Feed} />
      </div>
    </Router>
  )
}
4/BQFLy_kO_rJ50-EMhl1WQ0_NwoYF5VFj2irDbJDGCxs38C97gdSlKm4
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
