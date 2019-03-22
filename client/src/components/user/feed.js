import React from 'react';
import Button from '@material-ui/core/Button';

import { sessionHelper } from '../../helpers/session';
import { withRouter } from "react-router-dom";
import { nanoAPI } from '../../nanoAPI'

function Feed() {
  return (
    <div>
      <h1>Successful</h1>
      <LogoutButton />
    </div>
  )
}

const LogoutButton = withRouter(
  function({ history }) {
    return (
      <Button
        type="submit"
        variant="contained"
        color="primary"
        onClick={(e)=>{
          e.preventDefault();
          nanoAPI.logout(
            function() {
              sessionHelper.logout();
              history.push("/login");
            },
            function() {
              alert("Fail!");
            }
          )
        }}
      >
        Sign out
      </Button>
    )
  }
);

export default Feed;
