import React from 'react';
import AppContainer from './general/appContainer'
import UserTimeline from './user/timeline'

function UserHome(props) {

  return (
    <AppContainer>
      <UserTimeline />
    </AppContainer>
  );
}

export default UserHome;
