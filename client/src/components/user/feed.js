import React from 'react';
import Button from '@material-ui/core/Button';

import { sessionHelper } from '../../helpers/session'

function Feed() {
  return (
    <div>
      <h1>Successful</h1>
      <Button
        type="submit"
        fullWidth
        variant="contained"
        color="primary"
        onClick={(e)=>{
          e.preventDefault();
          sessionHelper.logout();
        }}
      >
        Sign out
      </Button>
    </div>
  )
}

export default Feed;
