import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import SignIn from './components/user/login'
import Feed from './components/user/feed'

function Routes() {
  return (
    <Router>
      <div>
        <Route exact path="/login" component={SignIn} />
        <Route path="/feed" component={Feed} />
      </div>
    </Router>
  )
}

export default Routes;
