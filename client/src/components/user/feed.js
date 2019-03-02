import React from 'react';
import Button from '@material-ui/core/Button';

import { sessionHelper } from '../../helpers/session';
import { withRouter } from "react-router-dom";

function Feed() {
  return (
    <div>
      <h1>Successful</h1>
      <LogoutButton />
    </div>
  )
}

const LogoutButton = withRouter(
  ({ history }) =>
    sessionHelper.isLoggedIn() ? (
      <Button
        type="submit"
        variant="contained"
        color="primary"
        onClick={(e)=>{
          e.preventDefault();
          sessionHelper.logout();
          history.push("/login");
        }}
      >
        Sign out
      </Button>
    ) : (
      <Button
        variant="contained"
        color="primary"
      >
        Sign out
      </Button>
    )
);

export default Feed;
