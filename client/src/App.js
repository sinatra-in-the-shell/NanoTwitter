import React from 'react';
import { BrowserRouter as Router, Route, Redirect } from 'react-router-dom';
import { sessionHelper } from './helpers/session'
import SignIn from './components/user/login'
import Register from './components/user/register'
import UserHome from './components/home'

function App() {
  return (
    <Router>
      <div>
        <PrivateRoute exact path="/" component={UserHome} />
        <Route path="/login" component={SignIn} />
        <Route path='/register' component={Register} />
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
