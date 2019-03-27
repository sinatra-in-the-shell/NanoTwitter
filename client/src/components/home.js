import React from 'react';
import Navbar from './general/navbar'
import UserTimeline from './user/timeline'

function UserHome(props) {

  return (
    <div>
      <Navbar />
      <UserTimeline />
    </div>
  );
}

export default UserHome;
